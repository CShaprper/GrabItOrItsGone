//
//  PasswordValidation.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

/// **Class needs to implement IValidateable.**
///
/// Validates password user input
class PasswordValidationService: IValidateable {
    
    /// This function validates password input.
    /// * parameter validationString: String for validation process
    /// - returns: Boolean value: Representing validation status
    func Validate(validationString: String?) -> Bool{
        if validationString == nil || validationString!.characters.count <= 5{
            return false
        }
        return true
    } 
}
