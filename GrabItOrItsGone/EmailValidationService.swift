//
//  UserValidation.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
/// **Class needs to implement IValidateable.**
/// 
/// Validates email user input
class EmailValidationService: IValidateable{
    
    /// This function validates email input.
    /// * parameter validationString: String for validation process
    /// - returns: Boolean value: Representing validation status
    func Validate(validationString: String?) -> Bool {
        if validationString == nil || validationString!.contains("@") == false || validationString!.contains(".") == false{
            return false
        }
        if validationString!.contains(" "){
            return false
        }
        if let ending = validationString!.components(separatedBy: "@").last {
            if ending.range(of: ".") == nil{
                return false
            }
            if let endOfEnding = ending.components(separatedBy: ".").last{
                if endOfEnding.characters.count < 2{
                    return false
                }
            }
        }
        if validationString!.isEmpty{
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if emailPredicate.evaluate(with: validationString) == false{
            return false
        }
        return true
    }
}
