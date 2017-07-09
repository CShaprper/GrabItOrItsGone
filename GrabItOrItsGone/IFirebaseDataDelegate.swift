//
//  IFirebaseDataDelegate.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 08.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

@objc protocol IFirebaseDataReceivedDelegate {
    @objc optional func FirebaseDataReceived() -> Void
}
