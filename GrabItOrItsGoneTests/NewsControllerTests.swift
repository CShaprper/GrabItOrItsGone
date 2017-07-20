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
        sut.viewDidLoad()
        sut.didReceiveMemoryWarning()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_BackgroundImage_Exists(){
        XCTAssertNotNil(sut!.BackgroundImage, "BackgroundImage should exist for Background Image")
    }
    func test_NewsTableView_Exists(){
        XCTAssertNotNil(sut!.NewsTableView, "NewsTableView should exist to show News")
    }
    func test_NewsArray_Exists(){
        XCTAssertNotNil(sut!.facade!.newsArray, "NewsArray should exist as datasource for Tableview")
    }
    func test_NewsTableViewDataSource_isSet() {
        XCTAssertNotNil(sut!.NewsTableView.dataSource, "NewsTableView.dataSource not set")
    }
    func test_NewsTableViewDelegate_isSet() {
        XCTAssertNotNil(sut!.NewsTableView.delegate, "NewsTableView.delegate not set")
    }
    func test_TableViewUsesCellWithResuseIdentifier(){
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut!.NewsTableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell, "TabelViewCell should not be nil")
        XCTAssertTrue(cell.reuseIdentifier == String.NewsTableViewCell_Identifier, "TabelViewCell reuseIdentifier is \(String(describing: cell.reuseIdentifier)) and should be \(String.NewsTableViewCell_Identifier)")
    }
} 
