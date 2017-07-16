//
//  PasswordValidation.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation


class PasswordValidationService: IValidateable {
    
    func Validate(validationString: String?) -> Bool{
        var isValid: Bool = false
        isValid = validateNotNil(validationString: validationString)
        isValid = validateNotEmpty(validationString: validationString)
        isValid = validateCharactersCountNotBelowSix(validationString: validationString)
        return isValid
    }
    
    private func validateNotNil(validationString: String?) -> Bool{
        if validationString == nil { return false }
        return true
    }
    private func validateNotEmpty(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString! == "" {
            return false
        }
        return true
    }
    private func validateCharactersCountNotBelowSix(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString!.characters.count < 6 {
            return false
        }
        return true
    }
}

/* var alertMessageDelegate: IAlertMessageDelegate?
 private let title = String.ValidationErrorAlert_TitleString
 var message = String.PasswordValidationErrorAlert_MessageString
 
 func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
 alertMessageDelegate = delegate
 }
 
 func ValidateWithAlertMessage(validationString: String?) -> Bool{
 var isValid: Bool = false
 isValid = validateNotNil(validationString: validationString)
 if !isValid {
 message = String.TextfieldInputEmptyValidationError_MessageString
 ShowAlertMessage(title: title, message: message)
 }
 isValid = validateNotEmpty(validationString: validationString)
 if !isValid {
 message = String.TextfieldInputEmptyValidationError_MessageString
 ShowAlertMessage(title: title, message: message)
 }
 isValid = validateCharactersCountNotBelowSix(validationString: validationString)
 if !isValid {
 message = String.PasswordValidationErrorAlert_MessageString
 ShowAlertMessage(title: title, message: message)
 }
 return isValid
 }
 
 
 
 func ShowAlertMessage(title: String, message: String) {
 if alertMessageDelegate != nil{
 alertMessageDelegate?.ShowAlertMessage(title: title, message: message)
 } else {
 print("PasswordValidationService: AlertMessageDelegate not set from calling class")
 }
 }*/
