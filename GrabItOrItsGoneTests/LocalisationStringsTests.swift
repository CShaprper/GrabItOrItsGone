//
//  LocalisationStringsTests.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 07.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//
import XCTest
@testable import GrabItOrItsGone

class LocalisationStringsTests: XCTestCase {
    var storyboard:UIStoryboard!
    var sut:LogInSignUpController?
    //var firebaseUser:UserAuthentication!
    
    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        sut = navigationController?.topViewController as? LogInSignUpController
        _ = sut?.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_btn_SignUp_String_Exist(){
        XCTAssertNotNil(sut!.view.btn_SignUp_String, "btn_SignUp_String should exist for localisation")
    }
    func test_btn_SignUp_String_isLocalized(){
        XCTAssertTrue(sut!.view.btn_SignUp_String != "btn_SignUp_String", "btn_SignUp_String is not localized in strings file!")
    }
    func test_btn_Login_String_Exist(){
        XCTAssertNotNil(sut!.view.btn_Login_String, "btn_Login_String should exist for localisation")
    }
    func test_btn_Login_String_isLocalized(){
        XCTAssertTrue(sut!.view.btn_Login_String != "btn_Login_String", "btn_Login_String is not localized in strings file!")
    }
    func test_txt_Login_Email_Placeholder_String_Exist(){
        XCTAssertNotNil(sut!.view.txt_Login_Email_Placeholder_String, "txt_Login_Email_Placeholder_String should exist for localisation")
    }
    func test_txt_Login_Email_Placeholder_String_isLocalized(){
        XCTAssertTrue(sut!.view.txt_Login_Email_Placeholder_String != "txt_Login_Email_Placeholder_String", "txt_Login_Email_Placeholder_String is not localized in strings file!")
    }
    func test_txt_Login_Password_Placeholder_String_Exist(){
        XCTAssertNotNil(sut!.view.txt_Login_Password_Placeholder_String, "txt_Login_Password_Placeholder_String should exist for localisation")
    }
    func test_txt_Login_Password_Placeholder_String_isLocalized(){
        XCTAssertTrue(sut!.view.txt_Login_Password_Placeholder_String != "txt_Login_Password_Placeholder_String", "txt_Login_Password_Placeholder_String is not localized in strings file!")
    }
    func test_txt_Register_Fullname_Placeholder_String_Exist(){
        XCTAssertNotNil(sut!.view.txt_Register_Fullname_Placeholder_String, "txt_Register_Fullname_Placeholder_String should exist for localisation")
    }
    func test_txt_Register_Fullname_Placeholder_String_isLocalized(){
        XCTAssertTrue(sut!.view.txt_Register_Fullname_Placeholder_String != "txt_Register_Fullname_Placeholder_String", "txt_Register_Fullname_Placeholder_String is not localized in strings file!")
    }
    func test_btn_PasswordForgotten_Title_String_Exist(){
        XCTAssertNotNil(sut!.view.btn_PasswordForgotten_Title_String, "btn_PasswordForgotten_Title_String should exist for localisation")
    }
    func test_btn_PasswordForgotten_Title_String_isLocalized(){
        XCTAssertTrue(sut!.view.btn_PasswordForgotten_Title_String != "btn_PasswordForgotten_Title_String", "btn_PasswordForgotten_Title_String is not localized in strings file!")
    }
    func test_Validation_Error_Message_String_Exist(){
        XCTAssertNotNil(sut!.view.Validation_Error_Message_String, "Validation_Error_Message_String should exist for localisation")
    }
    func test_Validation_Error_Message_String_isLocalized(){
        XCTAssertTrue(sut!.view.Validation_Error_Message_String != "Validation_Error_Message_String", "Validation_Error_Message_String is not localized in strings file!")
    }
    func test_btn_Guest_String_Exist(){
        XCTAssertNotNil(sut!.view.btn_Guest_String, "btn_Guest_String should exist for localisation")
    }
    func test_btn_Guest_String_isLocalized(){
        XCTAssertTrue(sut!.view.btn_Guest_String != "btn_Guest_String", "btn_Guest_String is not localized in strings file!")
    }
    func test_FirebaseUserLoginErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseUserLoginErrorAlert_TitleString, "FirebaseUserLoginErrorAlert_TitleString should exist for localisation")
    }
    func test_FirebaseUserLoginErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseUserLoginErrorAlert_TitleString != "FirebaseUserLoginErrorAlert_TitleString", "FirebaseUserLoginErrorAlert_TitleString is not localized in strings file!")
    }
    func test_FirebaseUserAuthenticationErrorMessage_MessageString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseUserAuthenticationErrorMessage_MessageString, "FirebaseUserAuthenticationErrorMessage_MessageString should exist for localisation")
    }
    func test_FirebaseUserAuthenticationErrorMessage_MessageString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseUserAuthenticationErrorMessage_MessageString != "FirebaseUserAuthenticationErrorMessage_MessageString", "FirebaseUserAuthenticationErrorMessage_MessageString is not localized in strings file!")
    }
    func test_FirebaseUserLoginErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseUserLoginErrorAlert_MessageString, "FirebaseUserLoginErrorAlert_MessageString should exist for localisation")
    }
    func test_FirebaseUserLoginErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseUserLoginErrorAlert_MessageString != "FirebaseUserLoginErrorAlert_MessageString", "FirebaseUserLoginErrorAlert_MessageString is not localized in strings file!")
    }
    func test_FirebaseUserLogoutErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseUserLogoutErrorAlert_TitleString, "FirebaseUserLogoutErrorAlert_TitleString should exist for localisation")
    }
    func test_FirebaseUserLogoutErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseUserLogoutErrorAlert_TitleString != "FirebaseUserLogoutErrorAlert_TitleString", "FirebaseUserLogoutErrorAlert_TitleString is not localized in strings file!")
    }
    func test_FirebaseUserLogoutErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseUserLogoutErrorAlert_MessageString, "FirebaseUserLogoutErrorAlert_MessageString should exist for localisation")
    }
    func test_FirebaseUserLogoutErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseUserLogoutErrorAlert_MessageString != "FirebaseUserLogoutErrorAlert_MessageString", "FirebaseUserLogoutErrorAlert_MessageString is not localized in strings file!")
    }
    func test_EmailValidationErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(sut!.view.EmailValidationErrorAlert_TitleString, "EmailValidationErrorAlert_TitleString should exist for localisation")
    }
    func test_EmailValidationErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(sut!.view.EmailValidationErrorAlert_TitleString != "EmailValidationErrorAlert_TitleString", "EmailValidationErrorAlert_TitleString is not localized in strings file!")
    }
    func test_EmailValidationErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(sut!.view.EmailValidationErrorAlert_MessageString, "EmailValidationErrorAlert_MessageString should exist for localisation")
    }
    func test_EmailValidationErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(sut!.view.EmailValidationErrorAlert_MessageString != "EmailValidationErrorAlert_MessageString", "EmailValidationErrorAlert_MessageString is not localized in strings file!")
    }
    func test_PasswordValidationErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(sut!.view.PasswordValidationErrorAlert_TitleString, "PasswordValidationErrorAlert_TitleString should exist for localisation")
    }
    func test_PasswordValidationErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(sut!.view.PasswordValidationErrorAlert_TitleString != "PasswordValidationErrorAlert_TitleString", "PasswordValidationErrorAlert_TitleString is not localized in strings file!")
    }
    func test_PasswordValidationErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(sut!.view.PasswordValidationErrorAlert_MessageString, "PasswordValidationErrorAlert_MessageString should exist for localisation")
    }
    func test_PasswordValidationErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(sut!.view.PasswordValidationErrorAlert_MessageString != "PasswordValidationErrorAlert_MessageString", "PasswordValidationErrorAlert_MessageString is not localized in strings file!")
    }
    func test_FirebaseResetPasswordErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseResetPasswordErrorAlert_TitleString, "FirebaseResetPasswordErrorAlert_TitleString should exist for localisation")
    }
    func test_FirebaseResetPasswordErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseResetPasswordErrorAlert_TitleString != "FirebaseResetPasswordErrorAlert_TitleString", "FirebaseResetPasswordErrorAlert_TitleString is not localized in strings file!")
    }
    func test_FirebaseResetPasswordErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseResetPasswordErrorAlert_MessageString, "FirebaseResetPasswordErrorAlert_MessageString should exist for localisation")
    }
    func test_FirebaseResetPasswordErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseResetPasswordErrorAlert_MessageString != "FirebaseResetPasswordErrorAlert_MessageString", "FirebaseResetPasswordErrorAlert_MessageString is not localized in strings file!")
    }
    func test_FirebaseThirdPartyLoginErrorAlert_TitleString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseThirdPartyLoginErrorAlert_TitleString, "FirebaseThirdPartyLoginErrorAlert_TitleString should exist for localisation")
    }
    func test_FirebaseThirdPartyLoginErrorAlert_TitleString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseThirdPartyLoginErrorAlert_TitleString != "FirebaseThirdPartyLoginErrorAlert_TitleString", "FirebaseThirdPartyLoginErrorAlert_TitleString is not localized in strings file!")
    }
    func test_FirebaseThirdPartyLoginErrorAlert_MessageString_Exist(){
        XCTAssertNotNil(sut!.view.FirebaseThirdPartyLoginErrorAlert_MessageString, "FirebaseThirdPartyLoginErrorAlert_MessageString should exist for localisation")
    }
    func test_FirebaseThirdPartyLoginErrorAlert_MessageString_isLocalized(){
        XCTAssertTrue(sut!.view.FirebaseThirdPartyLoginErrorAlert_MessageString != "FirebaseThirdPartyLoginErrorAlert_MessageString", "FirebaseThirdPartyLoginErrorAlert_MessageString is not localized in strings file!")
    }
    func test_YourAccount_Controller_TitleString_Exist(){
    XCTAssertNotNil(sut!.view.YourAccount_Controller_TitleString, "YourAccount_Controller_TitleString should exist for localisation")
    }
    func test_YourAccount_Controller_TitleString_isLocalized(){
    XCTAssertTrue(sut!.view.YourAccount_Controller_TitleString != "YourAccount_Controller_TitleString", "YourAccount_Controller_TitleString is not localized in strings file!")
    }
    func test_lbl_manageAddress_String_Exist(){
    XCTAssertNotNil(sut!.view.lbl_manageAddress_String, "lbl_manageAddress_String should exist for localisation")
    }
    func test_lbl_manageAddress_String_isLocalized(){
    XCTAssertTrue(sut!.view.lbl_manageAddress_String != "lbl_manageAddress_String", "lbl_manageAddress_String is not localized in strings file!")
    }
    func test_ManageAddressController_TitleString_Exist(){
    XCTAssertNotNil(sut!.view.ManageAddressController_TitleString, "ManageAddressController_TitleString should exist for localisation")
    }
    func test_ManageAddressController_TitleString_isLocalized(){
    XCTAssertTrue(sut!.view.ManageAddressController_TitleString != "ManageAddressController_TitleString", "ManageAddressController_TitleString is not localized in strings file!")
    }
    func test_SaveAddressError_TitleString_Exist(){
    XCTAssertNotNil(sut!.view.SaveAddressError_TitleString, "SaveAddressError_TitleString should exist for localisation")
    }
    func test_SaveAddressError_TitleString_isLocalized(){
    XCTAssertTrue(sut!.view.SaveAddressError_TitleString != "SaveAddressError_TitleString", "SaveAddressError_TitleString is not localized in strings file!")
    }
    func test_SaveAddressError_MessageString_Exist(){
    XCTAssertNotNil(sut!.view.SaveAddressError_MessageString, "SaveAddressError_MessageString should exist for localisation")
    }
    func test_SaveAddressError_MessageString_isLocalized(){
    XCTAssertTrue(sut!.view.SaveAddressError_MessageString != "SaveAddressError_MessageString", "SaveAddressError_MessageString is not localized in strings file!")
    }
}
