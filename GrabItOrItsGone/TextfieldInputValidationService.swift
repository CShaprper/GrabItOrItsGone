//
//  UserInputValidationService.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 14.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class TextfieldInputValidationService: IValidateable, IAlertMessageDelegate {
    var alertMessageDelegate: IAlertMessageDelegate?
    
    func Validate(validationString: String?) -> Bool {
        if validationString == nil || validationString!.contains(""){
            let title = String.Validation_Error_Message_String
            let message = String.TextfieldInputEmptyValidationError_MessageString
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    
    func ShowAlertMessage(title: String, message: String) {
        if alertMessageDelegate != nil {
            alertMessageDelegate!.ShowAlertMessage(title: title, message: message)
        } else {
            print("alertMessageDelegate not set from calling class")
        }
    }
}
