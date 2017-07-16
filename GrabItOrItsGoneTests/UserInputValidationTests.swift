//
//  PasswordValidationTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 09.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class UserInputValidationTests: XCTestCase {
    var password:PasswordValidationService!
    var zip:ZipCodeInputValidationService!
    var txt:TextfieldInputValidationService!
    
    override func setUp() {
        super.setUp()
        password = PasswordValidationService()
        zip = ZipCodeInputValidationService()
        txt = TextfieldInputValidationService()
    }
    
    override func tearDown() {
        password = nil
        zip = nil
        txt = nil
        super.tearDown()
    }
    //MARK:- Simple TextField Validation
    func test_SimpleTextfieldValidation_NotEmpty() {
        XCTAssertFalse(txt.Validate(validationString: ""), "Validation should fail on empty Textfield")
    }
    
    //MARK:- Password Validation
    func test_Validation_Passes_When_PassWord_hasSixCharacters() {
        XCTAssertTrue(password.Validate(validationString: "123456"), "Validation should pass when validated string is six characters ore more")
    }
    func test_Validation_Failes_When_PassWord_hasLessThanSixCharacters(){
        XCTAssertFalse(password.Validate(validationString: "12345"), "Validation should fail when valideted string is below six characters")
    }
    func test_Validation_Failes_When_PassWord_hasLessThanFiveCharacters(){
        XCTAssertFalse(password.Validate(validationString: "1234"), "Validation should fail when valideted string is below five characters")
    }
    
    //MARK: Zipcode Validation
    func test_ZipCodeValidationFails_NotFiveDigits() {
        XCTAssertFalse(zip.Validate(validationString: "1"), "Zipcode validation should fail below five digits")
        XCTAssertFalse(zip.Validate(validationString: "12"), "Zipcode validation should fail below five digits")
        XCTAssertFalse(zip.Validate(validationString: "123"), "Zipcode validation should fail below five digits")
        XCTAssertFalse(zip.Validate(validationString: "1234"), "Zipcode validation should fail below five digits")
        XCTAssertFalse(zip.Validate(validationString: "123456"), "Zipcode validation should fail above five digits")
    }
    func test_ZipCodeValidationPasses_FiveDigits() {
        XCTAssertTrue(zip.Validate(validationString: "12345"), "Zipcode validation should pass with five digits")
    }
}
