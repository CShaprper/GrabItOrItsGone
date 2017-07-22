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

class FirebaseClient: IFirebaseWebService {
    var delegate: IFirebaseWebService?
    private var ref:DatabaseReference!
    private var refhandle:UInt!
    internal let firebaseURL:String = "https://grabitoritsgone.firebaseio.com/"
    private var isCalled:Bool = false
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        ref = Database.database().reference(fromURL: firebaseURL)
    }
    
    //MARK: - IFirebaseWebService implementation
    func FirebaseRequestStarted() {
        if delegate != nil{
            DispatchQueue.main.async {
                self.delegate!.FirebaseRequestStarted!()
            }
        } else {
            print("IFirebaseWebService delegate not set from calling class")
        }
    }
    func FirebaseRequestFinished() {
        if delegate != nil{
            DispatchQueue.main.async {
                self.delegate!.FirebaseRequestFinished!()
            }
        } else {
            print("IFirebaseWebService delegate not set from calling class")
        }
    }
    func AlertFromFirebaseService(title: String, message: String) {
        if delegate != nil{
            DispatchQueue.main.async {
                self.delegate!.AlertFromFirebaseService!(title: title, message: message)
            }
        } else {
            print("IFirebaseWebService delegate not set from calling class")
        }
    }
    
    //MARK:- Firebase Auth Section
    func CreateNewAutenticableUser(email: String, password: String) {
        self.isCalled = false
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.FirebaseRequestFinished()
                    let title = String.FirebaseUserAuthenticationErrorMessage_TitleString
                    let message = String.FirebaseUserAuthenticationErrorMessage_MessageString
                    self.AlertFromFirebaseService(title: title, message: message)
                }
                return
            } else {
                self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
                self.FirebaseRequestFinished()
                print("Succesfully created new Firebase User")
                self.SetCategorysToTrueOnFirstLogin()
            }
        })
    }
    func LoginAuthenticableUser(email: String, password: String) {
        self.isCalled = false
        self.FirebaseRequestStarted()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    self.FirebaseRequestFinished()
                    let title = String.FirebaseUserLoginErrorAlert_TitleString
                    let message = String.FirebaseUserLoginErrorAlert_MessageString
                    self.AlertFromFirebaseService(title: title, message: message)
                }
                return
            } else {
                self.FirebaseRequestFinished()
                UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
                self.SetCategorysToTrueOnFirstLogin()
                self.RecognizeAdmin(email: email)
                print("Succesfully loged user in to Firebase")
            }
        }
        
    }
    private func RecognizeAdmin(email: String)
    {
        if email == "p.sypek@icloud.com" || email == "sypekpeter@gmail.com" || email == "peter.sypek@gmx.de"{
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isAdmin.rawValue)
        } else {
            UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isAdmin.rawValue)
        }
    }
    func ResetUserPassword(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                print(error!.localizedDescription)
                self.FirebaseRequestFinished()
                let title = String.FirebaseResetPasswordErrorAlert_TitleString
                let message = String.FirebaseResetPasswordErrorAlert_MessageString
                self.AlertFromFirebaseService(title: title, message: message)
                return
            }
            print("Succesfully sent password reset mail")
            return
        }
        
    }
    func LoginWithGoogle(guser: GIDGoogleUser) -> Void {
        self.isCalled = false
        self.FirebaseRequestStarted()
        let credential = GoogleAuthProvider.credential(withIDToken: guser.authentication.idToken, accessToken: guser.authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                self.SetUserDefualtsLoggedInKeysToFalse()
                self.FirebaseRequestFinished()
                let title = String.FirebaseThirdPartyLoginErrorAlert_TitleString
                let message = String.FirebaseThirdPartyLoginErrorAlert_MessageString
                self.AlertFromFirebaseService(title: title, message: message)
                return
            } else {
                UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isLoggedInWithGoogle.rawValue)
                print("User logged in with Google")
                self.SetCategorysToTrueOnFirstLogin()
                self.RecognizeAdmin(email: user!.email!)
                self.FirebaseRequestFinished()
                self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
            }
        }
    }
    func LoginWithInstagram(controller: UIViewController, customToken: String){
        self.isCalled = false
        self.FirebaseRequestStarted()
        let token = customToken.replacingOccurrences(of: "access_token=", with: "")
        print(token)
        
        Auth.auth().signIn(withCustomToken: token) { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                self.FirebaseRequestFinished()
                self.SetUserDefualtsLoggedInKeysToFalse()
                let title = String.FirebaseThirdPartyLoginErrorAlert_TitleString
                let message = String.FirebaseThirdPartyLoginErrorAlert_MessageString
                self.AlertFromFirebaseService(title: title, message: message)
                return
            } else {
                print("User logged in with Instagram")
                self.SetCategorysToTrueOnFirstLogin()
                UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isLoggedInWithInstagram.rawValue)
                self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
            }
        }
    }
    func LoginWithFacebook(controller: UIViewController) -> Void {
        self.isCalled = false
        self.FirebaseRequestStarted()
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: controller)
        { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.SetUserDefualtsLoggedInKeysToFalse()
                self.FirebaseRequestFinished()
                let title = String.FirebaseThirdPartyLoginErrorAlert_TitleString
                let message = String.FirebaseThirdPartyLoginErrorAlert_MessageString
                self.AlertFromFirebaseService(title: title, message: message)
                return
            }
            self.isCalled = false
            if FBSDKAccessToken.current() != nil{
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if error != nil{
                        print(error!.localizedDescription)
                        self.FirebaseRequestFinished()
                        let title = String.FirebaseThirdPartyLoginErrorAlert_TitleString
                        let message = String.FirebaseThirdPartyLoginErrorAlert_MessageString
                        self.AlertFromFirebaseService(title: title, message: message)
                        return
                    }else {
                        print("User logged in with Facebook")
                        self.SetCategorysToTrueOnFirstLogin()
                        self.FirebaseRequestFinished()
                        self.RecognizeAdmin(email: user!.email!)
                        UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isLoggedInWithFacebook.rawValue)
                        self.SaveNewUserWithUIDtoFirebase(user: user, firebaseURL: self.firebaseURL)
                    }
                }
            }
            self.FirebaseRequestFinished()
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
    func LogInAsGuest() -> Void{
        let token:[String:AnyObject] = [Messaging.messaging().fcmToken!:Messaging.messaging().fcmToken as AnyObject]
        print(token)
        ref.child("fcmToken").child(Messaging.messaging().fcmToken!).setValue(token)
    }
    func LogoutAuthenticableUser() {
        self.isCalled = false
        let auth = Auth.auth()
        GIDSignIn.sharedInstance().signOut()
        FBSDKLoginManager().logOut()
        SetUserDefualtsLoggedInKeysToFalse()
        do{
            try  auth.signOut()
            self.FirebaseRequestFinished()
            self.SetUserDefualtsLoggedInKeysToFalse()
            print("Succesfully logged out")
            self.isCalled = false
        }
        catch let error as NSError{
            print(error.localizedDescription)
            self.FirebaseRequestFinished()
            let title = String.FirebaseUserLogoutErrorAlert_TitleString
            let message = String.FirebaseUserLogoutErrorAlert_MessageString
            self.AlertFromFirebaseService(title: title, message: message)
        }
        
    }
    func AddUserStateListener() -> Void {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                if !self.isCalled{
                    print("State listener detected user loged in")
                    self.SetUserDefualtsLoggedInKeysToFalse()
                    NotificationCenter.default.post(name: NSNotification.Name.SegueToMainController, object: nil)
                    self.isCalled = true
                }
            } else {
                FBSDKLoginManager().logOut()
                self.SetUserDefualtsLoggedInKeysToFalse()
                print("State listener detected user loged out")
                NotificationCenter.default.post(name: NSNotification.Name.SegueToLogInController, object: nil)
            }
        }
    }
    private func SetCategorysToTrueOnFirstLogin(){
        UserDefaults.standard.set(true, forKey: eProductCategory.Electronic.rawValue)
        UserDefaults.standard.set(true, forKey: eProductCategory.Clothes.rawValue)
        UserDefaults.standard.set(true, forKey: eProductCategory.Jewelry.rawValue)
        UserDefaults.standard.set(true, forKey: eProductCategory.Cosmetics.rawValue)
    }
    private func SetUserDefualtsLoggedInKeysToFalse(){
        UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
        UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInWithInstagram.rawValue)
        UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInWithGoogle.rawValue)
        UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isLoggedInWithFacebook.rawValue)
    }
    
    
    //MARK: - Firebase read functions
    func ReadFirebaseNewsSection() -> Void{
        ref.child("news").observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject]{
                print(dict)
                let news = News()
                news.date = dict["date"] as? String != nil ? self.FormatStringToDate(strDate: (dict["date"] as? String)!) : ""
                news.title = dict["title"] as? String != nil ? dict["title"] as? String : ""
                news.message = dict["message"] as? String != nil ? dict["message"] as? String : ""
                self.RefreshNewsArray(news: news)
                self.FirebaseRequestFinished()
            }
        })
    }
    private func RefreshNewsArray(news: News){
        if newsArray.contains(news){
            //Update array todo: überarbeiten
            if let index = newsArray.index(of: news){
                newsArray[index].date = news.date != nil ? news.date! : ""
                newsArray[index].message = news.message != nil ? news.message! : ""
                newsArray[index].title  = news.title != nil ? news.title! : ""
                return
            }
        } else {
            newsArray.append(news)
        }
    }
    private func FormatStringToDate(strDate: String) -> String{
        //Format Date
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd.MM.yyyy"
        let date = formatter.date(from: strDate)
        formatter.dateFormat = "eee dd. MMMM yyyy"
        print(formatter.string(from: date!))
        return formatter.string(from: date!)
    }
    func ReadFirebaseFavoritesSection(){
        if let uid = Auth.auth().currentUser?.uid{
            ref.child("favorites").child(uid).observe(.childAdded, with: { (snapshot) in
                if let dict = snapshot.value as? [String:AnyObject]{
                    print(dict)
                    var product = ProductCard()
                    product = self.SetProductCardValues(dict: dict, product: product)
                   self.RefreshFavoritesArray(product: product)
                    self.FirebaseRequestFinished()
                    if let imgURL = product.ImageURL{
                        self.DownloadImages(url: imgURL, product: product, array:  favoritesArray)
                    }
                }
            })
        }
    }
    private func RefreshFavoritesArray(product: ProductCard){
        if let index = favoritesArray.index(where: {$0.ID == product.ID}){
            //Update array
            favoritesArray[index].ID = product.ID
            favoritesArray[index].ImageURL = product.ImageURL
            favoritesArray[index].NewPrice = product.NewPrice
            favoritesArray[index].OriginalPrice = product.OriginalPrice
            favoritesArray[index].ProdcutImage = product.ProdcutImage
            favoritesArray[index].ProductCategory = product.ProductCategory
            favoritesArray[index].Productinformation = product.Productinformation
            favoritesArray[index].Subtitle = product.Subtitle
            favoritesArray[index].Title = product.Title
            favoritesArray[index].AddedToFavorites = product.AddedToFavorites
            return
        }
        favoritesArray.append(product)
    }
    
    func ReadFirebaseProductsSection() -> Void{
        ref.child("products").observe(.value, with: { (snapshot) in
            if snapshot.value is NSNull{
                return
            }
            for category in snapshot.children{//Iterate each category
                let cat = category as! DataSnapshot
                if let dict = snapshot.value as? [String: AnyObject]{
                    if UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue){
                        self.ReadProductsOfCategory(category: cat)
                        return
                    }
                    if dict.index(forKey: eProductCategory.Electronic.rawValue) != nil {//Check that category exists
                        print(cat.key)
                        if UserDefaults.standard.bool(forKey: eProductCategory.Electronic.rawValue) && cat.key == eProductCategory.Electronic.rawValue {
                            self.ReadProductsOfCategory(category: cat)
                        }
                    }
                    if dict.index(forKey: eProductCategory.Cosmetics.rawValue) != nil {
                        print(cat.key)
                        if UserDefaults.standard.bool(forKey: eProductCategory.Cosmetics.rawValue) && cat.key == eProductCategory.Cosmetics.rawValue {
                            self.ReadProductsOfCategory(category: cat)
                        }
                    }
                    if dict.index(forKey: eProductCategory.Jewelry.rawValue) != nil {
                        print(cat.key)
                        if UserDefaults.standard.bool(forKey: eProductCategory.Jewelry.rawValue) && cat.key == eProductCategory.Jewelry.rawValue {
                            self.ReadProductsOfCategory(category: cat)
                        }
                    }
                    if dict.index(forKey: eProductCategory.Clothes.rawValue) != nil {
                        print(cat.key)
                        if UserDefaults.standard.bool(forKey: eProductCategory.Clothes.rawValue) && cat.key == eProductCategory.Clothes.rawValue {
                            self.ReadProductsOfCategory(category: cat)
                        }
                    }
                }
            }//end: for category in snapshot.children
        })
    }
    private func ReadProductsOfCategory(category: DataSnapshot){
        for prod in category.children{//Iterate each product in Category
            let p = prod as! DataSnapshot //Get Product snapshot
            if let dic = p.value as? [String: AnyObject]{
                var product = ProductCard()
                product = self.SetProductCardValues(dict: dic, product: product)
                self.RefreshProductsArray(product: product)
                self.FirebaseRequestFinished()
                if let imgURL = product.ImageURL{
                    self.DownloadImages(url: imgURL, product: product, array:  productsArray)
                }
            }
        }
    }
    private func RefreshProductsArray(product: ProductCard){
        if let index = productsArray.index(where: {$0.ID == product.ID}){
            //Update array
            productsArray[index].ID = product.ID
            productsArray[index].ImageURL = product.ImageURL
            productsArray[index].NewPrice = product.NewPrice
            productsArray[index].OriginalPrice = product.OriginalPrice
            productsArray[index].ProdcutImage = product.ProdcutImage
            productsArray[index].ProductCategory = product.ProductCategory
            productsArray[index].Productinformation = product.Productinformation
            productsArray[index].Subtitle = product.Subtitle
            productsArray[index].Title = product.Title
            productsArray[index].AddedToFavorites = product.AddedToFavorites
            return
        }
        productsArray.append(product)
    }
    private func SetProductCardValues(dict: [String:AnyObject], product: ProductCard) -> ProductCard{
        let id:String = dict["id"] as? String != nil ? (dict["id"] as? String)! : ""
        let title:String = dict["title"] as? String != nil ? (dict["title"] as? String)! : ""
        let subtitle:String = dict["subtitle"] as? String != nil ? (dict["subtitle"] as? String)! : ""
        let newPrice:Double = dict["newprice"] as? Double != nil ? (dict["newprice"] as? Double)! : 0
        let originalPrice:Double = dict["originalprice"] as? Double != nil ? (dict["originalprice"] as? Double)! : 0
        let productinformation:String = dict["productinformation"] as? String != nil ?  (dict["productinformation"] as? String)! : ""
        let productCategory:String = dict["category"] as? String != nil ? (dict["category"] as? String)! : ""
        let imageURL:String = dict["imageURL"] as? String != nil ? (dict["imageURL"] as? String)! : ""
        product.ID = id
        product.Title = title
        product.Subtitle = subtitle
        product.NewPrice = newPrice
        product.OriginalPrice = originalPrice
        product.Productinformation = productinformation
        product.ProductCategory = productCategory
        product.ImageURL = imageURL
        product.ProdcutImage = #imageLiteral(resourceName: "Image-placeholder")
        return product
    }
    private func DownloadImages(url: String, product: ProductCard, array: [ProductCard]){
        if let index = imageCache.index(where: { $0.ImageURL == url }) {
            for prod in array{
                if prod.ImageURL == imageCache[index].ImageURL!{
                    print("ProdcutImage set from ImageCache!")
                    prod.ProdcutImage = imageCache[index].Image!
                    break
                }
            }
        } else {
            loadImageUsingCacheWithURLString(urlString: url, array: array)
        }
    }
    func loadImageUsingCacheWithURLString(urlString: String, array: [ProductCard]) -> Void {
        let url = URL(string: urlString)!
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!){
                    var tempProd = TempProductCard()
                    tempProd.Image = downloadImage
                    tempProd.ImageURL = urlString
                    imageCache.append(tempProd)
                    print("Added Image to imageChache!")
                    for prod in array{
                        if prod.ImageURL == urlString{
                            prod.ProdcutImage = downloadImage
                            print("ProdcutImage set from Download!")
                            self.FirebaseRequestFinished()
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    private func FormatDateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "d.MMMM.yyyy"
        return formatter.string(from: date)
    }
    
    //MARK: - Firebase save functions
    func SaveProductToFirebaseFavorites(product: ProductCard) -> Void {
        if let uid = Auth.auth().currentUser?.uid{
            let userRef = ref.child("favorites").child(uid)
            let key = userRef.child(product.ID!).key
            let values = ["id":key, "title":product.Title!, "subtitle":product.Subtitle!, "productinformation":product.Productinformation!, "newprice":product.NewPrice!, "originalprice":product.OriginalPrice!, "imageURL":product.ImageURL!, "dateAdded":FormatDateToString(date: Date())] as [String : Any]
            userRef.child(key).updateChildValues(values, withCompletionBlock: { (error, databaseref) in
                if error != nil{
                    print(error!.localizedDescription)
                }
                print("Succesfully saved Product to Firebase Favorites")
            })
        }
    }
    func SaveNewProdcutAsAdmin(product: ProductCard, productImage: UIImage) -> Void{
        //Image Upload
        let imagesRef = Storage.storage().reference().child(product.ID!)
        self.FirebaseRequestStarted()
        if let uploadData = productImage.mediumQualityJPEGNSData{
            let _ = imagesRef.putData(uploadData as Data, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    self.FirebaseRequestFinished()
                    let title = String.FirebaseImageUploadErrorAlert_TitleString
                    let message = String.FirebaseImageUploadErrorAlert_MessageString
                    self.AlertFromFirebaseService(title: title, message: message)
                    return
                }
                DispatchQueue.main.async {
                    print(metadata ?? "")
                    if let imgURL =  metadata?.downloadURL()?.absoluteString{
                        let values = ["id":product.ID!, "category":product.ProductCategory!, "title":product.Title!, "subtitle":product.Subtitle!, "productinformation":product.Productinformation!, "newprice":product.NewPrice!, "originalprice":product.OriginalPrice!, "imageURL": imgURL] as [String : Any]
                        product.ImageURL = imgURL
                        self.RegisterProductIntoFirebase(product: product, values: values)
                    }
                    print("Successfully uploaded prodcut image!")
                }//end: Dispatch Queue
            }) // end: let _ = imagesRef.putData
        }//end: if let let uploadData
    }
    private func RegisterProductIntoFirebase(product: ProductCard, values: [String : Any]){
        let productRef = self.ref.child("products")
        let categoryRef = productRef.child(product.ProductCategory!)
        let idRef = categoryRef.child(product.ID!).key
        categoryRef.child(idRef).updateChildValues(values, withCompletionBlock: { (error, dbref) in
            if error != nil{
                print(error!.localizedDescription)
                self.FirebaseRequestFinished()
                let title = String.FirebaseImageUploadErrorAlert_TitleString
                let message = String.FirebaseImageUploadErrorAlert_MessageString
                self.AlertFromFirebaseService(title: title, message: message)
            }
            print("Succesfully added Prodcut Data with imageURL")
        })
        
    }
    private func SaveNewUserWithUIDtoFirebase(user: User?, firebaseURL: String){
        DispatchQueue.main.async {
            guard let uid = user?.uid else{
                return
            }
            let token:[String:AnyObject] = [Messaging.messaging().fcmToken!:Messaging.messaging().fcmToken as AnyObject]
            print(token)
            let usersReference = self.ref.child("users").child(uid)
            let values = (["name": user!.displayName, "email": user!.email])
            usersReference.updateChildValues(values as Any as! [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                if err != nil{
                    self.FirebaseRequestFinished()
                    print(err!.localizedDescription)
                    return
                } else {
                    self.FirebaseRequestFinished()
                    print("Succesfully saved user to Firebase")
                    self.SetUserDefualtsLoggedInKeysToFalse()
                    self.ref.child("fcmToken").child(Messaging.messaging().fcmToken!).setValue(token)
                }
            })
        }
    }
    
    //MARK: - Firebase Delete functions
    func DeleteProductFromFirebaseFavorites(idToDelete: String)->Void{
        if let uid = Auth.auth().currentUser?.uid{
            let userRef = ref.child("favorites").child(uid)
            // favRef.child(idToDelete)
            userRef.child(idToDelete).removeValue(completionBlock: { (error, database) in
                if error != nil{
                    print(error!.localizedDescription)
                    let title = String.FirebaseDeleteErrorAlert_TitleString
                    let message = String.FirebaseDeleteErrorAlert_MessageString
                    self.AlertFromFirebaseService(title: title, message: message)
                }
                self.FirebaseRequestFinished()
                print("Succesfully deleted Favorite from Firebase")
            })
        } // No uid for current User
    }
}
