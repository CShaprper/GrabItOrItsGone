//
//  MainControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 07.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class MainControllerTests: XCTestCase {
    var storyboard:UIStoryboard!
    var sut:MainController!
    //var firebaseUser:UserAuthentication!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "MainController") as! MainController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(sut.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_MainBackgroundImage_Outlet_Exists(){
        XCTAssertNotNil(sut!.MainBackgroundImage, "MainController should contain a background image outlet")
    }
    
    func test_CardView_Outlet_Exists(){
        XCTAssertNotNil(sut!.CardView, "MainController shoul contain a CardView outlet")
    }
    
    func test_CardViewBackgroundImageView_Outlet_Exists(){
        XCTAssertNotNil(sut!.CardBackgrounImageView, "MainController shoul contain a CardView background image view outlet")
    }
    
    func test_ProductImageView_Outlet_Exists(){
        XCTAssertNotNil(sut!.ProductImageView, "MainController should contain a ProductImageView outlet")
    }
    
    func test_lbl_ProductTitle_Outlet_Exists(){
        XCTAssertNotNil(sut!.lbl_ProductTitle, "MainController should contain a label outlet for ProductTitle")
    }
    
    func test_lbl_ProductSubtitle_Outlet_Exists(){
        XCTAssertNotNil(sut!.lbl_ProductSubtitle, "MainController should contain a label outlet for ProductSubtitle")
    }
    
    func test_btn_Menu_Outlet_Exists(){
        XCTAssertNotNil(sut!.btn_Menu, "MainController should contain a label outlet for ProductSubtitle")
    }
    func test_btn_Menu_hasTarget_Action(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_Menu, actionName: "btn_Menu_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_TopBackGroundView_Exist(){
        XCTAssertNotNil(sut!.TopBackGroundView, "MainController should contain an Outlet for a view above the Menu View")
    }
    func test_MenuBackgroundContainer_Exists(){
        XCTAssertNotNil(sut!.MenuBackgroundContainer, "MainController should contain an Outlet as Container for the Menu Background")
    }
    func test_btn_ProductInformation_Exist(){
        XCTAssertNotNil(sut!.btn_ProductInformation, "btn_ProductInformation should exist to show product informations")
    }
    func test_btn_ProductInformation_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_ProductInformation, actionName: "btn_ProductInformation_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_ProductInformationSheet_Exists(){
        XCTAssertNotNil(sut!.ProductInformationSheet, "ProductInformationSheet should exist to hold an textview with product informations")
    }
    func test_ProductInformationTextView_Exists(){
        XCTAssertNotNil(sut!.ProductInformationTextView, "ProductInformationTextView should exist for product informations")
    }
    func test_lbl_OldPrice_Exists(){
        XCTAssertNotNil(sut!.lbl_OldPrice, "lbl_OldPrice should exist to show old price of product")
    }
    func test_OldPriceBlurryView_Exists(){
        XCTAssertNotNil(sut!.OldPriceBlurryView, "OldPriceBlurryView should exist to hold old prodcut price")
    }
    func test_OldPriceBlurryViewBottomConstraint_Exists(){
        XCTAssertNotNil(sut!.OldPriceBlurryViewBottomConstraint, "OldPriceBlurryViewBottomConstraint should exist to set OldPrice position from Bottom")
    }
    func test_lbl_NewPrice_Exists(){
        XCTAssertNotNil(sut!.lbl_NewPrice, "lbl_NewPrice should exist to show new price")
    }
    func test_NewPriceBlurryView_Exists(){
        XCTAssertNotNil(sut!.NewPriceBlurryView, "NewPriceBlurryView should exist to hold new price label")
    }
    func test_btn_MenuAccount_Exists(){
    XCTAssertNotNil(sut!.btn_MenuAccount, "btn_MenuAccount should exist")
    }
    func test_btn_MenuAccount_Pressed_isWired_ToAction(){
    XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_MenuAccount, actionName: "btn_MenuAccount_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_SegueToYourAccount_IdentifierExists() {
        let identifiers = segues(ofViewController: sut!)
        XCTAssertTrue(identifiers.contains("SegueToYourAccountController"))
    }
    func test_btn_MenuNews_Exists(){
    XCTAssertNotNil(sut!.btn_MenuNews, "btn_MenuNews should exist")
    }
    func test_btn_MenuNews_isWired_ToAction(){
    XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_MenuNews, actionName: "btn_MenuNews_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_SegueToNewsController_IdentifierExists() {
        let identifiers = segues(ofViewController: sut!)
        XCTAssertTrue(identifiers.contains("SegueToNewsController"))
    }
    
    
    // Mark: - Segues Helper Methods
    func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
    
    //MARK: - Button action test helper
    func checkActionForOutlet(outlet: UIButton?, actionName: String, event: UIControlEvents, controller: UIViewController)->Bool{
        if let unwrappedButton = outlet {
             let actions: [String] = unwrappedButton.actions(forTarget: controller, forControlEvent: event)! as [String]
                let myActionName:String = actionName.appending("WithSender:")
                return actions.contains(myActionName)
        }
        return false
    }
}
