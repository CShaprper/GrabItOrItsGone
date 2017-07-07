//
//  extension_NotificatioName.swift
//  Shopping-Buddy
//
//  Created by Peter Sypek on 12.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
import UIKit

public extension Notification.Name{
    static let SegueToMainController = Notification.Name("SegueToMainController")
    static let SegueToLogInController = Notification.Name("SegueToLogInController") 
    static let StopActivityAnimation = Notification.Name("StopActivityAnimation")
    static let FirebaseResetPasswordSend = Notification.Name("FirebaseResetPasswordSend")
    static let ShowMessageBox = Notification.Name("ShowMessageBox")
}

