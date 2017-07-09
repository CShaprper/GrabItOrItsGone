//
//  IFirebaseDataDelegate.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 08.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

@objc protocol IFirebaseDataDelegate {
    @objc optional func FirebaseDataReceived(dictionary: [String:AnyObject])
}
