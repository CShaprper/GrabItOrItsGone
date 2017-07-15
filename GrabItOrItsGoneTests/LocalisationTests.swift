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
}
