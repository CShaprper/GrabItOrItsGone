//
//  ViewController.swift
//  GrabIt
//
//  Created by Peter Sypek on 23.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn

enum eValidationType{
    case email
    case password
}
//FBSDKLoginButtonDelegate
class LogInSignUpController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate, IActivityAnimationDelegate  {
    
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
    
    
    //MARK: Members
    var facade:GrabItFacade!
    let style = UIStyleHelper()
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: IAuthenticableDelegate implementation
    func StartActivityAnimation() {
        view.insertSubview(ActivityIndicator, aboveSubview: RegisterPopUp)
        ActivityIndicator.alpha = 1
        ActivityIndicator.startAnimating()
        ActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        ActivityIndicator.transform = CGAffineTransform(translationX: view.center.x, y: 0)
    }
    func StopActivityAnimation() {
        ActivityIndicator.stopAnimating()
        ActivityIndicator.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facade = GrabItFacade(presentingController: self)
        facade.activityAnitmationDelegate = self
        
        // Facebook SDK login permissions
        //btn_FacebookLogin.delegate = self
        //btn_FacebookLogin.readPermissions = ["public_profile", "email"]
        
        
        //Setup Views
        PopUpBlurrScreenView.alpha = 0
        PopUpBlurrScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopUpBlurrScreenView_Touched)))
        lbl_GrabIt_Header.text = "90 seconds"
        lbl_Subtitle.text = "Or it's gone"
        btn_SignUp.setTitle(view.btn_SignUp_String , for: .normal)
        btn_SignUp.addTarget(self, action: #selector(btn_SignUp_Pressed), for: .touchUpInside)
        btn_Login.setTitle(view.btn_Login_String, for: .normal)
        btn_Login.addTarget(self, action: #selector(btn_Login_Pressed), for: .touchUpInside)
        btn_Guest.setTitle(view.btn_Guest_String, for: .normal)
        btn_Guest.addTarget(self, action: #selector(btn_Guest_Pressed), for: .touchUpInside)
        btn_CustomFacebookLogin.addTarget(self, action: #selector(btn_FacebookLogin_Pressed), for: .touchUpInside)
        btn_CustomGoogleLogin.addTarget(self, action: #selector(btn_CustomGoogleLogin_Pressed), for: .touchUpInside)
        
        /*let googleButton = GIDSignInButton()
        ButonContainer.addArrangedSubview(googleButton)*/
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate
        GIDSignIn.sharedInstance().delegate = self
        
        //Login PopUp
        btn_SignUp_PopUp.setTitle(view.btn_SignUp_String, for: .normal)
        btn_SignUp_PopUp.addTarget(self, action: #selector(btn_SignUp_PopUp_Pressed), for: .touchUpInside)
        btn_LogIn_PopUp.setTitle(view.btn_Login_String, for: .normal)
        btn_LogIn_PopUp.addTarget(self, action: #selector(btn_LogIn_PopUp_Pressed), for: .touchUpInside)
        txt_Login_Email.placeholder = view.txt_Login_Email_Placeholder_String
        txt_Login_Email.delegate = self
        txt_Login_Email.addTarget(self, action: #selector(txt_Login_Email_TextChanged), for: .editingChanged)
        txt_Login_Password.placeholder = view.txt_Login_Password_Placeholder_String
        txt_Login_Password.delegate = self
        txt_Login_Password.addTarget(self, action: #selector(txt_Login_Password_TextChanged), for: .editingChanged)
        btn_PasswordForgotten.setTitle(view.btn_PasswordForgotten_Title_String, for: .normal)
        btn_PasswordForgotten.addTarget(self, action: #selector(btn_PasswordForgotten_Pressed), for: .touchUpInside)
        
        //Register PopUp
        txt_Register_Email.placeholder = view.txt_Login_Email_Placeholder_String
        txt_Register_Email.delegate = self
        txt_Register_Email.addTarget(self, action: #selector(txt_Register_Email_TextChanged), for: .editingChanged)
        txt_Register_Password.placeholder = view.txt_Login_Password_Placeholder_String
        txt_Register_Password.delegate = self
        txt_Register_Password.addTarget(self, action: #selector(txt_Register_Password_TextChanged), for: .editingChanged)
        btn_Register_popUp.setTitle(view.btn_SignUp_String, for: .normal)
        
        //Message Box
        style.AddToViewsForStyling(views: [])
        
        //Notification Observers
        NotificationCenter.default.addObserver(self, selector: #selector(SegueToMainController), name: NSNotification.Name.SegueToMainController, object: nil)
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
    //MARK: - View did Appeared
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
    
    func txt_Login_Email_TextChanged(sender: DesignableTextField) -> Void {
        facade.SetValidationService(validationservice: EmailValidationService())
        sender.RightImageVisibility = !facade.validationService!.Validate(validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .email)
    }
    
    func txt_Login_Password_TextChanged(sender: DesignableTextField) -> Void{
        facade.SetValidationService(validationservice: PasswordValidationService())
        sender.RightImageVisibility = !facade.validationService!.Validate(validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .password)
    }
    
    func txt_Register_Email_TextChanged(sender: DesignableTextField) -> Void {
        facade.SetValidationService(validationservice: EmailValidationService())
        sender.RightImageVisibility = !facade.validationService!.Validate(validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .email)
    }
    
    func txt_Register_Password_TextChanged(sender:DesignableTextField) -> Void {
        facade.SetValidationService(validationservice: PasswordValidationService())
        sender.RightImageVisibility = !facade.validationService!.Validate(validationString: sender.text!)
        ConfigureDesignableTextfieldDuringInput(sender: sender, validationType: .password)
    }
    private func ConfigureDesignableTextfieldDuringInput(sender:DesignableTextField, validationType: eValidationType)->Void{
        switch validationType {
        case .email:
            facade.SetValidationService(validationservice: EmailValidationService())
            sender.RightImageVisibility = !facade.validationService!.Validate(validationString: sender.text!)
            if facade.validationService!.Validate(validationString: sender.text!) == false{
                sender.rightView?.shake()
            }
            if sender.text!.isEmpty{
                sender.RightImageVisibility = false
            }
        case .password:
            facade.SetValidationService(validationservice: PasswordValidationService())
            sender.RightImageVisibility = !facade.validationService!.Validate(validationString: sender.text!)
            if facade.validationService!.Validate(validationString: sender.text!) == false{
                sender.rightView?.shake()
            }
            if sender.text!.isEmpty{
                sender.RightImageVisibility = false
            }
            
        }
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
        //Firebase sign Up
        facade.CreateNewFirebaseUser(email: txt_Register_Email.text!, password: txt_Register_Password.text!)
    }
    
    func btn_LogIn_PopUp_Pressed(sender: DesignableUIButton) -> Void {
        //Firebase Login
        facade.LoginFirebaseUser(email: txt_Login_Email.text!, password: txt_Login_Password.text!)
    }
    
    func btn_Guest_Pressed(sender: DesignableUIButton){
        UserDefaults.standard.set(true, forKey: "isLoggedInAsGuest")
        self.performSegue(withIdentifier: "SegueToMainController", sender: nil)
    }
    
    func btn_PasswordForgotten_Pressed(sender:UIButton) -> Void {
        facade.ResetUserPassword(email: txt_Login_Email.text!)
    }
    
    func SegueToMainController(notification: Notification) -> Void{
        txt_Register_Email.text = String()
        txt_Login_Email.text = String()
        txt_Login_Password.text = String()
        txt_Register_Password.text = String()
        performSegue(withIdentifier: "SegueToMainController", sender: nil)
    }
    
    func btn_FacebookLogin_Pressed(sender: UIButton) -> Void {
        facade.LoginFirebaseUserWithFacebook(controller:self)
    }
    func btn_CustomGoogleLogin_Pressed(sender: DesignableUIButton) -> Void {
        UserDefaults.standard.set(true, forKey: "isLoggedInWithGoogle")
        GIDSignIn.sharedInstance().signIn()
    }
}

