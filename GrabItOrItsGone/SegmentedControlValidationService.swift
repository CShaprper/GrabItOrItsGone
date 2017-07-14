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
    
    func Validate(segmentedControl: UISegmentedControl?) -> Bool {
        if segmentedControl?.selectedSegmentIndex == -1{
                let title = String.ValidationErrorAlert_TitleString
                let message = String.AddresTypeSegmentNotSetAlert_MessageString
                ShowAlertMessage(title: title, message: message)
                return false 
        }
        return true
    }
    
    func ShowAlertMessage(title: String, message: String) {
        if alertMessageDelegate != nil{
            alertMessageDelegate!.ShowAlertMessage(title: title, message: message)
        } else {
            print("alertMessageDelegate not set from calling class")
        }
    }
}
