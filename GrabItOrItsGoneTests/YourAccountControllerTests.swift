import XCTest
@testable import GrabItOrItsGone

class YourAccountControllerTests: XCTestCase {var storyboard:UIStoryboard!
    var sut:YourAccountController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = storyboard.instantiateViewController(withIdentifier: "YourAccountController") as! YourAccountController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(sut.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_BackgroundImage_Exists(){
        XCTAssertNotNil(sut!.BackgroundImage, "BackgroundImage should exist for BG Image")
    }
    func test_BackgroundBlurryView_Exists(){
        XCTAssertNotNil(sut!.BackgroundBlurryView, "BackgroundBlurryView should exist")
    }
    func test_NavigationController_Title() {
        XCTAssertEqual(sut!.navigationItem.title, String.YourAccount_Controller_TitleString)
    }
    func test_ManageAdressContainer_Exists(){
        XCTAssertNotNil(sut!.ManageAdressContainer, "ManageAdressContainer should exist")
    }
    func test_ManageAdressImageView_Exists(){
        XCTAssertNotNil(sut!.ManageAdressImageView, "ManageAdressImageView should exist")
    }
    func test_lbl_manageAddress_Exists(){
        XCTAssertNotNil(sut!.lbl_manageAddress, "lbl_manageAddress should exist")
    }
    func test_lbl_ManageAddressArrow_Exists(){
        XCTAssertNotNil(sut!.lbl_ManageAddressArrow, "lbl_ManageAddressArrow should exist")
    }
    func test_lbl_ManageAddressArrow_isSetToGlobalTint(){
        XCTAssertEqual(sut!.lbl_ManageAddressArrow.textColor, sut!.view.tintColor, "lbl_ManageAddressArrow should be in global tintColor")
    }
    func test_lbl_manageAddress_isLocalized() {
        XCTAssertEqual(sut!.lbl_manageAddress.text, String.lbl_manageAddress_String, "lbl_manageAddress should be localized")
    }
    func test_lbl_manageAddress_isSetToGlobalTintColor(){
        XCTAssertEqual(sut!.lbl_manageAddress.textColor, sut!.view.tintColor, "lbl_manageAddress should be in global tintColor")
    }
    func test_SegueToManageAddressController_IdentifierExists() {
        let identifiers = segues(ofViewController: sut!)
        XCTAssertTrue(identifiers.contains("SegueToManageAddressController"))
    }
    
    
    // Mark: - Segues Helper Methods
    func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}
