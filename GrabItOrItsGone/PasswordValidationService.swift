//
//  PasswordValidation.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation


class PasswordValidationService: IValidateable, IAlertMessageDelegate {
    var alertMessageDelegate:IAlertMessageDelegate?
    let title = String.ValidationErrorAlert_TitleString
    var message = String.Validation_Error_Message_String
    
    func Validate(validationString: String?) -> Bool{
        var isValid: Bool = false
        isValid = validateNotNil(validationString: validationString)
        isValid = validateNotEmpty(validationString: validationString)
        isValid = validateCharactersCountNotBelowSix(validationString: validationString)
        return isValid
    }
    
    private func validateNotNil(validationString: String?) -> Bool{
        if validationString == nil {
            message = String.TextfieldInputEmptyValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    private func validateNotEmpty(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString! == "" {
            message = String.TextfieldInputEmptyValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    private func validateCharactersCountNotBelowSix(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString!.characters.count < 6 {
            message = String.PasswordValidationErrorAlert_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    
    //MARK: - IAlertMessageDeleagate implementation
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
        alertMessageDelegate = delegate
    }
    func ShowAlertMessage(title: String, message: String) {
        if alertMessageDelegate != nil{
            alertMessageDelegate!.ShowAlertMessage(title: title, message: message)
        } else {
            print("TextfieldValidationService: alertMessageDelegate not set from calling class")
        }
    }
} 
