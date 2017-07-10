//
//  ManageAddressControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 10.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class ManageAddressControllerTests: XCTestCase {
    var sut:ManageAdressController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "ManageAdressController") as! ManageAdressController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(sut.loadView())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_BackgroundImage_Exists(){
        XCTAssertNotNil(sut!.BackgroundImage, "BackgroundImage should exist")
    }
    func test_BackgroundBlurrView_Exists(){
        XCTAssertNotNil(sut!.BackgroundBlurrView, "BackgroundBlurrView should exist")
    }
    func test_AddressTableView_Exists(){
        XCTAssertNotNil(sut!.AddressTableView, "AddressTableView should exist")
    }
    func test_AddressTableViewDataSource_isSet() {
        XCTAssertNotNil(sut!.AddressTableView.dataSource, "AddressTableView.dataSource not set")
    }
    func test_AddressTableViewDelegate_isSet() {
        XCTAssertNotNil(sut!.AddressTableView.delegate, "AddressTableView.delegate not set")
    }
    
}
