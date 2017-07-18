//
//  IAuthenticableDelegate.swift
//  GrabIt
//
//  Created by Peter Sypek on 02.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

@objc protocol IActivityAnimationDelegate: class {
    @objc optional var activityAnimationDelegate:IActivityAnimationDelegate? { get set }
    func StartActivityAnimation() -> Void
    func StopActivityAnimation() -> Void
}
