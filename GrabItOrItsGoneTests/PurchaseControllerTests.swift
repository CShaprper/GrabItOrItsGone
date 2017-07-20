//
//  PurchaseControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 17.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class PurchaseControllerTests: XCTestCase {
    var sut:PurchaseController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "PurchaseController") as! PurchaseController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(sut.loadView())
        sut.viewDidLoad()
        sut.didReceiveMemoryWarning()
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
}
