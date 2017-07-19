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
    var zip:ZipCodeValidationService!
    var txt:TextfieldValidationService!
    
    override func setUp() {
        super.setUp()
        password = PasswordValidationService()
        zip = ZipCodeValidationService()
        txt = TextfieldValidationService()
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
    func test_ZipNumberValidatioService_ShowsCorrectAlertMessage(){
  /* let alertMock = FakeAlertMock()
        zip.alertMessageDelegate = alertMock
     
        XCTAssertTrue(alertMock.title! == "MyDesiredTitle")
        XCTAssertTrue(alertMock.message! == "MyDesiredMessage")
 */
    }
}

//MARK: - Fake Alert Mock
public class FakeAlertMock:IAlertMessageDelegate {
    var title:String?
    var message:String?
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
    }
    
    func ShowAlertMessage(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
