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
    
    func Validate(validationString: String?) -> Bool {
        var isValid:Bool = false
        isValid = validateNotNil(validationString: validationString)
        isValid = validateNotEmpty(validationString: validationString)
        isValid = validateNoAtSign(validationString: validationString)
        isValid = validateNoDot(validationString: validationString)
        isValid = validateSpaces(validationString: validationString)
        isValid = validateMailEndingContainsDot(validationString: validationString)
        isValid = validateMailEndsWithDotAndAtLeastTwoCharacters(validationString: validationString)
        isValid = validateMailNotContainsInvalidCharacters(validationString: validationString)
        return isValid
    }
    
    private func validateNotNil(validationString: String?) -> Bool{
        if validationString == nil { return false }
        return true
    }
    private func validateNotEmpty(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString!.isEmpty {  return false }
        return true
    }
    private func validateNoAtSign(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if !validationString!.contains("@") {
            return false
        }
        return true
    }
    private func validateNoDot(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if !validationString!.contains(".") {
            return false
        }
        return true
    }
    private func validateSpaces(validationString: String?) -> Bool{
        if validationString == nil { return false }
        if validationString!.contains(" ") {
            return false
        }
        return true
    }
    private func validateMailEndingContainsDot(validationString: String?) -> Bool{
        if validationString == nil { return false }
        let ending = validationString!.components(separatedBy: "@").last
        if ending == nil { return false }
        if ending!.range(of: ".") == nil{ return false }
        return true
    }
    private func validateMailEndsWithDotAndAtLeastTwoCharacters(validationString: String?) -> Bool{
        if validationString == nil { return false }
        let ending = validationString!.components(separatedBy: "@").last
        if ending == nil { return false }
        let endOfEnding = ending!.components(separatedBy: ".").last
        if endOfEnding == nil { return false }
        if endOfEnding!.characters.count < 2 { return false }
        return true
    }
    private func validateMailNotContainsInvalidCharacters(validationString: String?) -> Bool{
        if validationString == nil { return false }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if !emailPredicate.evaluate(with: validationString){ return false }
        return true
    }
}
