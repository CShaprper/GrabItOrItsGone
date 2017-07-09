//
//  PasswordValidationTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 09.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class PasswordValidationTests: XCTestCase {
    var validation:PasswordValidationService!
    
    override func setUp() {
        super.setUp()
        validation = PasswordValidationService()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    func test_Validation_Passe_When_PassWord_hasSixCharacters() {
        XCTAssertTrue(validation.Validate(validationString: "123456"))
    }
}
