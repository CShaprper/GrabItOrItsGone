//
//  MainController.swift
//  GrabIt
//
//  Created by Peter Sypek on 25.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseMessaging

extension Double {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

class MainController: UIViewController, IFirebaseWebService{
    //MARK: - Outlets
    @IBOutlet var MainBackgroundImage: UIImageView!
    @IBOutlet var CardView: DesignableUIView!
    @IBOutlet var TopBackGroundView: UIView!
    @IBOutlet var MenuBackgroundContainer: UIView!
    //Menu Buttons
    @IBOutlet var btn_MenuNews: UIButton!
    @IBOutlet var btn_Warenkorb: UIButton!
    @IBOutlet var btn_MenuGutscheine: UIButton!
    @IBOutlet var btn_MenuAccount: UIButton!
    @IBOutlet var btn_ProductInformation: UIButton!
    @IBOutlet var btn_News: UIButton!
    @IBOutlet var btn_ShoppingCart: UIButton!
    @IBOutlet var btn_Favorites: UIButton!
    @IBOutlet var SoundSwitch: UISwitch!
    @IBOutlet var SoundImage: UIImageView!
    @IBOutlet var SoundStack: UIStackView!
    @IBOutlet var btn_AdminAddProduct: UIButton!
    @IBOutlet var btn_Menu: DesignableUIButton!
    
    //Product Information sheet
    @IBOutlet var ProductInformationSheet: UIView!
    @IBOutlet var ProductInformationTextView: UITextView!
    @IBOutlet var NewPriceInfoSheet: UILabel!
    
    //Product Card
    @IBOutlet var lbl_OldPrice: UILabel!
    @IBOutlet var OldPriceBlurryView: UIVisualEffectView!
    @IBOutlet var OldPriceBlurryViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var lbl_NewPrice: UILabel!
    @IBOutlet var NewPriceBlurryView: UIVisualEffectView!
    @IBOutlet var CardBackgrounImageView: UIImageView!
    @IBOutlet var ProductImageView: UIImageView!
    @IBOutlet var lbl_ProductTitle: UILabel!
    @IBOutlet var lbl_ProductSubtitle: UILabel!
    
    //NopeLabel
    @IBOutlet var NopeLabelContainer: UIView!
    @IBOutlet var lbl_Nope: UILabel!
    @IBOutlet var Nope2LabelContainer: UIView!
    
    //BuyLabel
    @IBOutlet var BuyLabelContainer: UIView!
    @IBOutlet var lbl_buy: UILabel!
    @IBOutlet var Buy2LabelContainer: UIView!
    
    //FavoritesLabel
    @IBOutlet var FavoritesLabelContainer: UIView!
    @IBOutlet var lbl_Favorites: UILabel!
    
