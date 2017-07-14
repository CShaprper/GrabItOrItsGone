//
//  FirebaseClient.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import OAuthSwift

class FirebaseClient: IAuthenticalbe, IActivityAnimationDelegate, IFirebaseDataReceivedDelegate, IAlertMessageDelegate {
    var alertMessageDelegate: IAlertMessageDelegate?
    var firebaseDataReceivedDelegate:IFirebaseDataReceivedDelegate?
    var activityAnimationDelegate:IActivityAnimationDelegate?
    private var ref:DatabaseReference!
    private var refhandle:UInt!
    let firebaseURL:String = "https://grabitoritsgone.firebaseio.com/"
    var isCalled:Bool = false
    
    init() {
        ref = Database.database().reference()
    }
    
    func ShowAlertMessage(title: String, message: String)->Void{
        if self.alertMessageDelegate != nil{
            self.alertMessageDelegate!.ShowAlertMessage(title: title, message: message)
        } else {
            print("alertMessageDelegate not set from calling class")
        }
    }
    
    func StartActivityAnimation() {
        if activityAnimationDelegate != nil{
            activityAnimationDelegate!.StartActivityAnimation()
        } else {
            print("activityAnimationDelegate not set from calling class")
        }
    }
    func StopActivityAnimation() {
        if activityAnimationDelegate != nil{
            activityAnimationDelegate!.StopActivityAnimation()
        } else {
            print("activityAnimationDelegate not set from calling class")
        }
    }
    
