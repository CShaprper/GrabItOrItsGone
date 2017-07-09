//
//  Protocols.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

@objc protocol IAuthenticalbe {
    @objc optional var firebaseURL:String { get }
    @objc optional func CreateNewAutenticableUser(email: String, password: String) -> Void
    @objc optional func LoginAuthenticableUser(email: String, password: String) -> Void
    @objc optional func LogoutAuthenticableUser() -> Void
}
