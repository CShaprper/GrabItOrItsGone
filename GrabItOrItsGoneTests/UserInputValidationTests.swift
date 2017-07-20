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
    var house:HousenumberValidationService!
    var alertMock:FakeAlertMock!
    
    override func setUp() {
        super.setUp()
        alertMock = FakeAlertMock()
        house = HousenumberValidationService()
        house.alertMessageDelegate = alertMock
        password = PasswordValidationService()
        password.alertMessageDelegate = alertMock
        zip = ZipCodeValidationService()
        zip.alertMessageDelegate = alertMock
        txt = TextfieldValidationService()
        txt.alertMessageDelegate = alertMock
    }
    
    override func tearDown() {
        password = nil
        house = nil
        zip = nil
        txt = nil
        alertMock = nil
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
        let _ = zip.Validate(validationString: "1")
        XCTAssertTrue(alertMock.title! == String.ValidationErrorAlert_TitleString, "Alert Title is \(alertMock.title!) should be: \(String.ValidationErrorAlert_TitleString)")
        XCTAssertTrue(alertMock.message! == String.ZipCodeErrorAlert_MessageString, "Alert Message is \(alertMock.message!) should be: \(String.ZipCodeErrorAlert_MessageString)")
    }
    func test_ZipNumberValidatioService_ShowsNoMessageWhenCorrect(){
        let _ = zip.Validate(validationString: "12345")
        XCTAssertNil(alertMock.title, "There should be no Message thrown. Title: \(String(describing: alertMock.title))")
        XCTAssertNil(alertMock.message, "There should be no Message thrown. Message: \(String(describing: alertMock.message))")
    }
    func test_HousenumberValidationService_ShowsCorrectAlertMessage(){
       let _ = house.Validate(validationString: "")
        XCTAssertTrue(alertMock.title! == String.ValidationErrorAlert_TitleString, "Alert Title is \(alertMock.title!) should be: \(String.ValidationErrorAlert_TitleString)")
        XCTAssertTrue(alertMock.message! == String.HousenumberToShortValidationError_MessageString, "Alert Message is \(alertMock.message!) should be: \(String.HousenumberToShortValidationError_MessageString)")
    }
    
}


//MARK: - Fake Alert Mock
public class FakeAlertMock:IAlertMessageDelegate {
    var title:String?
    var message:String?
    public func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
    }
    
    public func ShowAlertMessage(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
