//
//  GrabItFacade.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class GrabItFacade: IActivityAnimationDelegate, IAlertMessageDelegate{
    //MARK: Members
    private var presentingController:UIViewController!
    private var firebaseClient:FirebaseClient!
    //MARK: NewsController Members 
    
    var validationService:IValidateable!
    var activityAnitmationDelegate: IActivityAnimationDelegate?
    private var alertService:IAlertMessage!
    
    
    //Constructor
    init(presentingController: UIViewController) {
        self.firebaseClient = FirebaseClient()
        self.presentingController = presentingController
        self.firebaseClient.alertMessageDelegate = self
        self.firebaseClient.activityAnimationDelegate = self
    }
    func ShowAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))        
        presentingController.present(alert, animated: true, completion: nil)
    }
    
    func CreateNewFirebaseUser(email: String, password: String) -> Void {
        SetValidationService(validationservice: EmailValidationService())
        if validationService.Validate!(validationString: email) == false
        {
            ShowAlertMessage(title: presentingController.view.EmailValidationErrorAlert_TitleString, message: presentingController.view.EmailValidationErrorAlert_MessageString)
            return
        }
        
        SetValidationService(validationservice: PasswordValidationService())
        if validationService.Validate!(validationString: password) == false
        {
            ShowAlertMessage(title: presentingController.view.PasswordValidationErrorAlert_TitleString, message: presentingController.view.PasswordValidationErrorAlert_MessageString)
            return
        }

        firebaseClient.CreateNewAutenticableUser(email: email, password: password)
    }
    
    func LoginFirebaseUser(email: String, password: String) -> Void{
        SetValidationService(validationservice: EmailValidationService())
        if validationService.Validate!(validationString: email) == false
        {
            ShowAlertMessage(title: presentingController.view.EmailValidationErrorAlert_TitleString, message: presentingController.view.EmailValidationErrorAlert_MessageString)
            return
        }
        
        SetValidationService(validationservice: PasswordValidationService())
        if validationService.Validate!(validationString: password) == false
        {
            ShowAlertMessage(title: presentingController.view.PasswordValidationErrorAlert_TitleString, message: presentingController.view.PasswordValidationErrorAlert_MessageString)
            return
        }
        firebaseClient.LoginAuthenticableUser(email: email, password: password)
    }
    
    func LoginFirebaseUserWithGoogle(guser: GIDGoogleUser)->Void{
        firebaseClient.LoginWithGoogle(guser: guser)
    }
    
    func LoginFirebaseUserWithFacebook(controller:UIViewController)->Void{
        firebaseClient.LoginWithFacebook(controller: controller)
    }
    
    func LogoutFirebaseUser(){
        firebaseClient.LogoutAuthenticableUser()
    }
    
    func ResetUserPassword(email: String){
        SetValidationService(validationservice: EmailValidationService())
        if !validationService.Validate!(validationString: email){
            return
        }
        firebaseClient.ResetUserPassword(email: email)
    }
    
    func AddFirebaseUserStateListener(){
        firebaseClient.AddUserStateListener()
    }
    
    //MARK: IAuthenticableDelegate implementation
    func StartActivityAnimation() {
        if activityAnitmationDelegate != nil{
            activityAnitmationDelegate!.StartActivityAnimation!()
        }
    }
    func StopActivityAnimation() {
        if activityAnitmationDelegate != nil{
            activityAnitmationDelegate!.StopActivityAnimation!()
        }
    }
    
    //MARK: - Helper Methods
    func SetValidationService(validationservice: IValidateable){
        self.validationService = validationservice
    }
    
    func SetAlertMessageService(alertMessageService:IAlertMessage){
        self.alertService = alertMessageService
    }
}
