//
//  IAlertMessageDelegate.swift
//  GrabIt
//
//  Created by Peter Sypek on 03.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
@objc protocol IAlertMessageDelegate {
    @objc optional func ShowAlertMessage(title: String, message: String)->Void
}
