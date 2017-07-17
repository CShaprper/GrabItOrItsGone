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

class LoginSignUpFacade{
    //MARK: Members
    var presentingController:UIViewController!
    var firebaseClient:FirebaseClient!
    
    //Constructor
    init() {
        self.firebaseClient = FirebaseClient()
    }
    
    func CreateNewFirebaseUser(email: String, password: String) -> Void {
    }
    
    func LoginFirebaseUser(email: String, password: String) -> Void{
    }
    
    func LoginFirebaseUserWithGoogle(guser: GIDGoogleUser)->Void{
        firebaseClient.LoginWithGoogle(guser: guser)
    }
    
    func LoginFirebaseUserWithFacebook(controller:UIViewController)->Void{
        firebaseClient.LoginWithFacebook(controller: controller)
    }
    func LoginFirebaseUserWithInstagram(controller:UIViewController, customToken: String) -> Void{
        firebaseClient.LoginWithInstagram(controller: controller, customToken: customToken)
    }
    
    func LogoutFirebaseUser(){
        firebaseClient.LogoutAuthenticableUser()
    }
    
    func ResetUserPassword(email: String){
        var isValid:Bool = false
        ValidationFactory.alertMessageDelegate = presentingController as? IAlertMessageDelegate
        isValid = ValidationFactory.Validate(type: .email, validationString: email)
        if isValid {
            firebaseClient.ResetUserPassword(email: email)
        }
    }
    
    func AddFirebaseUserStateListener(){
        firebaseClient.AddUserStateListener()
    }
}