    //Nope Favorites Buy Buttons
    @IBOutlet var btn_Nope: UIButton!
    @IBOutlet var btn_RoundFavorites: UIButton!
    @IBOutlet var btn_Buy: UIButton!
    
    
    
    
    //MARK: Members
    let style = UIStyleHelper()
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var isMenuOut = false
    var isProductInformationSheetVisible:Bool = false
    let productCard:ProductCard = ProductCard()
    var facade:MainControllerFacade!
    var isFavoritesVisible:Bool = false
    var isBuyVisible:Bool = false
    var isNopeVisible:Bool = false
    
    
    //MARK: - ViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup Views
        SetupMainControllerViews()
        self.facade.firebaseClient.ReadFirebaseProductsSection()
    }
    override func viewDidAppear(_ animated: Bool) {
        style.AddToViewsForStyling(views: [MainBackgroundImage])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isOpaque  = false
        SetSoundSwitchValue()
        //Reset products array to index 0 otherwise index out of range exception on swipe
        ResetProductArrayIndexAfterCategoryChange()
        //For some reason product array.count is 0 when returning from YourAccountController second level
        ReloadArrayDataWhenCountIsZero()
    }
    override func viewWillDisappear(_ animated: Bool) {
        style.RemoveViewsForStyling(views: [MainBackgroundImage])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //MARK: - Wired Actions
    @objc func SoundSwitch_Changed(sender: UISwitch) -> Void {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.SoundsOn.rawValue)
            SoundImage.image =  #imageLiteral(resourceName: "SoundOn-icon")
        } else {
            UserDefaults.standard.set(false, forKey: eUserDefaultKeys.SoundsOn.rawValue)
            SoundImage.image =   #imageLiteral(resourceName: "SoundOff-icon")
        }
    }
    @objc func btn_AdminAddProduct_Pressed(sender: UIButton) -> Void{
        performSegue(withIdentifier: String.SegueToAdminAddProductController_Identifier, sender: nil)
    }
    @objc func LogOutBarButtonItemPressed(sender: UIBarButtonItem) -> Void{
        let loginService = facade.GetUserLoggedInService()
        if loginService == .guest || loginService == .facebook  || loginService == .google || loginService == .instagram {
            SegueToLogInController(notification: Notification(name: NSNotification.Name.SegueToLogInController))
        }
        facade.LogoutFirebaseUser()
    }
    @objc func btn_Menu_Pressed(sender: DesignableUIButton) -> Void {
        if isMenuOut {
            HideMenu(closure: {})
            return
        }
        if isProductInformationSheetVisible{
            HideInformationSheet()
        }
        ShowMenu(closure: {})
    }
    @objc func btn_Warenkorb_Pressed(sender: UIButton) -> Void{
        performSegue(withIdentifier: String.SegueToBasketController_Identifier, sender: nil)
    }
    @objc func btn_MenuAccount_Pressed(sender: UIButton) -> Void {
        if UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue){
            let title = String.NoRegisteredUserAlert_TitleString
            let message = String.NoRegisteredUserAlert_MessageString
            AlertFromFirebaseService(title: title, message: message)
            return
        }
        if isMenuOut {  HideMenu(closure: PerformSegueToYourAccountController ) }
        else { PerformSegueToYourAccountController() }
    }
    @objc func btn_ProductInformation_Pressed(sender: UIButton) -> Void {
        
        if !isProductInformationSheetVisible{
            
            if isMenuOut{ HideMenu(closure: {}) }
            ShowInformationSheet()
            
        }
        else {  HideInformationSheet() }
        
    }
    
    @objc func btn_MenuNews_Pressed(sender: UIButton) -> Void {
        
        if isMenuOut{  HideMenu(closure: PerformSegueToNewsConroller )
        } else { PerformSegueToNewsConroller() }
        
    }
    
    @objc func btn_Favorites_Pressed(sender: UIButton) -> Void{
        
        performSegue(withIdentifier: String.SegueToFavoritesControllerFromMain_Itendifier, sender: nil)
        
    }
    
    var direction:String = ""
    @IBAction func CardPanRecocnizerAction(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        let yFromCenter = card.center.y - view.center.y
        let swipeLimitLeft = view.frame.width * 0.4 // left border when the card gets animated off
        let swipeLimitRight = view.frame.width * 0.6 // right border when the card gets animated off
        let swipeLimitTop = view.frame.height * 0.5 // top border when the card gets animated off
        let swipeLimitBottom = view.frame.height * 0.65 // top border when the card gets animated off
        let ySpin:CGFloat = yFromCenter < 0 ? -200 : 200 // gives the card a spin in y direction
        let xSpin:CGFloat = xFromCenter < 0 ? -200 : 200 // gives the card a spin in x direction
        let xPercentFromCenter = xFromCenter / (view.frame.width * 0.5)
        let yPercentFromCenter = yFromCenter / (view.frame.height * 0.3)
        let velocity:CGPoint = sender.velocity(in: view)
        
    
        print("xpercentfromCenter: \(xPercentFromCenter)")
        print("ypercentfromCenter: \(yPercentFromCenter)")
        print("Velocity X: \(velocity.x)")
        print("Velocity Y: \(velocity.y)")
        print("Current direction: \(direction)")
        if abs(velocity.y) > abs(velocity.x) {
            direction = "y"
        } else if abs(velocity.y) < abs(velocity.x) {
            direction = "x"
        }
        
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if xPercentFromCenter > 0 && !isFavoritesVisible && (direction == "" || direction == "x"){
            
            view.bringSubview(toFront: BuyLabelContainer)
            BuyLabelContainer.alpha = abs(xPercentFromCenter)
            isBuyVisible = true
            FavoritesLabelContainer.alpha = 0
            
        } else if xPercentFromCenter < 0 && !isFavoritesVisible && (direction == "" || direction == "x"){
            
            view.bringSubview(toFront: NopeLabelContainer)
            NopeLabelContainer.alpha = abs(xPercentFromCenter)
            isNopeVisible = true
            FavoritesLabelContainer.alpha = 0
            
        } else if yPercentFromCenter > 0.2 && !isNopeVisible && !isBuyVisible && (direction == "" || direction == "y") {
            
            view.bringSubview(toFront: FavoritesLabelContainer)
            FavoritesLabelContainer.alpha = yPercentFromCenter
            isFavoritesVisible = true
            BuyLabelContainer.alpha = 0
            NopeLabelContainer.alpha = 0
            
        }
        
        //Rotate card while drag
        let degree:Double = Double(xFromCenter / ((view.frame.size.width * 0.5) / 40))
        card.transform = CGAffineTransform(rotationAngle: -degree.degreesToRadians)
        card.transform = CGAffineTransform(rotationAngle: -degree.degreesToRadians)
        
        //Animate card after drag ended
        if sender.state == UIGestureRecognizerState.ended{
            let swipeDuration = 0.3
            // Move off to the left side if drag reached swipeLimitLeft
            if card.center.x < swipeLimitLeft{
                SwipeCardOffLeft(swipeDuration: swipeDuration, card: card, ySpin: ySpin)
                return
            } else if card.center.x > swipeLimitRight{
                //Move off to the right side if drag reached swipeLimitRight
                SwipeCardOffRight(swipeDuration: swipeDuration, card: card, ySpin: ySpin)
                return
            } else if card.center.y < swipeLimitTop{
                //Move off the top side if drag reached swipeLimitTop
                //SwipeCardOffTop(swipeDuration: swipeDuration, card: card, xSpin: xSpin)
                self.ResetCardAfterSwipeOff(card: card)
                return
            } else if card.center.y > swipeLimitBottom {
                if UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue){
                    let title = String.NoRegisteredUserAlert_TitleString
                    let message = String.NoRegisteredUserAlert_MessageString
                    AlertFromFirebaseService(title: title, message: message)
                    ResetCardAfterSwipeOff(card: card)
                    return
                } else {
                    //Move downways if drag reached swipe limit bottom
                    SwipeCardOffBottom(swipeDuration: swipeDuration, card: card, xSpin: xSpin)
                    OperationQueue.main.addOperation {
                        self.facade.SaveProductToFavorites(product: productsArray[self.currentImageIndex])
                    }
                    return
                }
            } else {
                // Reset card if no drag limit reached
                self.ResetCardAfterSwipeOff(card: card)
            }
        }
    }
    
    //MARK: Info Sheet pan
    @objc func InfoSheet_Pan(sender: UIPanGestureRecognizer) -> Void {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        let yFromCenter = card.center.y - view.center.y
        let swipeLimitLeft = view.frame.width * 0.4 // left border when the card gets animated off
        let swipeLimitRight = view.frame.width * 0.6 // right border when the card gets animated off
        let swipeLimitTop = view.frame.height * 0.5 // top border when the card gets animated off
        let swipeLimitBottom = view.frame.height * 0.65 // top border when the card gets animated off
        let ySpin:CGFloat = yFromCenter < 0 ? -200 : 200 // gives the card a spin in y direction
        let xSpin:CGFloat = xFromCenter < 0 ? -200 : 200 // gives the card a spin in x direction
        let xPercentFromCenter = xFromCenter / (view.frame.width * 0.5)
        let yPercentFromCenter = yFromCenter / (view.frame.height * 0.3)
        let velocity:CGPoint = sender.velocity(in: view)
        
        
        print("xpercentfromCenter: \(xPercentFromCenter)")
        print("ypercentfromCenter: \(yPercentFromCenter)")
        print("Velocity X: \(velocity.x)")
        print("Velocity Y: \(velocity.y)")
        print("Current direction: \(direction)")
        if abs(velocity.y) > abs(velocity.x) {
            direction = "y"
        } else if abs(velocity.y) < abs(velocity.x) {
            direction = "x"
        }
        
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if xPercentFromCenter > 0 && !isFavoritesVisible && (direction == "" || direction == "x"){
            
            view.bringSubview(toFront: Buy2LabelContainer)
            Buy2LabelContainer.alpha = abs(xPercentFromCenter)
            isBuyVisible = true
            FavoritesLabelContainer.alpha = 0
            
        } else if xPercentFromCenter < 0 && !isFavoritesVisible && (direction == "" || direction == "x"){
            
            view.bringSubview(toFront: Nope2LabelContainer)
            Nope2LabelContainer.alpha = abs(xPercentFromCenter)
            isNopeVisible = true
            FavoritesLabelContainer.alpha = 0
            
        } else if yPercentFromCenter > 0.2 && !isNopeVisible && !isBuyVisible && (direction == "" || direction == "y") {
            
            view.bringSubview(toFront: FavoritesLabelContainer)
            FavoritesLabelContainer.alpha = yPercentFromCenter
            isFavoritesVisible = true
            Buy2LabelContainer.alpha = 0
            Nope2LabelContainer.alpha = 0
            
        }
        
        //Rotate card while drag
        let degree:Double = Double(xFromCenter / ((view.frame.size.width * 0.5) / 40))
        card.transform = CGAffineTransform(rotationAngle: -degree.degreesToRadians)
        card.transform = CGAffineTransform(rotationAngle: -degree.degreesToRadians)
        
        //Animate card after drag ended
        if sender.state == UIGestureRecognizerState.ended{
            let swipeDuration = 0.3
            // Move off to the left side if drag reached swipeLimitLeft
            if card.center.x < swipeLimitLeft{
                SwipeCardOffLeft(swipeDuration: swipeDuration, card: card, ySpin: ySpin)
                return
            } else if card.center.x > swipeLimitRight{
                
                //Move off to the right side if drag reached swipeLimitRight
                SwipeCardOffRight(swipeDuration: swipeDuration, card: card, ySpin: ySpin)
                
                return
                
            } else if card.center.y < swipeLimitTop{
                
                //Move off the top side if drag reached swipeLimitTop
                //SwipeCardOffTop(swipeDuration: swipeDuration, card: card, xSpin: xSpin)
                self.ResetCardAfterSwipeOff(card: card)
                return
                
            } else if card.center.y > swipeLimitBottom {
                
                if UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue){
                    let title = String.NoRegisteredUserAlert_TitleString
                    let message = String.NoRegisteredUserAlert_MessageString
                    AlertFromFirebaseService(title: title, message: message)
                    
                    ResetCardAfterSwipeOff(card: card)
                    
                    return
                    
                } else {
                    
                    //Move downways if drag reached swipe limit bottom
                    SwipeCardOffBottom(swipeDuration: swipeDuration, card: card, xSpin: xSpin)
                   OperationQueue.main.addOperation {
                        self.facade.SaveProductToFavorites(product: productsArray[self.currentImageIndex])
                    }
                    
                    return
                }
            } else {
                // Reset card if no drag limit reached
                self.ResetCardAfterSwipeOff(card: card)
            }
        }
        
    }
    
    @objc func CardView_Tapped(sender: UITapGestureRecognizer) -> Void {
        
        if !isProductInformationSheetVisible{
            if isMenuOut{ HideMenu(closure: {}) }
            ShowInformationSheet()
        }
        else {  HideInformationSheet() }
        
    }
    
    @objc func ProductInfo_Tapped(sender: UITapGestureRecognizer) -> Void {
        
        if !isProductInformationSheetVisible{
            if isMenuOut{ HideMenu(closure: {}) }
            ShowInformationSheet()
        }
        else {  HideInformationSheet() }
        
    }
    
    //MARK: Nope Buy Favorites Button Targets
    @objc func btn_Buy_Pressed(sender: UIButton) -> Void {
        
        SwipeCardOffRight(swipeDuration: 0.3, card: CardView, ySpin: -50)
        
    }
    
    @objc func btn_Nope_Pressed(sender: UIButton) -> Void {
        
        SwipeCardOffLeft(swipeDuration: 0.3, card: CardView, ySpin: -50)
        
    }
    
    @objc func btn_RoundFavorites_Pressed(sender: UIButton) -> Void {
        
        SwipeCardOffBottom(swipeDuration: 0.3, card: CardView, xSpin: -50)
        OperationQueue.main.addOperation {
            self.facade.SaveProductToFavorites(product: productsArray[self.currentImageIndex])
        }
        
    }
    
    
    
    //MARK: - IFirebaseWebservice Implementation
    func AlertFromFirebaseService(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func FirebaseRequestFinished() {
        print("Prodcut data with images received from Firebase")
        if productsArray.count > 0{
            ProductImageView.image =  productsArray[0].ProdcutImage != nil ? productsArray[0].ProdcutImage! : #imageLiteral(resourceName: "Image-placeholder")
            OldPriceBlurryView.alpha = 1
            NewPriceBlurryView.alpha = 1
            lbl_ProductTitle.text = productsArray[0].Title!
            lbl_ProductSubtitle.text = productsArray[0].Subtitle!
            lbl_OldPrice.text = FormatToCurrency(digit: productsArray[0].OriginalPrice!)
            lbl_NewPrice.text = FormatToCurrency(digit:productsArray[0].NewPrice!)
            NewPriceInfoSheet.text = FormatToCurrency(digit: productsArray[0].NewPrice!)
        }
    }
    func FirebaseRequestStarted() {
        
    }
    
    
    
    //MARK: - Helper Functions
    private func SetSoundSwitchValue(){
        //Set Sound Switch value
        if (UserDefaults.standard.object(forKey: eUserDefaultKeys.SoundsOn.rawValue) != nil) {
            let sound = UserDefaults.standard.bool(forKey: eUserDefaultKeys.SoundsOn.rawValue)
            SoundSwitch.setOn(sound, animated: true)
            SoundImage.image = sound == true ?  #imageLiteral(resourceName: "SoundOn-icon") : #imageLiteral(resourceName: "SoundOff-icon")
        }
    }
    private func SwipeCardOffLeft(swipeDuration: TimeInterval, card: UIView, ySpin: CGFloat){
        facade.PlaySwooshSound()
        UIView.animate(withDuration: swipeDuration, animations: {
            card.center.x = card.center.x - self.view.frame.size.width
            card.center.y = card.center.y + ySpin
        }, completion: { (true) in
            //Card arise in Center for new view
            self.ResetCardAfterSwipeOff(card: card)
            self.SetNewCardProdcutAfterSwipe(card: card)
        })
    }
    private func SwipeCardOffRight(swipeDuration: TimeInterval, card: UIView, ySpin: CGFloat){
        facade.PlaySwooshSound()
        UIView.animate(withDuration: swipeDuration, animations: {
            card.center.x = card.center.x + self.view.frame.size.width
            card.center.y = card.center.y + ySpin
        }, completion: { (true) in
            //Card arise in Center for new view
            self.ResetCardAfterSwipeOff(card: card)
            self.SetNewCardProdcutAfterSwipe(card: card)
        })
    }
    private func SwipeCardOffTop(swipeDuration: TimeInterval, card: UIView, xSpin: CGFloat){
        facade.PlaySwooshSound()
        UIView.animate(withDuration: swipeDuration, animations: {
            card.center.y = card.center.y - self.view.frame.size.height
            card.center.x = card.center.x + xSpin
        }, completion: { (true) in
            //Card arise in Center for new view
            self.ResetCardAfterSwipeOff(card: card)
            self.SetNewCardProdcutAfterSwipe(card: card)
        })
    }
    private func SwipeCardOffBottom(swipeDuration: TimeInterval, card: UIView, xSpin: CGFloat){
        facade.PlayYeahSound()
        UIView.animate(withDuration: swipeDuration, animations: {
            card.center.y = card.center.y + self.view.frame.size.height
            card.center.x = card.center.x + xSpin
        }, completion: { (true) in
            //Card arise in Center for new view
            self.ResetCardAfterSwipeOff(card: card)
            self.SetNewCardProdcutAfterSwipe(card: card)
        })
    }
    var currentImageIndex:Int = 0
    private func SetNewCardProdcutAfterSwipe(card: UIView){
        print(productsArray.count)
        if productsArray.count > 0{
            OldPriceBlurryView.alpha = 1
            NewPriceBlurryView.alpha = 1
            currentImageIndex = currentImageIndex == productsArray.count - 1 ? 0 : currentImageIndex + 1
            ProductImageView.image = productsArray[currentImageIndex].ProdcutImage
            lbl_ProductTitle.text = productsArray[currentImageIndex].Title!
            lbl_ProductSubtitle.text = productsArray[currentImageIndex].Subtitle!
            ProductInformationTextView.text = productsArray[currentImageIndex].Productinformation!
            
            lbl_OldPrice.text = FormatToCurrency(digit: productsArray[currentImageIndex].OriginalPrice!)
            lbl_NewPrice.text = FormatToCurrency(digit: productsArray[currentImageIndex].NewPrice!)
            NewPriceInfoSheet.text = FormatToCurrency(digit: productsArray[currentImageIndex].NewPrice!)
        }
    }
    private func ReloadArrayDataWhenCountIsZero(){
        if productsArray.count == 0{
            facade.firebaseClient.ReadFirebaseProductsSection()
        }
    }
    private func ResetProductArrayIndexAfterCategoryChange(){
        if productsArray.count > 0 && UserDefaults.standard.bool(forKey: eUserDefaultKeys.hasUncheckedCategory.rawValue){
            UserDefaults.standard.set(false, forKey: eUserDefaultKeys.hasUncheckedCategory.rawValue)
            OldPriceBlurryView.alpha = 1
            NewPriceBlurryView.alpha = 1
            currentImageIndex = 0
            ProductImageView.image = productsArray[currentImageIndex].ProdcutImage
            lbl_ProductTitle.text = productsArray[currentImageIndex].Title!
            lbl_ProductSubtitle.text = productsArray[currentImageIndex].Subtitle!
            ProductInformationTextView.text = productsArray[currentImageIndex].Productinformation!
            
            lbl_OldPrice.text = FormatToCurrency(digit: productsArray[currentImageIndex].OriginalPrice!)
            lbl_NewPrice.text = FormatToCurrency(digit: productsArray[currentImageIndex].NewPrice!)
            NewPriceInfoSheet.text = FormatToCurrency(digit: productsArray[currentImageIndex].NewPrice!)
        }
    }
    private func ResetCardAfterSwipeOff(card: UIView){
        
        direction = ""
        isNopeVisible = false
        isFavoritesVisible = false
        isBuyVisible = false
        Nope2LabelContainer.alpha = 0
        Buy2LabelContainer.alpha = 0
        NopeLabelContainer.alpha = 0
        BuyLabelContainer.alpha = 0
        FavoritesLabelContainer.alpha = 0
        card.alpha = 0
        card.center = self.view.center
        card.transform = CGAffineTransform(rotationAngle: Double(0).degreesToRadians)
        card.Arise(duration: 0.7, delay: 0, options: [.allowUserInteraction], toAlpha: 1)
        
        if isProductInformationSheetVisible { HideInformationSheet() }
        
    }
    
    @objc func SegueToLogInController(notification: Notification) -> Void {
        navigationController?.popViewController(animated: true)
    }
    func PerformSegueToYourAccountController() -> Void {
        performSegue(withIdentifier: .SegueToYourAccountController_Identifer, sender: nil)
    }
    func PerformSegueToNewsConroller()->Void{
        performSegue(withIdentifier: .SegueToNewsController_Identifier, sender: nil)
    }
    private func FormatToCurrency(digit: Double) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: digit as NSNumber)!
    }
    
    //MARK: VC Setup
    private func SetupMainControllerViews() -> Void {
        
        //Hide back button to show custom Button
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "log out", style: UIBarButtonItemStyle.plain, target: self, action:#selector(LogOutBarButtonItemPressed))
        newBackButton.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = newBackButton
        
        //Main Backgroundimage
        //MainBackgroundImage.image = UIImage(named: "NatureBG")
        
        //NopeLabel
        NopeLabelContainer.transform = CGAffineTransform(rotationAngle: Double(30).degreesToRadians)
        NopeLabelContainer.layer.borderWidth = 3
        NopeLabelContainer.layer.borderColor = UIColor.red.cgColor
        NopeLabelContainer.layer.cornerRadius = 5
        NopeLabelContainer.alpha = 0
        
        //BuyLabel
        BuyLabelContainer.transform = CGAffineTransform(rotationAngle: Double(-30).degreesToRadians)
        BuyLabelContainer.layer.borderWidth = 3
        BuyLabelContainer.layer.borderColor = UIColor.green.cgColor
        BuyLabelContainer.layer.cornerRadius = 5
        BuyLabelContainer.alpha = 0
        
        
        //Nope2Label
        Nope2LabelContainer.transform = CGAffineTransform(rotationAngle: Double(30).degreesToRadians)
        Nope2LabelContainer.layer.borderWidth = 3
        Nope2LabelContainer.layer.borderColor = UIColor.red.cgColor
        Nope2LabelContainer.layer.cornerRadius = 5
        Nope2LabelContainer.alpha = 0
        
        //Buy2Label
        Buy2LabelContainer.transform = CGAffineTransform(rotationAngle: Double(-30).degreesToRadians)
        Buy2LabelContainer.layer.borderWidth = 3
        Buy2LabelContainer.layer.borderColor = UIColor.green.cgColor
        Buy2LabelContainer.layer.cornerRadius = 5
        Buy2LabelContainer.alpha = 0
        
        //FavoritesLabelContainer
        FavoritesLabelContainer.layer.borderWidth = 3
        FavoritesLabelContainer.layer.borderColor = UIColor.yellow.cgColor
        FavoritesLabelContainer.layer.cornerRadius = 5
        FavoritesLabelContainer.alpha = 0
        
        //Card view
        CardView.center = view.center
        CardView.layer.cornerRadius = 20
        CardView.clipsToBounds = true
        CardView.layer.borderColor = UIColor.lightGray.cgColor
        CardView.layer.borderWidth = 2
        CardBackgrounImageView.backgroundColor = UIColor.white
        
        //Imageview of CardView
        ProductImageView.image = #imageLiteral(resourceName: "Image-placeholder")
        ProductImageView.layer.cornerRadius = 20
        ProductImageView.clipsToBounds = true
        
        //OldPrice label of CardView
        OldPriceBlurryViewBottomConstraint.constant = (ProductImageView.frame.size.height * 0.7)
        OldPriceBlurryView.layer.cornerRadius = 10
        OldPriceBlurryView.clipsToBounds = true
        OldPriceBlurryView.transform = CGAffineTransform(rotationAngle: Double(-35).degreesToRadians)
        OldPriceBlurryView.alpha = 0
        lbl_ProductTitle.text = ""
        lbl_ProductSubtitle.text = ""
        lbl_OldPrice.text = ""
        lbl_NewPrice.text = ""
        
        //NewPrice label of CardView
        NewPriceBlurryView.layer.cornerRadius = 10
        NewPriceBlurryView.clipsToBounds = true
        NewPriceBlurryView.alpha = 0
        
        //Product Info Sheet
        ProductInformationSheet.alpha = 0
        ProductInformationSheet.transform = CGAffineTransform(translationX: 0, y: (ProductInformationSheet.frame.size.height + 100))
        ProductInformationSheet.layer.cornerRadius = 20
        ProductInformationSheet.layer.borderColor = UIColor.lightGray.cgColor
        ProductInformationSheet.layer.borderWidth = 2
        
        if UserDefaults.standard.bool(forKey: eUserDefaultKeys.isAdmin.rawValue){
            btn_AdminAddProduct.alpha = 1
        } else {
            btn_AdminAddProduct.alpha = 0
        }
        
        //Wire targets
        btn_Menu.addTarget(self, action: #selector(btn_Menu_Pressed), for: .touchUpInside)
        btn_ProductInformation.addTarget(self, action: #selector(btn_ProductInformation_Pressed), for: .touchUpInside)
        btn_MenuAccount.addTarget(self, action: #selector(btn_MenuAccount_Pressed), for: .touchUpInside)
        btn_MenuNews.addTarget(self, action: #selector(btn_MenuNews_Pressed), for: .touchUpInside)
        btn_Warenkorb.addTarget(self, action: #selector(btn_Warenkorb_Pressed), for: .touchUpInside)
        SoundSwitch.addTarget(self, action: #selector(SoundSwitch_Changed), for: .valueChanged)
        btn_Favorites.addTarget(self, action: #selector(btn_Favorites_Pressed), for: .touchUpInside)
        btn_News.addTarget(self, action: #selector(btn_MenuNews_Pressed), for: .touchUpInside)
        btn_AdminAddProduct.addTarget(self, action: #selector(btn_AdminAddProduct_Pressed), for: .touchUpInside)
        btn_ShoppingCart.addTarget(self, action: #selector(btn_Warenkorb_Pressed), for: .touchUpInside)
        
        
        //Transform UIControls to initial position
        // FavoritesStarImage.transform = CGAffineTransform(translationX: 0, y: FavoritesStarImage.frame.size.height * 0.4)
        btn_MenuNews.transform = CGAffineTransform(translationX: btn_MenuNews.frame.size.width + 100, y: 0)
        btn_Warenkorb.transform = CGAffineTransform(translationX: btn_Warenkorb.frame.size.width + 100, y: 0)
        btn_MenuGutscheine.transform = CGAffineTransform(translationX: btn_MenuGutscheine.frame.size.width + 100, y: 0)
        btn_MenuAccount.transform = CGAffineTransform(translationX: btn_MenuAccount.frame.size.width + 100, y: 0)
        SoundStack.transform = CGAffineTransform(translationX: SoundStack.frame.size.width + 100, y: 0)
        
        facade = MainControllerFacade(presentingController: self)
        facade.CheckForSoundSetting()
        facade.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(SegueToLogInController), name: NSNotification.Name.SegueToLogInController, object: nil)
        
        //TapRecognizer
        let cardTapRegognizer = UITapGestureRecognizer(target: self, action: #selector(CardView_Tapped))
        CardView.addGestureRecognizer(cardTapRegognizer)
        
        let productInfoTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProductInfo_Tapped))
        ProductInformationSheet.addGestureRecognizer(productInfoTapRecognizer)
        
        //PanRecognizer
        let infoSheetPanRecognizer = UIPanGestureRecognizer(target: self, action: #selector(InfoSheet_Pan))
        ProductInformationSheet.addGestureRecognizer(infoSheetPanRecognizer)
        
        //Nope Buy Favorites Buttons
        btn_Buy.addTarget(self, action: #selector(btn_Buy_Pressed), for: .touchUpInside)
        btn_Nope.addTarget(self, action: #selector(btn_Nope_Pressed), for: .touchUpInside)
        btn_RoundFavorites.addTarget(self, action: #selector(btn_RoundFavorites_Pressed), for: .touchUpInside)
    }
    private func ShowInformationSheet(){
        isProductInformationSheetVisible = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.TopBackGroundView.transform = CGAffineTransform(translationX: 0, y: -self.TopBackGroundView.frame.size.height ).scaledBy(x: 0.7, y: 0.7)
            self.ProductInformationSheet.alpha = 1
            self.TopBackGroundView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.ProductInformationSheet.transform = .identity
        }, completion: nil)
    }
    
    private func HideInformationSheet(){
        isProductInformationSheetVisible = false
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.TopBackGroundView.transform = .identity
            self.TopBackGroundView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.ProductInformationSheet.transform = CGAffineTransform(translationX: 0, y: (self.ProductInformationSheet.frame.size.height + 100))
        }, completion: nil)
    }
    private func HideMenu(closure: @escaping () -> Void){
        isMenuOut = false
        self.TopBackGroundView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.TopBackGroundView.transform = .identity
            self.TopBackGroundView.alpha = 1
        }, completion: {(true) in
            //self.PerformSegueToYourAccountController()
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_MenuNews.transform = CGAffineTransform(translationX: self.btn_MenuNews.frame.size.width + 100, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_Warenkorb.transform  = CGAffineTransform(translationX: self.btn_Warenkorb.frame.size.width + 100, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_MenuGutscheine.transform = CGAffineTransform(translationX: self.btn_MenuGutscheine.frame.size.width + 100, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_MenuAccount.transform = CGAffineTransform(translationX: self.btn_MenuAccount.frame.size.width + 100, y: 0)
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.SoundStack.transform = CGAffineTransform(translationX: self.SoundStack.frame.size.width + 100, y: 0)
        }, completion: {(true) in
            closure()
        })
    }
    private func ShowMenu(closure: @escaping () -> Void){
        isMenuOut = true
        self.TopBackGroundView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.TopBackGroundView.transform = CGAffineTransform(translationX: -self.view.frame.width * 0.6, y: 0).scaledBy(x: 0.8, y: 0.7)
            self.TopBackGroundView.alpha = 0.7
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_MenuNews.transform = .identity
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_Warenkorb.transform = .identity
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_MenuGutscheine.transform = .identity
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.btn_MenuAccount.transform = .identity
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.SoundStack.transform = .identity
        }, completion: nil)
    }
}
