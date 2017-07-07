//
//  IAlertMessage.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

protocol IAlertMessage {
    /*var Title:String { get set }
    var Message:String  { get set }
    var PresentingController:UIViewController  { get }
    init(title:String, message:String, presentingController: UIViewController)*/
    func ShowAlert(presentingController: UIViewController)    
}
