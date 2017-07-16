//
//  SegmentedControlValidationService.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 14.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class SegmentedControlValidationService: IValidateable, IAlertMessageDelegate {
    var alertMessageDelegate: IAlertMessageDelegate?
    let title = String.ValidationErrorAlert_TitleString
    var message = String.AddresTypeSegmentNotSetAlert_MessageString
    
    
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
        alertMessageDelegate = delegate
    }
    
    func Validate(segmentedControl: UISegmentedControl?) -> Bool {
        var isValid:Bool = false
        
        isValid = validateNotNil(segmentedControl: segmentedControl)
        isValid = validateIsSet(segmentedControl: segmentedControl)
        return isValid
    }
    
    private func validateNotNil(segmentedControl: UISegmentedControl?) -> Bool{
        if segmentedControl == nil {
            ShowAlertMessage(title: title, message: message)
             return false
        }
        return true
    }
    private func validateIsSet(segmentedControl: UISegmentedControl?) -> Bool{
        if segmentedControl == nil { return false }
        if segmentedControl!.selectedSegmentIndex == -1 {
            ShowAlertMessage(title: title, message: message)
            return false
        }
        return true
    }
    
    internal func ShowAlertMessage(title: String, message: String) {
        if alertMessageDelegate != nil{
            alertMessageDelegate!.ShowAlertMessage(title: title, message: message)
        } else {
            print("SegmentedControlValidationService: alertMessageDelegate not set from calling class")
        }
    }
}
