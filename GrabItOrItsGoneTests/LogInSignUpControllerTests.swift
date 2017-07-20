//
//  LogInSignUpControllerTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 07.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import XCTest
@testable import GrabItOrItsGone

class LogInSignUpControllerTests: XCTestCase {
    var storyboard:UIStoryboard!
    var sut:LogInSignUpController?
    
    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        sut = navigationController?.topViewController as? LogInSignUpController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController?.view)
        XCTAssertNotNil(sut?.view)
        sut?.viewDidLoad()
        sut?.viewWillAppear(false)
        sut?.didReceiveMemoryWarning()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Activity Animation
    func test_ActivityIndicatior_InitialAlphaValue_isZero(){
        XCTAssertTrue(sut!.ActivityIndicator.alpha == 0, "Initial alpha of ActivityIndicator should be 0")
    }
    func test_IFirebaseWebServiceDelegate_isSet() {
        XCTAssertNotNil(sut!.facade.firebaseClient.delegate, "facade.firebaseClient.delegate not set IFirebaseWebService!")
    }
    func  test_lbl_GrabIt_Header_Exists(){
        XCTAssertNotNil(sut!.lbl_GrabIt_Header, "lbl_GrabIt_Header should exist")
    }
    func  test_lbl_GrabIt_Header_Contains_GrabIt(){
        XCTAssertTrue(sut!.lbl_GrabIt_Header.text! == "90 seconds", "lbl_GrabIt_Header should contain '90 seconds'")
    }
    func test_LogInSignUpBG_Exists(){
        XCTAssertNotNil(sut!.LogInSignUpBGImage, "LogInSignUpBGImage Background image should exist!")
    }
    func test_lbl_Subtitle_Exists(){
        XCTAssertNotNil(sut!.lbl_Subtitle, "lbl_Subtitle Background image should exist!")
    }
    func test_lbl_Subtitle_Contains_BeforeItsGone(){
        XCTAssertTrue(sut!.lbl_Subtitle.text! == "Or it's gone", "lbl_Subtitle.Text should contain 'Before it's gone'")
    }
    func test_btn_SignUp_Exists(){
        XCTAssertNotNil(sut!.btn_SignUp, "btn_SignUp should exist!")
    }
    func test_btn_SignUp_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_SignUp, actionName: "btn_SignUp_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_btn_Login_Exists(){
        XCTAssertNotNil(sut!.btn_Login, "btn_Login should exist!")
    }
    func test_btn_Login_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_Login, actionName: "btn_Login_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_btn_Guest_Exist(){
        XCTAssertNotNil(sut!.btn_Guest, "LoginSignUpController should contain btn_Guest for guest login")
    }
    func test_btn_Guest_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_Guest, actionName: "btn_Guest_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_btn_CustomFacebookLogin_Exists(){
        XCTAssertNotNil(sut!.btn_CustomFacebookLogin, "btn_CustomFacebookLogin should exist")
    }
    func test_btn_CustomFacebookLogin_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_CustomFacebookLogin, actionName: "btn_FacebookLogin_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_btn_CustomGoogleLogin_Exists(){
        XCTAssertNotNil(sut!.btn_CustomGoogleLogin, "btn_CustomGoogleLogin should exist")
    }
    func test_btn_CustomGoogleLogin_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_CustomGoogleLogin, actionName: "btn_CustomGoogleLogin_Pressed", event: .touchUpInside, controller: sut! ))
    }
    
    //MARK: - LoginView
    func test_LoginView_Exists(){
        XCTAssertNotNil(sut!.LoginPopUp, "LoginPopUp should exist")
    }
    func test_PopUpBlurrScreenView_Exists(){
        XCTAssertNotNil(sut!.PopUpBlurrScreenView, "PopUpBlurrScreenView shhould exist!")
    }
    func test_PopUpBlurrScreenView_Alpha_IsSetTo0_OnStart(){
        XCTAssertTrue(sut!.PopUpBlurrScreenView.alpha == 0, "PopUpBlurrScreenView.alpha should be 0 on start")
    }
    func test_txt_Login_Email_Exists(){
        XCTAssertNotNil(sut!.txt_Login_Email, "txt_Login_Email should exist")
    }
    func test_txt_Login_Email_Placeholder_isSet(){
        XCTAssertTrue(sut!.txt_Login_Email.placeholder != "", "Missing placeholder value")
    }
    func test_txt_Login_Email_Placeholder_isNotNil(){
        XCTAssertNotNil(sut!.txt_Login_Email.placeholder, "Placeholder not set")
    }
    func test_txt_Login_Password_Exists(){
        XCTAssertNotNil(sut!.txt_Login_Password, "txt_Login_Password should exist")
    }
    func test_txt_Login_Password_IsSecureTextEntry(){
        XCTAssertTrue(sut!.txt_Login_Password.isSecureTextEntry, "txt_Login_Password should be secure text entry")
    }
    func test_btn_LogIn_PopUp_Exist(){
        XCTAssertNotNil(sut!.btn_LogIn_PopUp, "btn_LogIn_PopUp should exist")
    }
    func test_btn_LogIn_PopUp_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_LogIn_PopUp, actionName: "btn_LogIn_PopUp_Pressed", event: .touchUpInside, controller: sut! ))
    }
    func test_btn_PasswordForgotten_Exists(){
        XCTAssertNotNil(sut!.btn_PasswordForgotten, "btn_PasswordForgotten should exist")
    }
    func test_btn_PasswordForgotten_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_PasswordForgotten, actionName: "btn_PasswordForgotten_Pressed", event: .touchUpInside, controller: sut! ))
    }
    
    //MARK: - RegisterPopUp
    func test_RegisterPopUp_Exists(){
        XCTAssertNotNil(sut!.RegisterPopUp, "RegisterPopUp should exist")
    }
    func test_btn_SignUp_PopUp_Exists(){
        XCTAssertNotNil(sut!.btn_SignUp_PopUp, "btn_SignUp_PopUp should exist")
    }
    func test_btn_SignUp_PopUp_isWired_ToAction(){
        XCTAssertTrue(checkActionForOutlet(outlet: sut!.btn_SignUp_PopUp, actionName: "btn_SignUp_PopUp_Pressed", event: .touchUpInside, controller: sut! ))
    } 
    
    // Mark: - Segues Helper Methods
    func test_SegueToMainController_IdentifierExists() {
        let identifiers = segues(ofViewController: sut!)
        XCTAssertTrue(identifiers.contains("SegueToMainController"))
    }
    func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
    
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
