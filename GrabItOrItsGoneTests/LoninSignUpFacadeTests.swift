//
//  LoninSignUpControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 14.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class LoninSignUpFacadeTests: XCTestCase {
    var facade:LoginSignUpFacade!
    
    override func setUp() {
        super.setUp()
        facade = LoginSignUpFacade()
    }
    
    override func tearDown() {
        facade = nil
        super.tearDown()
    }
    
    func test_firbaseClientVar_isSet() {
        XCTAssertNotNil(facade.firebaseClient, "firebaseClient not set")
    }
    
}
