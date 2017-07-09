//
//  IAlertMessage.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

@objc protocol IAlertMessage { 
    @objc optional func ShowAlert(presentingController: UIViewController)
}
