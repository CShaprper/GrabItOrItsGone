//
//  AppDelTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 19.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class AppDelTests: XCTestCase {
 var appDel:AppDelegate?
    
    override func setUp() {
        super.setUp()
       appDel = UIApplication.shared.delegate as! AppDelegate
    }
    
    override func tearDown() {
        appDel = nil
        super.tearDown()
    }
    
    func test_AppDelegateContains_imageCacheArray(){
    XCTAssertNotNil(appDel!.imageCache, "imageChache shoul exist globally")
    }
    func test_AppDelegateContains_productsArray(){
        XCTAssertNotNil(appDel!.productsArray, "productsArray shoul exist globally")
    }
    func test_AppDelegateContains_favoritesArray(){
        XCTAssertNotNil(appDel!.favoritesArray, "favoritesArray shoul exist globally")
    } 
}
