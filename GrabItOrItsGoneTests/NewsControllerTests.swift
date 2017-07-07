//
//  NewsControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 07.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class NewsControllerTests: XCTestCase {
    var sut:NewsController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "NewsController") as! NewsController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(sut.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_BackgroundImage_Exists(){
    XCTAssertNotNil(sut!.BackgroundImage, "BackgroundImage should exist for Background Image")
    }
    func test_NewsTableView_Exists(){
    XCTAssertNotNil(sut!.NewsTableView, "NewsTableView should exist to show News")
    }
    func test_NewsArray_Exists(){
    XCTAssertNotNil(sut!.NewsArray, "NewsArray should exist as datasource for Tableview")
    }
}
