//
//  Protocols.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

@objc protocol IAuthenticalbe: class {
    var firebaseURL:String { get }
    func CreateNewAutenticableUser(email: String, password: String) -> Void
    func LoginAuthenticableUser(email: String, password: String) -> Void
    func LogoutAuthenticableUser() -> Void
}
