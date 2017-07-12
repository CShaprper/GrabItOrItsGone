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
        sut = nil
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
    func test_AddAddressPopUp_Exists(){
        XCTAssertNotNil(sut!.AddAddressPopUp, "AddAddressPopUp should exist")
    }
    func test_AddAddressPopUpImage_Exists(){
        XCTAssertNotNil(sut!.AddAddressPopUpImage, "AddAddressPopUpImage should exist")
    }
    func test_AddessPopUpBackground_Exists(){
        XCTAssertNotNil(sut!.AddessPopUpBackground, "AddessPopUpBackground should exist")
    }
    func test_AddressPopUpRoundView_Exists(){
        XCTAssertNotNil(sut!.AddressPopUpRoundView, "AddressPopUpRoundView should exist")
    }
    func test_AddressTypeSegmentedControl_Exists(){
        XCTAssertNotNil(sut!.AddressTypeSegmentedControl, "AddressTypeSegmentedControl should exist")
    }
    func test_txt_Fullname_Exists(){
        XCTAssertNotNil(sut!.txt_Fullname, "txt_Fullname should exist")
    }
    func test_txt_FullnameDelegate_isSet() {
        XCTAssertNotNil(sut!.txt_Fullname.delegate, "txt_Fullname.delegate not set")
    }
    func test_txt_Address_Exists(){
        XCTAssertNotNil(sut!.txt_Address, "txt_Address should exist")
    }
    func test_txt_AddressDelegate_isSet() {
        XCTAssertNotNil(sut!.txt_Address.delegate, "txt_Address.delegate not set")
    }
    func test_txt_City_Exists(){
        XCTAssertNotNil(sut!.txt_City, "txt_City should exist")
    }
    func test_txt_CityDelegate_isSet() {
        XCTAssertNotNil(sut!.txt_City.delegate, "txt_City.delegate not set")
    }
    func test_txt_Zipcode_Exists(){
        XCTAssertNotNil(sut!.txt_Zipcode, "txt_Zipcode should exist")
    }
    func test_txt_ZipcodeDelegate_isSet() {
        XCTAssertNotNil(sut!.txt_Zipcode.delegate, "txt_Zipcode.delegate not set")
    }
    func test_btn_SaveAddress_Exists(){
        XCTAssertNotNil(sut!.btn_SaveAddress, "btn_SaveAddress should exist")
    }
   /* func test_btn_SaveAddress_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_SaveAddress, actionName: "btn_SaveAddress_Pressed", event: .touchUpInside, controller: sut! ))
    }*/
    
    //MARK: - Button action test helper
    func checkActionForOutlet(outlet: UIButton?, actionName: String, event: UIControlEvents, controller: UIViewController)->Bool{
        if let unwrappedButton = outlet {
            if unwrappedButton.actions(forTarget: controller, forControlEvent: event) != nil {
                let actions = unwrappedButton.actions(forTarget: controller, forControlEvent: event)!
                let myActionName:String = actionName.appending("WithSender:")
                return actions.contains(myActionName)
            }
        }
        return false
    }
    
}
