//
//  PasswordValidation.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

class PasswordValidationService: IValidateable {

    func Validate(validationString: String) -> Bool{
        if validationString.characters.count <= 5{
            return false
        }
        return true
    } 
}
