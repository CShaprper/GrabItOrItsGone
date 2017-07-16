//
//  IAlertMessageDelegate.swift
//  GrabIt
//
//  Created by Peter Sypek on 03.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

@objc protocol IAlertMessageDelegate {
    @objc optional var alertMessageDelegate:IAlertMessageDelegate? { get set }
    
    ///Initializes the delegate
    /// - parameter delegate: IAlertMessageDelegate -> Represents the class to which the delegate method will be send
    ///
    /// **Usage:** func initAlertMessageDelegate(delegate: IAlertMessageDelegate){ sendingClass.alertMessageDelegate = delegate }
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate)
    func ShowAlertMessage(title: String, message: String)->Void
}
