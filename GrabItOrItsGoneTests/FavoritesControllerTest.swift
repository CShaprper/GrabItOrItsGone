//
//  ManageFavoritesControllerTest.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class FavoritesControllerTest: XCTestCase {
    var sut:FavoritesController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "FavoritesController") as! FavoritesController
        
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
    
    func test_BackgroundImange_Exists(){
        XCTAssertNotNil(sut!.BackgroundImange, "BackgroundImange should exist")
    }
    func test_BackgroundImageBlurrView_Exists(){
        XCTAssertNotNil(sut!.BackgroundImageBlurrView, "BackgroundImageBlurrView should exist")
    }
    func test_FavoritesTableView_Exists(){
        XCTAssertNotNil(sut!.FavoritesTableView, "FavoritesTableView should exist")
    }
    func test_FavoritesTableViewCell_Identifier_Exist(){
        XCTAssertNotNil(String.FavoritesTableViewCell_Identifier, "FavoritesTableViewCell_Identifier should exist")
    }
    func test_FavoritesTableViewCell_Identifier_isSet(){
        XCTAssertEqual(String.FavoritesTableViewCell_Identifier , "FavoritesTableViewCell", "FavoritesTableViewCell_Identifier is not set properly in Strings extension!")
    }
    func test_FavoritesTableViewDelegate_isSet() {
        XCTAssertNotNil(sut!.FavoritesTableView.delegate, "FavoritesTableView.delegate not set")
    }
    func test_FavoritesTableViewDatasource_isSet() {
        XCTAssertNotNil(sut!.FavoritesTableView.dataSource, "FavoritesTableView.dataSource not set")
    }
    func test_ManageFavoritesFacade_NotNil(){
        XCTAssertNotNil(sut!.facade, "ManageFavoritesFacade should be set")
    }
   func test_facade_IFirebaseWebserviceDelegate_isSet() {
        XCTAssertNotNil(sut!.facade.firebaseClient.delegate, "facade.firebaseClient.delegate not set IFirebaseWebserviceDelegate")
    }
    func test_SegueToFavoritesDetailController_Identifier() {
        XCTAssertTrue(CheckSegueIndentifier(segueIdentifier: "SegueToFavoritesDetailController"))
    }
    func test_NavigationItemTitle_IsLocalized(){
        XCTAssertEqual(sut!.navigationItem.title, String.ManageFavoritesController_TitleString, "ManageFavoritesController_Title is not localized")
    }
    /*func test_FavoritesTableViewCell_hasCorrectResuseIdentifier(){
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut!.FavoritesTableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell, "FavoritesTableViewCell should not be nil")
        XCTAssertTrue(cell.reuseIdentifier == String.FavoritesTableViewCell_Identifier, "TabelViewCell reuseIdentifier is \(String(describing: cell.reuseIdentifier)) and should be \(String.FavoritesTableViewCell_Identifier)")
    }*/
    
    
    
    //Mark: - Segue Identifier Helper
    func CheckSegueIndentifier(segueIdentifier:String) -> Bool{
        let identifiers = segues(ofViewController: sut!)
        if identifiers.contains(segueIdentifier) {
            return true
        }
        return false
    }
    // Mark: - Segues Helper Methods
    func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
    
}
