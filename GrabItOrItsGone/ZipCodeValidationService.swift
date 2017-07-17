//
//  ZipCodeInputValidationService.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 16.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

class ZipCodeValidationService: IValidateable, IAlertMessageDelegate {
    var alertMessageDelegate: IAlertMessageDelegate?
    let title = String.ValidationErrorAlert_TitleString
    let message = String.ZipCodeErrorAlert_MessageString
    
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
        alertMessageDelegate = delegate
    }
    
    func Validate(validationString: String?) -> Bool {
        var isValid:Bool = false
        isValid = validateNotNil(validationString: validationString)
        isValid = validateCharactersCountEqualFive(validationString: validationString)
        return isValid
    }
    
    private func validateNotNil(validationString: String?) -> Bool{
        if validationString == nil {
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    private func validateCharactersCountEqualFive(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString!.characters.count != 5 {
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    
    internal func ShowAlertMessage(title: String, message: String) {
        if alertMessageDelegate != nil{
            alertMessageDelegate!.ShowAlertMessage(title: title, message: message)
        } else {
            print("ZipCodeValidationService: alertMessageDelegate not set from calling class")
        }
    }
}
