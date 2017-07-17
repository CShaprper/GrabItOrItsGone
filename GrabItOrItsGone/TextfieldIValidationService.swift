//
//  UserInputValidationService.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 14.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class TextfieldValidationService: IValidateable, IAlertMessageDelegate {
    var alertMessageDelegate: IAlertMessageDelegate?
    let title = String.Validation_Error_Message_String
    var message = String.TextfieldInputEmptyValidationError_MessageString
    
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
        alertMessageDelegate = delegate
    }
    
    func Validate(validationString: String?) -> Bool {
        var isValid:Bool = false
        isValid = validateNotNil(validationString: validationString)
        isValid = validateStringEmpty(validationString: validationString)
        isValid = validateLessThanThreeCharacters(validationString: validationString)
        return isValid
    }
    
    private func validateNotNil(validationString: String?) -> Bool {
        if validationString == nil{
            message = String.TextfieldInputEmptyValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    
    private func validateStringEmpty(validationString: String?) -> Bool {
        if validationString == nil { return false }
        if validationString! == ""{
            message = String.TextfieldInputEmptyValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    private func validateLessThanThreeCharacters(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString!.characters.count < 3{
            message = String.TextfieldInputToShortValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    
    
    internal func ShowAlertMessage(title: String, message: String) {
        if alertMessageDelegate != nil {
            alertMessageDelegate!.ShowAlertMessage(title: title, message: message)
        } else {
            print("TextfieldInputValidationService: alertMessageDelegate not set from calling class")
        }
    }
}
