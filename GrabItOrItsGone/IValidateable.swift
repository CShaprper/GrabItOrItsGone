//
//  IValidateable.swift
//  GrabIt
//
//  Created by Peter Sypek on 02.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
protocol IValidateable {
   func Validate(validationString: String) -> Bool
}
