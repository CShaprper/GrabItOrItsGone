//
//  ValidationFactory.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 17.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class ValidationFactory {
    static var alertMessageDelegate:IAlertMessageDelegate?
    static var segmentedControl:UISegmentedControl?
    
    static func Validate(type: eValidationType, validationString: String?) -> Bool{
        switch type {
        case .email:
            let validationService = EmailValidationService()
            validationService.alertMessageDelegate = alertMessageDelegate
            return validationService.Validate(validationString: validationString)
        case .password:
            let validationService = PasswordValidationService()
            validationService.alertMessageDelegate = alertMessageDelegate
            return validationService.Validate(validationString: validationString)
        case .textField:
            let validationService = TextfieldValidationService()
            validationService.alertMessageDelegate = alertMessageDelegate
            return validationService.Validate(validationString: validationString)
        case .zipCode:
            let validationService = ZipCodeValidationService()
            validationService.alertMessageDelegate = alertMessageDelegate
            return validationService.Validate(validationString: validationString)
        case .segmentedControl:
            let validationService = SegmentedControlValidationService()
            validationService.alertMessageDelegate = alertMessageDelegate
            return validationService.Validate(segmentedControl: segmentedControl)
        } 
    }
}