    //MARK: IAuthenticable implementtation
    func CreateNewAutenticableUser(email: String, password: String) {
        self.isCalled = false
        self.StartActivityAnimation()
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    let title = String.FirebaseUserAuthenticationErrorMessage_TitleString
                    let message = String.FirebaseUserAuthenticationErrorMessage_MessageString
                    self.ShowAlertMessage(title: title, message: message)
                }
                return
            }
            self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
            self.StopActivityAnimation()
            print("Succesfully created new Firebase User")
        })
    }
    func LoginAuthenticableUser(email: String, password: String) {
        self.isCalled = false
        self.StartActivityAnimation()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.StopActivityAnimation()
                    let title = String.FirebaseUserLoginErrorAlert_TitleString
                    let message = String.FirebaseUserLoginErrorAlert_MessageString
                    self.ShowAlertMessage(title: title, message: message)
                }
                return
            }
            self.StopActivityAnimation()
            UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
            print("Succesfully loged user in to Firebase")
        }
        
    }
    
    func ResetUserPassword(email:String){
        self.StartActivityAnimation()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.StopActivityAnimation()
                    let title = String.FirebaseResetPasswordErrorAlert_TitleString
                    let message = String.FirebaseResetPasswordErrorAlert_MessageString
                    self.ShowAlertMessage(title: title, message: message)
                    return
                }
            }
            print("Succesfully sent password reset mail")
            return
        }
        
    }
    
    func LoginWithGoogle(guser: GIDGoogleUser) -> Void {
        self.isCalled = false
        self.StartActivityAnimation()
        let credential = GoogleAuthProvider.credential(withIDToken: guser.authentication.idToken, accessToken: guser.authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.StopActivityAnimation()
                    let title = String.FirebaseThirdPartyLoginErrorAlert_TitleString
                    let message = String.FirebaseThirdPartyLoginErrorAlert_MessageString
                    self.ShowAlertMessage(title: title, message: message)
                    return
                }
            }
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isLoggedInWithGoogle.rawValue)
            print("User logged in with Google")
            self.StopActivityAnimation()
            self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
        }
    }
    
    func LoginWithInstagram(controller: UIViewController){
        self.isCalled = false
        self.StartActivityAnimation()
        let oauthSwift = OAuth2Swift(consumerKey: "d9b8a7748ca744aca7894f0044d09545", consumerSecret: "4c37f561b15f4f7596b6970e4d6e6ff3 ", authorizeUrl: "https://api.instagram.com/oauth/authorize", responseType:   "token")
        let handle = oauthSwift.authorize(withCallbackURL: URL(string: "http://localhost:8080/instagram-callback")!, scope: "likes+comments", state:"INSTAGRAM", success: {
            credential, response, parameters in
            print(credential.oauthToken)
            // Do your request
        },
            failure: { error in
                print(error.localizedDescription)
        })
    }
    
    
    func LoginWithFacebook(controller: UIViewController) -> Void {
        self.isCalled = false
        self.StartActivityAnimation()
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: controller)
        { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.StopActivityAnimation()
                let title = String.FirebaseThirdPartyLoginErrorAlert_TitleString
                let message = String.FirebaseThirdPartyLoginErrorAlert_MessageString
                self.ShowAlertMessage(title: title, message: message)
                return
            }
            self.isCalled = false
            if FBSDKAccessToken.current() != nil{
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if error != nil{
                        print(error!.localizedDescription)
                        DispatchQueue.main.async {
                            self.StopActivityAnimation()
                            let title = String.FirebaseThirdPartyLoginErrorAlert_TitleString
                            let message = String.FirebaseThirdPartyLoginErrorAlert_MessageString
                            self.ShowAlertMessage(title: title, message: message)
                            return
                        }
                    }
                    print("User logged in with Facebook")
                    UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
                    UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isLoggedInWithFacebook.rawValue)
                    self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
                }
            }
            self.StopActivityAnimation()
            /* FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, first_name, last_name, picture.type(large), name, email"]).start
             { (connection, result, error) in
             if error != nil{
             print("Custom Facebook Login error: \(error!.localizedDescription)")
             //todo show message
             return
             }
             print(result!)
             let name = ((result as! NSDictionary).value(forKey: "name")) as! String
             let email = ((result as! NSDictionary).value(forKey: "email")) as! String
             let last_name = ((result as! NSDictionary).value(forKey: "last_name")) as! String
             print(name, email, last_name)
             /*picture =     {
             data =         {
             "is_silhouette" = 0;
             url = "...";
             };
             };*/
             }*/
        }
    }
    
    func LogoutAuthenticableUser() {
        self.isCalled = false
        self.StartActivityAnimation()
        let auth = Auth.auth()
        GIDSignIn.sharedInstance().signOut()
        FBSDKLoginManager().logOut()
        UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInWithFacebook.rawValue)
        UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInWithGoogle.rawValue)
        do{
            try  auth.signOut()
            self.StopActivityAnimation()
            UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
            print("Succesfully logged out")
            self.isCalled = false
        }
        catch let error as NSError{
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.StopActivityAnimation()
                let title = String.FirebaseUserLogoutErrorAlert_TitleString
                let message = String.FirebaseUserLogoutErrorAlert_MessageString
                self.ShowAlertMessage(title: title, message: message)
            }
        }
        
    }
    
    func AddUserStateListener() -> Void {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                if !self.isCalled{
                    print("State listener detected user loged in")
                    UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
                    NotificationCenter.default.post(name: NSNotification.Name.SegueToMainController, object: nil)
                    self.isCalled = true
                }
            } else {
                FBSDKLoginManager().logOut()
                print("State listener detected user loged out")
                UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
                NotificationCenter.default.post(name: NSNotification.Name.SegueToLogInController, object: nil)
            }
        }
    }
    
    
    var newsArray = [News]()
    func ReadFirebaseNewsSection() -> Void{
        ref.child("news").observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject]{
                print(dict)
                let news = News()
                
                //Format Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "de_DE")
                formatter.dateFormat = "d.M.yyyy"
                let date = dict["date"] as? String
                if date != nil{
                    let newDate = formatter.date(from: date!)
                    formatter.dateFormat = "d. MMMM yyyy"
                    news.date = formatter.string(from: newDate!)
                }
                //Set News properties
                news.title = dict["title"] as? String
                news.message = dict["message"] as? String
                print(news.title!)
                print(news.message!)
                self.newsArray.append(news)
                
                DispatchQueue.main.async {
                    self.FirebaseDataReceived()
                }
                
            }
        })
    }
    
    func FirebaseDataReceived() {
        if self.firebaseDataReceivedDelegate != nil{
            self.firebaseDataReceivedDelegate!.FirebaseDataReceived()
        } else {
            print("firebaseDataReceivedDelegate not set from calling class")
        }
    }
    
    private func SaveNewUserWithUIDtoFirebase(user: User?, firebaseURL: String){
        DispatchQueue.main.async {
            guard let uid = user?.uid else{
                return
            }
            
            let ref = Database.database().reference(fromURL: firebaseURL)
            let usersReference = ref.child("users").child(uid)
            let values = (["name": user!.displayName, "email": user!.email])
            usersReference.updateChildValues(values as Any as! [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                if err != nil{
                    print(err!.localizedDescription)
                    return
                }
                //self.Post_StopActivityAnimation_Notification()
                print("Succesfully saved user to Firebase")
                UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
            })
        }
    }
}
