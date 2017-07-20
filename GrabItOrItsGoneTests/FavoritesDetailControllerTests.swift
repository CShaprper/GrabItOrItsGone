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
        sut.didReceiveMemoryWarning()
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
    func test_ContentScrollView_Exists(){
        XCTAssertNotNil(sut!.ContentScrollView, "ContentScrollView should exist")
    }
    func test_ContentScrollViewDelegate_isSet() {
        XCTAssertNotNil(sut!.ContentScrollView.delegate, "ContentScrollView.delegate not set")
    }
    func test_ProductImage_Exists(){
        XCTAssertNotNil(sut!.ProductImage, "ProductImage should exist")
    }
    func test_ProductTitle_Exists(){
        XCTAssertNotNil(sut!.ProductTitle, "ProductTitle should exist")
    }
    func test_ProductInformation_Exists(){
        XCTAssertNotNil(sut!.ProductInformation, "ProductInformation should exist")
    }
    func test_sleectedProduct_Exists(){
        XCTAssertNil(sut!.selectedProduct, "selectedProduct should be nil")
    }
}
