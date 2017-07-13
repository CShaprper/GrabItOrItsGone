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

class FirebaseClient: IAuthenticalbe, IActivityAnimationDelegate, IFirebaseDataReceivedDelegate {
    private var presentingController:UIViewController!
    private var alert:IAlertMessage?
    private var ref:DatabaseReference!
    private var refhandle:UInt!
    let firebaseURL:String = "https://grabitoritsgone.firebaseio.com/"
    var alertMessageDelegate:IAlertMessageDelegate?
    var activityAnimationDelegate: IActivityAnimationDelegate?
    var firebaseDataReceivedDelegate:IFirebaseDataReceivedDelegate?
    var isCalled:Bool = false
    
    init() {
        ref = Database.database().reference()
    }
    
    func ShowAlertMessage(title: String, message: String)->Void{
        if alertMessageDelegate != nil{
            alertMessageDelegate!.ShowAlertMessage!(title: title, message: message)
        }
    }
    
    func StartActivityAnimation() {
        if activityAnimationDelegate != nil{
            activityAnimationDelegate!.StartActivityAnimation!()
        }
    }
    func StopActivityAnimation() {
        if activityAnimationDelegate != nil{
            activityAnimationDelegate!.StopActivityAnimation!()
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
                    self.ShowAlertMessage(title:self.presentingController.view.FirebaseUserAuthenticationErrorMessage_TitleString, message: self.presentingController.view.FirebaseUserAuthenticationErrorMessage_MessageString)
                    self.StopActivityAnimation()
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
                    self.ShowAlertMessage(title:self.presentingController.view.FirebaseUserLoginErrorAlert_TitleString, message: self.presentingController.view.FirebaseUserLoginErrorAlert_MessageString)
                }
                return
            }
            self.StopActivityAnimation()
            UserDefaults.standard.set(false, forKey: "isLoggedInAsGuest")
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
                    self.ShowAlertMessage(title:self.presentingController.view.FirebaseResetPasswordErrorAlert_TitleString, message:  self.presentingController.view.FirebaseResetPasswordErrorAlert_MessageString)
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
                    self.ShowAlertMessage(title:self.presentingController.view.FirebaseThirdPartyLoginErrorAlert_TitleString, message: self.presentingController.view.FirebaseThirdPartyLoginErrorAlert_MessageString)
                    return
                }
            }
            UserDefaults.standard.set(true, forKey: "isLoggedInWithGoogle")
            print("User logged in with Google")
            self.StopActivityAnimation()
            self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
        }
    }
    
    
    func LoginWithFacebook(controller: UIViewController) -> Void {
        self.isCalled = false
        self.StartActivityAnimation()
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: controller)
        { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.StopActivityAnimation()
                self.ShowAlertMessage(title:self.presentingController.view.FirebaseThirdPartyLoginErrorAlert_TitleString, message: self.presentingController.view.FirebaseThirdPartyLoginErrorAlert_MessageString)
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
                            self.ShowAlertMessage(title:self.presentingController.view.FirebaseThirdPartyLoginErrorAlert_TitleString, message: self.presentingController.view.FirebaseThirdPartyLoginErrorAlert_MessageString)
                            return
                        }
                    }
                    print("User logged in with Facebook")
                    UserDefaults.standard.set(false, forKey: "isLoggedInAsGuest")
                    UserDefaults.standard.set(true, forKey: "isLoggedInWithFacebook")
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
        UserDefaults.standard.set(false, forKey: "isLoggedInWithFacebook")
        UserDefaults.standard.set(false, forKey: "isLoggedInWithGoogle")
        do{
            try  auth.signOut()
            self.StopActivityAnimation()
            UserDefaults.standard.set(false, forKey: "isLoggedInAsGuest")
            print("Succesfully logged out")
            self.isCalled = false
        }
        catch let error as NSError{
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.StopActivityAnimation()
                self.ShowAlertMessage(title:self.presentingController.view.FirebaseUserLogoutErrorAlert_TitleString, message: self.presentingController.view.FirebaseUserLogoutErrorAlert_MessageString)
            }
        }
        
    }
    
    func AddUserStateListener() -> Void {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                if !self.isCalled{
                    print("State listener detected user loged in")
                    UserDefaults.standard.set(false, forKey: "isLoggedInAsGuest")
                    NotificationCenter.default.post(name: NSNotification.Name.SegueToMainController, object: nil)
                    self.isCalled = true
                }
            } else {
                FBSDKLoginManager().logOut()
                print("State listener detected user loged out")
                UserDefaults.standard.set(false, forKey: "isLoggedInAsGuest")
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
                    if self.firebaseDataReceivedDelegate != nil{
                        self.firebaseDataReceivedDelegate!.FirebaseDataReceived!()
                    }
                }
                
            }
        })
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
                UserDefaults.standard.set(false, forKey: "isLoggedInAsGuest")
            })
        }
    }
}
