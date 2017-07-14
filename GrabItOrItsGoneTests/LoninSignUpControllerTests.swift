//
//  LoninSignUpControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 14.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class LoninSignUpControllerTests: XCTestCase {
    var sut:LoginSignUpFacade!
    
    override func setUp() {
        super.setUp()
        
        sut = LoginSignUpFacade()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_firbaseClientVar_isSet() {
        XCTAssertNotNil(sut!.firebaseClient, "firebaseClient not set")
    }
    
}
