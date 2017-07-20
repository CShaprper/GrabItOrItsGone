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
        sut.viewDidLoad()
        sut.didReceiveMemoryWarning()
    }
    
    override func tearDown() {
        sut = nil
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
    //MARK: - Manage Address Container
    func test_ManageAdressContainer_Exists(){
        XCTAssertNotNil(sut!.ManageAdressContainer, "ManageAdressContainer should exist")
    }
    func test_ManageAdressContainer_isWiredTo_GestureRecognizer(){
        XCTAssertTrue(CheckForGestureRecognizer(view: sut!.ManageAdressContainer), "ManageAdressContainer not wired to GestureRecognizer")
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
    func test_SegueToAddressController_IdentifierExists() {
        XCTAssertTrue(CheckSegueIndentifier(segueIdentifier: "SegueToAddressController"))
    }
    //MARK:- Manage Favorites Container
    func test_ManageFavoritesContainer_Exists(){
        XCTAssertNotNil(sut!.ManageFavoritesContainer, "ManageFavoritesContainer should exist")
    }
    func test_ManageFavoritesContainer_isWiredTo_GestureRecognizer(){
        XCTAssertTrue(CheckForGestureRecognizer(view: sut!.ManageFavoritesContainer), "ManageFavoritesContainer not wired to GestureRecognizer")
    }
    func test_ManageFavoritesImage_Exists(){
        XCTAssertNotNil(sut!.ManageFavoritesImage, "ManageFavoritesImage should exist")
    }
    func test_lbl_ManageFavorites_String_Exist(){
        XCTAssertNotNil(String.lbl_manageFavorites_String, "lbl_manageFavorites_String should exist for localisation")
    }
    func test_lbl_ManageFavoritesTextColor_isSet(){
        XCTAssertEqual(sut!.lbl_ManageFavorites.textColor, sut!.view.tintColor, "lbl_ManageFavorites.textColor should be set")
    }
    func test_lbl_manageFavorites_String_isLocalized(){
        XCTAssertTrue(String.lbl_manageFavorites_String != "lbl_manageFavorites_String", "lbl_manageFavorites_String is not localized in strings file!")
    }
    func test_lbl_ManageFavoritesArrow_Exists(){
        XCTAssertNotNil(sut!.lbl_ManageFavoritesArrow, "lbl_ManageFavoritesArrow should exist")
    }
    func test_lbl_ManageFavoritesArrowTextColor_isSet(){
        XCTAssertEqual(sut!.lbl_ManageFavoritesArrow.textColor, sut!.view.tintColor, "lbl_ManageFavoritesArrow.textColor should be set")
    }
    func test_FilterCategoriesContainer_Exists(){
    XCTAssertNotNil(sut!.FilterCategoriesContainer, "FilterCategoriesContainer should exist")
    }
    func test_FilterCategoriesImage_Exists(){
    XCTAssertNotNil(sut!.FilterCategoriesImage, "FilterCategoriesImage should exist")
    }
    func test_lbl_FilterCategories_Exists(){
    XCTAssertNotNil(sut!.lbl_FilterCategories, "lbl_FilterCategories should exist")
    }
    func test_lbl_FilterCategoriesArrow_Exists(){
    XCTAssertNotNil(sut!.lbl_FilterCategoriesArrow, "lbl_FilterCategoriesArrow should exist")
    }
    func test_FilterCategoriesContainer_isWiredTo_GestureRecognizer(){
        XCTAssertTrue(CheckForGestureRecognizer(view: sut!.FilterCategoriesContainer), "FilterCategoriesContainer not wired to GestureRecognizer")
    }
    func test_PurchasesContainer_Exists(){
    XCTAssertNotNil(sut!.PurchasesContainer, "PurchasesContainer should exist")
    }
    func test_PurchasesContainer_isWiredTo_GestureRecognizer(){
    XCTAssertTrue(CheckForGestureRecognizer(view: sut!.PurchasesContainer), "PurchasesContainer not wired to GestureRecognizer")
    } 
    func test_SegueToFavoritesController_Identifier_Exist(){
        XCTAssertNotNil(String.SegueToFavoritesController_Identifier, "SegueToFavoritesController_Identifier should exist for holding Segue identifier")
    }
    func test_PurchasesImage_Exists(){
    XCTAssertNotNil(sut!.PurchasesImage, "PurchasesImage should exist")
    }
    func test_lbl_Purchases_Exists(){
    XCTAssertNotNil(sut!.lbl_Purchases, "lbl_Purchases should exist")
    }
    func test_lbl_PurchasesArrow_Exists(){
    XCTAssertNotNil(sut!.lbl_PurchasesArrow, "lbl_PurchasesArrow should exist")
    }
    func test_SegueToFavoritesController_Identifier_isSet(){
        XCTAssertTrue(String.SegueToFavoritesController_Identifier == "SegueToFavoritesController", "SegueToFavoritesController_Identifier is not properly set")
    }
    func test_SegueToFavoritesController_IdentifierExists() {
        XCTAssertTrue(CheckSegueIndentifier(segueIdentifier: "SegueToFavoritesController"))
    }
    func test_SegueToCategoriesController_IdentifierExists() {
        XCTAssertTrue(CheckSegueIndentifier(segueIdentifier: "SegueToCategoriesController"))
    }
    func test_SegueToPurchaseController_IdentifierExists() {
        XCTAssertTrue(CheckSegueIndentifier(segueIdentifier: "SegueToPurchaseController"))
    }
    func test_ManageAdressContainer_hasGestureRecognizer(){
        XCTAssertNotNil(sut!.ManageAdressContainer.gestureRecognizers, "ManageAdressContainer should be wired with gesture recognizer")
    }
    func test_ManageFavoritesContainer_hasGestureRecognizer(){
        XCTAssertNotNil(sut!.ManageFavoritesContainer.gestureRecognizers, "ManageFavoritesContainer should be wired with gesture recognizer")
    }
    func test_FilterCategoriesContainer_hasGestureRecognizer(){
        XCTAssertNotNil(sut!.FilterCategoriesContainer.gestureRecognizers, "FilterCategoriesContainer should be wired with gesture recognizer")
    }
    func test_PurchasesContainer_hasGestureRecognizer(){
        XCTAssertNotNil(sut!.PurchasesContainer.gestureRecognizers, "PurchasesContainershould be wired with gesture recognizer")
    }
    
    
    
    //MARK: - Check for UITapGestureRecognizer of view
    func CheckForGestureRecognizer(view: UIView) -> Bool{
        if let _ = view.gestureRecognizers{
            return true
        }
        return false
    }
    
    //MARK: - Segue Identifier Helper
    func CheckSegueIndentifier(segueIdentifier:String) -> Bool{
        let identifiers = segues(ofViewController: sut!)
        if identifiers.contains(segueIdentifier) {
            return true
        }
        return false
    }
    func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.flatMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}
