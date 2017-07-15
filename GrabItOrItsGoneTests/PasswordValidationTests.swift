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
        validation = nil
        super.tearDown()
    }
    
    func test_Validation_Passes_When_PassWord_hasSixCharacters() {
        XCTAssertTrue(validation.Validate(validationString: "123456"), "Validation should pass when validated string is six characters ore more")
    }
    func test_Validation_Failes_When_PassWord_hasLessThanSixCharacters(){
        XCTAssertFalse(validation.Validate(validationString: "12345"), "Validation should fail when valideted string is below six characters")
    }
    func test_Validation_Failes_When_PassWord_hasLessThanFiveCharacters(){
        XCTAssertFalse(validation.Validate(validationString: "1234"), "Validation should fail when valideted string is below five characters")
    }
}
