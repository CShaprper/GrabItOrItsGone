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
}
