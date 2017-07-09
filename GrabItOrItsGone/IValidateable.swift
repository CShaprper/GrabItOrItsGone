//
//  IValidateable.swift
//  GrabIt
//
//  Created by Peter Sypek on 02.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
@objc protocol IValidateable {
   @objc optional func Validate(validationString: String) -> Bool
}
