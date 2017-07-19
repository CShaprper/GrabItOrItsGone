//
//  ViewController.swift
//  GrabIt
//
//  Created by Peter Sypek on 23.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import Foundation
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn
import OAuthSwift


class LogInSignUpController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate, IFirebaseWebService, IAlertMessageDelegate, UIWebViewDelegate  {
    //MARK: - Outlets
    @IBOutlet var lbl_GrabIt_Header: UILabel!
    @IBOutlet var LogInSignUpBGImage: UIImageView!
    @IBOutlet var lbl_Subtitle: UILabel!
    @IBOutlet var btn_SignUp: DesignableUIButton!
    @IBOutlet var btn_Login: DesignableUIButton!
    @IBOutlet var btn_Guest: DesignableUIButton!
    @IBOutlet var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var btn_CustomFacebookLogin: DesignableUIButton!
    @IBOutlet var btn_CustomGoogleLogin: DesignableUIButton!
    @IBOutlet var btn_CustomInstagramLogin: UIButton!
    //Login PopUp
    @IBOutlet var LoginPopUp: UIView!
    @IBOutlet var PopUpBlurrScreenView: UIVisualEffectView!
    @IBOutlet var txt_Login_Email: DesignableTextField!
    @IBOutlet var txt_Login_Password: DesignableTextField!
    @IBOutlet var btn_LogIn_PopUp: DesignableUIButton!
    @IBOutlet var btn_SignUp_PopUp: DesignableUIButton!
    @IBOutlet var btn_PasswordForgotten: UIButton!
    @IBOutlet var LoginPopUpBackground: DesignableUIView!
    @IBOutlet var LoginPopUpLogoBackground: DesignableUIView!
    //Register PopUp
    @IBOutlet var RegisterPopUp: UIView!
    @IBOutlet var txt_Register_Email: DesignableTextField!
    @IBOutlet var txt_Register_Password: DesignableTextField!
    @IBOutlet var btn_Register_popUp: DesignableUIButton!
    @IBOutlet var RegisterPopUpBackground: DesignableUIView!
    @IBOutlet var RegisterPopUpLogoBackground: DesignableUIView!
    
    
    //MARK: - Members
    var facade:LoginSignUpFacade!
    let style = UIStyleHelper()
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var instagramLoginWebView : UIWebView?
    var success : ((URLRequest) -> Void)?
    var presentVC : UIViewController?
    
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
        facade.firebaseClient.delegate = self
        ValidationFactory.alertMessageDelegate = self
        facade.presentingController = self
    }
    
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        facade = LoginSignUpFacade()
        initAlertMessageDelegate(delegate: self)
        SetUpViews()
        AddNotificationListeners()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        facade.AddFirebaseUserStateListener()
        //Add views for Styling
        style.AddToViewsForStyling(views: [RegisterPopUpBackground, RegisterPopUpLogoBackground, btn_Register_popUp, btn_Guest, lbl_Subtitle, lbl_GrabIt_Header, btn_Login, btn_SignUp, LogInSignUpBGImage, LoginPopUpBackground, LoginPopUpLogoBackground, btn_LogIn_PopUp, txt_Register_Email, txt_Login_Password, txt_Login_Email, txt_Register_Password])
        
        //Set Style of UI
        if appDel.style != nil{
            style.ChangeStyle(uiStyle: appDel.style!)
        } else {
            style.ChangeStyle(uiStyle: .City)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        // Show the navigation bar so it will be there on other view controllers
        self.navigationController?.isNavigationBarHidden = false
        
        style.RemoveViewsForStyling(views: [RegisterPopUpBackground, RegisterPopUpLogoBackground, btn_Register_popUp, btn_Guest, lbl_Subtitle, lbl_GrabIt_Header, btn_Login, btn_SignUp, LogInSignUpBGImage, LoginPopUpBackground, LoginPopUpLogoBackground, btn_LogIn_PopUp, txt_Register_Email, txt_Login_Password, txt_Login_Email, txt_Register_Password])
    }
    
    
    //MARK: - GoogleSign In Button Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error.localizedDescription)
            return
        }
        facade.LoginFirebaseUserWithGoogle(guser: user)
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func txt_Login_Email_TextChanged(sender: DesignableTextField) -> Void {
        ValidationFactory.alertMessageDelegate = nil
        sender.RightImageVisibility = ValidationFactory.Validate(type: .email, validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .email)
    }
    func txt_Login_Password_TextChanged(sender: DesignableTextField) -> Void{
        ValidationFactory.alertMessageDelegate = nil
        sender.RightImageVisibility = ValidationFactory.Validate(type: .password, validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .password)
    }
    func txt_Register_Email_TextChanged(sender: DesignableTextField) -> Void {
        ValidationFactory.alertMessageDelegate = nil
        sender.RightImageVisibility = ValidationFactory.Validate(type: .email, validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .email)
    }
    func txt_Register_Password_TextChanged(sender:DesignableTextField) -> Void {
        ValidationFactory.alertMessageDelegate = nil
        sender.RightImageVisibility = ValidationFactory.Validate(type: .password, validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .password)
    }
    
    
    
    //MARK: - IActivityAnimationDelegate implementation
    func FirebaseRequestStarted() {
        view.insertSubview(ActivityIndicator, aboveSubview: RegisterPopUp)
        ActivityIndicator.alpha = 1
        ActivityIndicator.startAnimating()
        ActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        ActivityIndicator.transform = CGAffineTransform(translationX: view.center.x, y: 0)
    }
    func FirebaseRequestFinished() { 
        ActivityIndicator.stopAnimating()
        ActivityIndicator.alpha = 0
    }
    
    //MARK: - IAlertMessageDelegate implementation
    func ShowAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Wired Actions
    func btn_Login_Pressed(sender: UIButton) -> Void {
        view.addSubview(LoginPopUp)
        LoginPopUp.frame.size.height = 0.5 * view.frame.size.height
        LoginPopUp.frame.size.width = 0.9 * view.frame.size.width
        LoginPopUp.center = view.center
        LoginPopUp.alpha = 0
        LoginPopUp.HangingEffectBounce(duration: 0.7, delay: 0, spring: 0.25)
        PopUpBlurrScreenView.Arise(duration: 0.5, delay: 0, options: [.curveEaseOut], toAlpha: 1)
    }
    func PopUpBlurrScreenView_Touched(sender: UITapGestureRecognizer) -> Void {
        LoginPopUp.removeFromSuperview()
        RegisterPopUp.removeFromSuperview()
        PopUpBlurrScreenView.alpha = 0
    }
    func btn_SignUp_Pressed(sender: DesignableUIButton) -> Void {
        view.addSubview(RegisterPopUp)
        RegisterPopUp.frame.size.height = 0.5 * view.frame.size.height
        RegisterPopUp.frame.size.width = 0.9 * view.frame.size.width
        RegisterPopUp.center = view.center
        RegisterPopUp.alpha = 0
        RegisterPopUp.HangingEffectBounce(duration: 0.7, delay: 0, spring: 0.25)
        PopUpBlurrScreenView.Arise(duration: 0.5, delay: 0, options: [.curveEaseOut], toAlpha: 1)
    }
    func btn_SignUp_PopUp_Pressed(sender: DesignableUIButton) -> Void {
        ValidationFactory.alertMessageDelegate = self
        var isValid:Bool = false
        isValid = ValidationFactory.Validate(type: .email, validationString: txt_Register_Email.text)
        isValid = ValidationFactory.Validate(type: .password, validationString: txt_Register_Password.text)
        if isValid{
          facade.firebaseClient.CreateNewAutenticableUser(email: txt_Register_Email.text!, password: txt_Register_Password.text!)
        }
    }
    func btn_LogIn_PopUp_Pressed(sender: DesignableUIButton) -> Void {
        ValidationFactory.alertMessageDelegate = self
        var isValid:Bool = false
        isValid = ValidationFactory.Validate(type: .email, validationString: txt_Login_Email.text)
        isValid = ValidationFactory.Validate(type: .password, validationString: txt_Login_Password.text)
        if isValid{
            facade.firebaseClient.LoginAuthenticableUser(email: txt_Login_Email.text!, password: txt_Login_Password.text!)
        } 
    }
    func btn_Guest_Pressed(sender: DesignableUIButton){
        UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
        UserDefaults.standard.set(false, forKey: eUserDefaultKeys.isAdmin.rawValue)
        self.performSegue(withIdentifier: .SegueToMainController_Identifier, sender: nil)
    }
    func btn_PasswordForgotten_Pressed(sender:UIButton) -> Void {
        facade.ResetUserPassword(email: txt_Login_Email.text!)
    }
    func btn_FacebookLogin_Pressed(sender: UIButton) -> Void {
        facade.LoginFirebaseUserWithFacebook(controller:self)
    }
    func btn_CustomGoogleLogin_Pressed(sender: DesignableUIButton) -> Void {
        UserDefaults.standard.set(true, forKey: eUserDefaultKeys.isLoggedInWithGoogle.rawValue)
        GIDSignIn.sharedInstance().signIn()
    }
    func btn_CustomInstagramLogin_Pressed(sender: UIButton) -> Void{
        view.addSubview(instagramLoginWebView!)
        handle()
        //facade.LoginFirebaseUserWithInstagram(controller: self)
    }
    /* func doOAuthInstagram(){
     let oauthswift = OAuth2Swift(consumerKey:"d9b8a7748ca744aca7894f0044d09545", consumerSecret:"4c37f561b15f4f7596b6970e4d6e6ff3", authorizeUrl:   "https://api.instagram.com/oauth/authorize",responseType: "token")
     oauthswift.authorize(deviceToken: <#T##String#>, success: <#T##OAuthSwift.TokenRenewedHandler##OAuthSwift.TokenRenewedHandler##(OAuthSwiftCredential) -> Void#>, failure: <#T##OAuthSwiftHTTPRequest.FailureHandler##OAuthSwiftHTTPRequest.FailureHandler##(OAuthSwiftError) -> Void#>)
     oauthswift.authorize(withCallbackURL: "https://localhost:8080/instagram-callback", scope: "public_content", state: "INSTAGRAM", success: { (credential, response, parameters) in
     print(parameters["name"] ?? "")
     print("Instagram oauth_token:\(credential.oauthToken)")
     print(parameters)
     }) { (error) in
     
     }
     }*/
    
    
    func handle() {
        view.tag = 1 // Make sure our view and thus webview is loaded.
        let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
        let INSTAGRAM_CLIENT_ID = "d9b8a7748ca744aca7894f0044d09545"
        let INSTAGRAM_REDIRECT_URI = "https://localhost:8080/instagram-callback"
        let INSTAGRAM_SCOPE = "public_content"
        //let INSTAGRAM_CLIENT_SECRET = "&client_secret=4c37f561b15f4f7596b6970e4d6e6ff3"
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@", arguments:[INSTAGRAM_AUTHURL,INSTAGRAM_CLIENT_ID,INSTAGRAM_REDIRECT_URI, INSTAGRAM_SCOPE ])
        instagramLoginWebView!.loadRequest(URLRequest.init(url: URL.init(string: authURL)!))
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url?.fragment?.contains("access_token") == true {
            print(request.url ?? "")
            print(request.url?.fragment ?? "")
            facade.LoginFirebaseUserWithInstagram(controller: self, customToken: request.url?.fragment ?? "")
            webView.removeFromSuperview()
            return false
        }
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // If we stop on a page before the redirect closes us, user interaction is required.  Present.
        presentVC?.present(self, animated: true, completion: nil)
    }
    
    
    //MARK:- Wired actions from Notifications
    func SegueToMainController(notification: Notification) -> Void{
        txt_Register_Email.text = String()
        txt_Login_Email.text = String()
        txt_Login_Password.text = String()
        txt_Register_Password.text = String()
        performSegue(withIdentifier: .SegueToMainController_Identifier, sender: nil)
    }
    func KeyboardWillShow(notification: Notification) -> Void{
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            RegisterPopUp.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height * 0.33)
            LoginPopUp.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height * 0.33)
        }
    }
    func KeyboardWillHide(notification: Notification) -> Void{
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            RegisterPopUp.transform = CGAffineTransform(translationX: 0, y: keyboardSize.height * 0.33)
            LoginPopUp.transform = CGAffineTransform(translationX: 0, y: keyboardSize.height * 0.33)
        }
    }
    
    
    //MARK: - Helper Methods
    private func SetUpViews() -> Void {
        PopUpBlurrScreenView.alpha = 0
        PopUpBlurrScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopUpBlurrScreenView_Touched)))
        ActivityIndicator.alpha = 0
        lbl_GrabIt_Header.text = "90 seconds"
        lbl_Subtitle.text = "Or it's gone"
        btn_SignUp.setTitle(.btn_SignUp_String , for: .normal)
        btn_SignUp.addTarget(self, action: #selector(btn_SignUp_Pressed), for: .touchUpInside)
        btn_Login.setTitle(.btn_Login_String, for: .normal)
        btn_Login.addTarget(self, action: #selector(btn_Login_Pressed), for: .touchUpInside)
        btn_Guest.setTitle(.btn_Guest_String, for: .normal)
        btn_Guest.addTarget(self, action: #selector(btn_Guest_Pressed), for: .touchUpInside)
        btn_CustomFacebookLogin.addTarget(self, action: #selector(btn_FacebookLogin_Pressed), for: .touchUpInside)
        btn_CustomGoogleLogin.addTarget(self, action: #selector(btn_CustomGoogleLogin_Pressed), for: .touchUpInside)
        btn_CustomInstagramLogin.addTarget(self, action: #selector(btn_CustomInstagramLogin_Pressed), for: .touchUpInside)
        
        /*let googleButton = GIDSignInButton()
         ButonContainer.addArrangedSubview(googleButton)*/
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate
        GIDSignIn.sharedInstance().delegate = self
        
        //Login PopUp
        btn_SignUp_PopUp.setTitle(.btn_SignUp_String, for: .normal)
        btn_SignUp_PopUp.addTarget(self, action: #selector(btn_SignUp_PopUp_Pressed), for: .touchUpInside)
        btn_LogIn_PopUp.setTitle(.btn_Login_String, for: .normal)
        btn_LogIn_PopUp.addTarget(self, action: #selector(btn_LogIn_PopUp_Pressed), for: .touchUpInside)
        txt_Login_Email.placeholder = .txt_Login_Email_Placeholder_String
        txt_Login_Email.delegate = self
        txt_Login_Email.addTarget(self, action: #selector(txt_Login_Email_TextChanged), for: .editingChanged)
        txt_Login_Password.placeholder = .txt_Login_Password_Placeholder_String
        txt_Login_Password.delegate = self
        txt_Login_Password.addTarget(self, action: #selector(txt_Login_Password_TextChanged), for: .editingChanged)
        btn_PasswordForgotten.setTitle(.btn_PasswordForgotten_Title_String, for: .normal)
        btn_PasswordForgotten.addTarget(self, action: #selector(btn_PasswordForgotten_Pressed), for: .touchUpInside)
        
        //Register PopUp
        txt_Register_Email.placeholder = .txt_Login_Email_Placeholder_String
        txt_Register_Email.delegate = self
        txt_Register_Email.addTarget(self, action: #selector(txt_Register_Email_TextChanged), for: .editingChanged)
        txt_Register_Password.placeholder = .txt_Login_Password_Placeholder_String
        txt_Register_Password.delegate = self
        txt_Register_Password.addTarget(self, action: #selector(txt_Register_Password_TextChanged), for: .editingChanged)
        btn_Register_popUp.setTitle(.btn_SignUp_String, for: .normal)
        
        // Web view Instagram login
        instagramLoginWebView = UIWebView(frame: CGRect(x: view.frame.size.width * 0.5 - 200, y: view.frame.size.height * 0.5 - 235 * 0.5, width: 400, height: 235))
        instagramLoginWebView?.delegate = self
    }
    private  func AddNotificationListeners() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(SegueToMainController), name: NSNotification.Name.SegueToMainController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    private func ConfigureDesignableTextfieldDuringInput(sender:DesignableTextField, validationType: eValidationType)->Void{
        switch validationType {
        case .email:
            var isValid:Bool = false
            isValid = ValidationFactory.Validate(type: .email, validationString: sender.text!)
            sender.RightImageVisibility = !isValid
            if isValid == false { sender.rightView?.shake() }
            if sender.text!.isEmpty { sender.RightImageVisibility = false }
        case .password:
            var isValid:Bool = false
            isValid = ValidationFactory.Validate(type: .password, validationString: sender.text!)
            sender.RightImageVisibility = !isValid
            if isValid == false { sender.rightView?.shake() }
            if sender.text!.isEmpty { sender.RightImageVisibility = false }
        default:
            break
        }
    }
}

