//
//  IAuthenticableDelegate.swift
//  GrabIt
//
//  Created by Peter Sypek on 02.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

@objc protocol IActivityAnimationDelegate {
    @objc optional func StartActivityAnimation() -> Void
    @objc optional func StopActivityAnimation() -> Void
}
