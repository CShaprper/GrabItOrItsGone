//
//  HousnumberValidationService.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 18.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

class HousenumberValidationService: IValidateable, IAlertMessageDelegate {
    var alertMessageDelegate: IAlertMessageDelegate?
    let title = String.Validation_Error_Message_String
    var message = String.HousenumberToShortValidationError_MessageString
    
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
        alertMessageDelegate = delegate
    }
    
    func Validate(validationString: String?) -> Bool {
        var isValid:Bool = false
        isValid = validateNotNil(validationString: validationString)
        isValid = validateStringEmpty(validationString: validationString)
        isValid = validateLessThanOneCharacters(validationString: validationString)
        return isValid
    }
    
    private func validateNotNil(validationString: String?) -> Bool {
        if validationString == nil{
            message = String.HousenumberToShortValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    
    private func validateStringEmpty(validationString: String?) -> Bool {
        if validationString == nil { return false }
        if validationString! == ""{
            message = String.HousenumberToShortValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    private func validateLessThanOneCharacters(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString!.characters.count < 1{
            message = String.HousenumberToShortValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    private func validateisNumeric(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if !validationString!.isNumeric{
            message = String.HousenumberToShortValidationError_MessageString
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
