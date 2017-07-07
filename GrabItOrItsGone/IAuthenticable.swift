//
//  Protocols.swift
//  GrabIt
//
//  Created by Peter Sypek on 01.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

protocol IAuthenticalbe {
    var firebaseURL:String { get }
    func CreateNewAutenticableUser(email: String, password: String) -> Void
    func LoginAuthenticableUser(email: String, password: String) -> Void
    func LogoutAuthenticableUser() -> Void
}
