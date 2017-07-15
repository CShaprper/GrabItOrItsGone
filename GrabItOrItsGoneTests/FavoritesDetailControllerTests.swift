//
//  FavoritesDetailControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class FavoritesDetailControllerTests: XCTestCase {
    var sut:FavoritesDetailController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "FavoritesDetailController") as! FavoritesDetailController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(sut.loadView())
        sut.viewDidLoad()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_BachgroundImage_Exists(){
    XCTAssertNotNil(sut!.BachgroundImage, "BachgroundImage should exist")
    }
    func test_BackgroundBlurrView_Exists(){
    XCTAssertNotNil(sut!.BackgroundBlurrView, "BackgroundBlurrView should exist")
    }
}
