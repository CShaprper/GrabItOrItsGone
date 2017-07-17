//
//  CategoriesControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 17.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class CategoriesControllerTests: XCTestCase {
    var sut:CategoriesController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "CategoriesController") as! CategoriesController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(sut.loadView())
        sut.viewDidLoad()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_BakcgroundImage_Exists(){
    XCTAssertNotNil(sut!.BakcgroundImage, "BakcgroundImage should exist")
    }
    func test_BackgroundBlurrView_Exists(){
    XCTAssertNotNil(sut!.BackgroundBlurrView, "BackgroundBlurrView should exist")
    }
    func test_lbl_CategoryElectronic_Exists(){
    XCTAssertNotNil(sut!.lbl_CategoryElectronic, "lbl_CategoryElectronic should exist")
    }
    func test_switchCategoryElectronic_Exists(){
    XCTAssertNotNil(sut!.switchCategoryElectronic, "switchCategoryElectronic should exist")
    }
    func test_lbl_CategoryClothes_Exists(){
    XCTAssertNotNil(sut!.lbl_CategoryClothes, "lbl_CategoryClothes should exist")
    }
    func test_switchCategoryClothes_Exists(){
    XCTAssertNotNil(sut!.switchCategoryClothes, "switchCategoryClothes should exist")
    }
    func test_lbl_CategoryJewelry_Exists(){
    XCTAssertNotNil(sut!.lbl_CategoryJewelry, "lbl_CategoryJewelry should exist")
    }
    func test_switchCategoryJewelry_Exists(){
    XCTAssertNotNil(sut!.switchCategoryJewelry, "switchCategoryJewelry should exist")
    }
    func test_lbl_CategoryCosmetics_Exists(){
    XCTAssertNotNil(sut!.lbl_CategoryCosmetics, "lbl_CategoryCosmetics should exist")
    }
    func test_switchCategoryCosmetics_Exists(){
    XCTAssertNotNil(sut!.switchCategoryCosmetics, "switchCategoryCosmetics should exist")
    }
}
