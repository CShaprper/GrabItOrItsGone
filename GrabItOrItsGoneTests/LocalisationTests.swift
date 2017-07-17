//
//  LocalisationTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class LocalisationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func test_NoRegisteredUserAlert_MessageString_Exist(){
    XCTAssertNotNil(String.NoRegisteredUserAlert_MessageString, "NoRegisteredUserAlert_MessageString should exist in string extension")
    }
    func test_NoRegisteredUserAlert_MessageString_isLocalized(){
    XCTAssertTrue(String.NoRegisteredUserAlert_MessageString != "NoRegisteredUserAlert_MessageString", "NoRegisteredUserAlert_MessageString is not localized in strings file!")
    }
    func test_NoRegisteredUserAlert_TitleString_Exist(){
    XCTAssertNotNil(String.NoRegisteredUserAlert_TitleString, "NoRegisteredUserAlert_TitleString should exist in string extension")
    }
    func test_NoRegisteredUserAlert_TitleString_isLocalized(){
    XCTAssertTrue(String.NoRegisteredUserAlert_TitleString != "NoRegisteredUserAlert_TitleString", "NoRegisteredUserAlert_TitleString is not localized in strings file!")
    }
    func test_EmailInvalidCharactersErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(String.EmailInvalidCharactersErrorAlert_MessageString, "EmailInvalidCharactersErrorAlert_MessageString should exist in string extension")
    }
    func test_EmailInvalidCharactersErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(String.EmailInvalidCharactersErrorAlert_MessageString != "EmailInvalidCharactersErrorAlert_MessageString", "EmailInvalidCharactersErrorAlert_MessageString is not localized in strings file!")
    }
    func test_EmailMissingAtSignErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(String.EmailMissingAtSignErrorAlert_MessageString, "EmailMissingAtSignErrorAlert_MessageString should exist in string extension")
    }
    func test_EmailMissingAtSignErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(String.EmailMissingAtSignErrorAlert_MessageString != "EmailMissingAtSignErrorAlert_MessageString", "EmailMissingAtSignErrorAlert_MessageString is not localized in strings file!")
    }
    func test_FirebaseImageUploadErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(String.FirebaseImageUploadErrorAlert_TitleString, "FirebaseImageUploadErrorAlert_TitleString should exist")
    }
    func test_FirebaseImageUploadErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(String.FirebaseImageUploadErrorAlert_TitleString != "FirebaseImageUploadErrorAlert_TitleString", "FirebaseImageUploadErrorAlert_TitleString is not localized in strings file!")
    }
    func test_ManageFavoritesController_TitleString_Exist(){
        XCTAssertNotNil(String.ManageFavoritesController_TitleString, "ManageFavoritesController_TitleString should exist in string extension")
    }
    func test_ManageFavoritesController_TitleString_isLocalized(){
        XCTAssertTrue(String.ManageFavoritesController_TitleString != "ManageFavoritesController_TitleString", "ManageFavoritesController_TitleString is not localized in strings file!")
    }
    func test_ZipCodeErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(String.ZipCodeErrorAlert_MessageString, "ZipCodeErrorAlert_MessageString should exist in string extension")
    }
    func test_ZipCodeErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(String.ZipCodeErrorAlert_MessageString != "ZipCodeErrorAlert_MessageString", "ZipCodeErrorAlert_MessageString is not localized in strings file!")
    }
    func test_TextfieldInputToShortValidationError_MessageString_Exist(){
        XCTAssertNotNil(String.TextfieldInputToShortValidationError_MessageString, "TextfieldInputToShortValidationError_MessageString should exist in string extension")
    }
    func test_TextfieldInputToShortValidationError_MessageString_isLocalized(){
        XCTAssertTrue(String.TextfieldInputToShortValidationError_MessageString != "TextfieldInputToShortValidationError_MessageString", "TextfieldInputToShortValidationError_MessageString is not localized in strings file!")
    }
    func test_FirebaseDeleteErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(String.FirebaseDeleteErrorAlert_TitleString, "FirebaseDeleteErrorAlert_TitleString should exist in string extension")
    }
    func test_FirebaseDeleteErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(String.FirebaseDeleteErrorAlert_TitleString != "FirebaseDeleteErrorAlert_TitleString", "FirebaseDeleteErrorAlert_TitleString is not localized in strings file!")
    }
    func test_FirebaseDeleteErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(String.FirebaseDeleteErrorAlert_MessageString, "FirebaseDeleteErrorAlert_MessageString should exist in string extension")
    }
    func test_FirebaseDeleteErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(String.FirebaseDeleteErrorAlert_MessageString != "FirebaseDeleteErrorAlert_MessageString", "FirebaseDeleteErrorAlert_MessageString is not localized in strings file!")
    }
}
