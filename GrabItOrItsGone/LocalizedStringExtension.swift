//
//  LocalizedStringExtension.swift
//  GrabIt
//
//  Created by Peter Sypek on 03.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
extension String{
    var localized:String {
        return NSLocalizedString(self, comment: "")
    }
}
