//
//  MainController.swift
//  GrabIt
//
//  Created by Peter Sypek on 25.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import AVFoundation

extension Double {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

class MainController: UIViewController, IAlertMessageDelegate {
    //MARK: - Outlets
    @IBOutlet var MainBackgroundImage: UIImageView!
    @IBOutlet var CardView: DesignableUIView!
    @IBOutlet var CardBackgrounImageView: UIImageView!
    @IBOutlet var ProductImageView: UIImageView!
    @IBOutlet var lbl_ProductTitle: UILabel!
    @IBOutlet var lbl_ProductSubtitle: UILabel!
    @IBOutlet var btn_Menu: DesignableUIButton!
    @IBOutlet var TopBackGroundView: UIView!
    @IBOutlet var MenuBackgroundContainer: UIView!
    @IBOutlet var FavoritesStarImage: UIImageView!
    @IBOutlet var btn_MenuNews: UIButton!
    @IBOutlet var btn_MenuFavourites: UIButton!
    @IBOutlet var btn_MenuGutscheine: UIButton!
    @IBOutlet var btn_MenuAccount: UIButton!
    @IBOutlet var btn_ProductInformation: UIButton!
    @IBOutlet var ProductInformationSheet: UIView!
    @IBOutlet var ProductInformationTextView: UITextView!
    @IBOutlet var lbl_OldPrice: UILabel!
    @IBOutlet var OldPriceBlurryView: UIVisualEffectView!
    @IBOutlet var OldPriceBlurryViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var lbl_NewPrice: UILabel!
    @IBOutlet var NewPriceBlurryView: UIVisualEffectView!
    @IBOutlet var SoundSwitch: UISwitch!
    @IBOutlet var SoundImage: UIImageView!
    @IBOutlet var SoundStack: UIStackView!
    
    //MARK: Members
    let style = UIStyleHelper()
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var isMenuOut = false
    var isProductInformationSheetVisible:Bool = false
    let productCard:ProductCard = ProductCard()
    var facade:MainControllerFacade!
    
    func ShowAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - ViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        facade = MainControllerFacade(presentingController: self)
        //Create Dummy Products
        facade.productsArray = productCard.CreateDummyProducts()
        facade.firebaseClient.alertMessageDelegate = self
        facade.CheckForSoundSetting()
        //Setup Views
        SetupMainControllerViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SegueToLogInController), name: NSNotification.Name.SegueToLogInController, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        style.AddToViewsForStyling(views: [MainBackgroundImage])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.isOpaque  = false
        //Set Sound Switch value
        if (UserDefaults.standard.object(forKey: eUserDefaultKeys.SoundsOn.rawValue) != nil) {
            let sound = UserDefaults.standard.bool(forKey: eUserDefaultKeys.SoundsOn.rawValue)
            SoundSwitch.setOn(sound, animated: true)
            SoundImage.image = sound == true ?  #imageLiteral(resourceName: "SoundOn-icon") : #imageLiteral(resourceName: "SoundOff-icon")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        style.RemoveViewsForStyling(views: [MainBackgroundImage])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SegueToLogInController(notification: Notification) -> Void {
        navigationController?.popViewController(animated: true)
    }
    func LogOutBarButtonItemPressed(sender: UIBarButtonItem) -> Void{
        let loginService = facade.GetUserLoggedInService()
        if loginService == .guest || loginService == .facebook  || loginService == .google || loginService == .instagram {
            SegueToLogInController(notification: Notification(name: NSNotification.Name.SegueToLogInController))
        }
        facade.LogoutFirebaseUser()
    }
    
    func SoundSwitch_Changed(sender: UISwitch) -> Void {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.SoundsOn.rawValue)
            SoundImage.image =  #imageLiteral(resourceName: "SoundOn-icon")
        } else {
            UserDefaults.standard.set(false, forKey: eUserDefaultKeys.SoundsOn.rawValue)
            SoundImage.image =   #imageLiteral(resourceName: "SoundOff-icon")
        }
    }
    
    
    //MARK: - Custom Functions
    @IBAction func CardPanRecocnizerAction(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        let yFromCenter = card.center.y - view.center.y
        let scale = min((view.frame.size.width * 0.25) / abs(xFromCenter), 1)
        let swipeLimitLeft = view.frame.width * 0.4 // left border when the card gets animated off
        let swipeLimitRight = view.frame.width * 0.6 // right border when the card gets animated off
        let swipeLimitTop = view.frame.height * 0.4 // top border when the card gets animated off
        let swipeLimitBottom = view.frame.height * 0.7 // top border when the card gets animated off
        //print(swipeLimitBottom)
        //print(sender.location(in: view))
        let ySpin:CGFloat = yFromCenter < 0 ? -200 : 200 // gives the card a spin in y direction
        let xSpin:CGFloat = xFromCenter < 0 ? -300 : 300 // gives the card a spin in x direction
        
        FavoritesStarImage.alpha =  card.center.y < swipeLimitBottom ? 0 : 1
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y) //
        //Rotate card while drag
        let degree:Double = Double(xFromCenter / ((view.frame.size.width * 0.5) / 40))
        card.transform = CGAffineTransform(rotationAngle: degree.degreesToRadians).scaledBy(x: scale, y: scale)
        
        
        //Animate card after drag ended
        if sender.state == UIGestureRecognizerState.ended{
            let swipeDuration = 0.3
            // Move off to the left side if drag reached swipeLimitLeft
            if card.center.x < swipeLimitLeft{
                facade.PlaySwooshSound()
                UIView.animate(withDuration: swipeDuration, animations: {
                    card.center.x = card.center.x - self.view.frame.size.width
                    card.center.y = card.center.y + ySpin
                }, completion: { (true) in
                    //Card arise in Center for new view
                    self.ResetCardAfterSwipeOff(card: card)
                })
                return
                //Move off to the right side if drag reached swipeLimitRight
            } else if card.center.x > swipeLimitRight{
                facade.PlaySwooshSound()
                UIView.animate(withDuration: swipeDuration, animations: {
                    card.center.x = card.center.x + self.view.frame.size.width
                    card.center.y = card.center.y + ySpin
                }, completion: { (true) in
                    //Card arise in Center for new view
                    self.ResetCardAfterSwipeOff(card: card)
                })
                return
                //Move off the top side if drag reached swipeLimitTop
            } else if card.center.y < swipeLimitTop{
                facade.PlaySwooshSound()
                UIView.animate(withDuration: swipeDuration, animations: {
                    card.center.y = card.center.y - self.view.frame.size.height
                    card.center.x = card.center.x + xSpin
                }, completion: { (true) in
                    //Card arise in Center for new view
                    self.ResetCardAfterSwipeOff(card: card)
                })
                return
                //Move downways if drag reached swipeLimitBottom
            } else if card.center.y > swipeLimitBottom
            {
                facade.PlayYeahSound()
                self.facade.SaveProductToFavorites(product: facade.productsArray[imageCount])
                UIView.animate(withDuration: swipeDuration, animations:
                    { card.center.y = card.center.y + self.view.frame.size.height
                }, completion: { (true) in
                    //Card arise in Center for new view
                    self.ResetCardAfterSwipeOff(card: card)
                })
                return
            } else {
                //Position card in center again when drag not over swipe limit
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = self.view.center
                    card.transform = CGAffineTransform(rotationAngle: Double(0).degreesToRadians).scaledBy(x: 1, y: 1)
                    self.FavoritesStarImage.alpha = 0
                })
            }
            UIView.animate(withDuration: 0.3) {
                card.center = self.view.center
            }
        }
    }
    
    var imageCount:Int = 0
    func ResetCardAfterSwipeOff(card: UIView){
        card.alpha = 0
        card.center = self.view.center
        card.transform = CGAffineTransform(rotationAngle: Double(0).degreesToRadians)
        card.Arise(duration: 0.5, delay: 0, options: [.allowUserInteraction], toAlpha: 1)
        
        imageCount = imageCount == facade.productsArray.count - 1 ? 0 : imageCount + 1
        ProductImageView.image = facade.productsArray[imageCount].ProdcutImage
        lbl_ProductTitle.text = facade.productsArray[imageCount].Title!
        lbl_ProductSubtitle.text = facade.productsArray[imageCount].Subtitle!
        ProductInformationTextView.text = facade.productsArray[imageCount].Productinformation!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "de_DE")
        formatter.string(for: facade.productsArray[imageCount].OriginalPrice!)
        lbl_OldPrice.text = formatter.string(for: facade.productsArray[imageCount].OriginalPrice!)
        lbl_NewPrice.text = formatter.string(for: facade.productsArray[imageCount].NewPrice!)
        FavoritesStarImage.alpha = 0
    }
    
    func btn_Menu_Pressed(sender: DesignableUIButton) -> Void {
        if isMenuOut
        {
            HideMenu(closure: {})
        }
        else
        {
            if isProductInformationSheetVisible{
                HideInformationSheet()
            }
            ShowMenu(closure: {})
        }
    }
    
    func btn_MenuAccount_Pressed(sender: UIButton) -> Void {
        if isMenuOut
        {
            HideMenu(closure: PerformSegueToYourAccountController )
        } else {
            PerformSegueToYourAccountController()
        }
    }
    func PerformSegueToYourAccountController() -> Void {
        performSegue(withIdentifier: .SegueToYourAccountController_Identifer, sender: nil)
    }
    
    func btn_MenuNews_Pressed(sender: UIButton) -> Void {
        if isMenuOut{
            HideMenu(closure: PerformSegueToNewsConroller )
        } else {
            PerformSegueToNewsConroller()
        }
    }
    func PerformSegueToNewsConroller()->Void{
        performSegue(withIdentifier: .SegueToNewsController_Identifier, sender: nil)
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
            self.btn_MenuFavourites.transform  = CGAffineTransform(translationX: self.btn_MenuFavourites.frame.size.width + 100, y: 0)
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
            self.btn_MenuFavourites.transform = .identity
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
    
    func btn_ProductInformation_Pressed(sender: UIButton) -> Void {
        if !isProductInformationSheetVisible{
            if isMenuOut
            {
                HideMenu(closure: {})
            }
            ShowInformationSheet()
        } else {
            HideInformationSheet()
        }
    }
    
    private func ShowInformationSheet(){
        isProductInformationSheetVisible = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.TopBackGroundView.transform = CGAffineTransform(translationX: 0, y: -self.TopBackGroundView.frame.size.height * 0.7).scaledBy(x: 0.7, y: 0.7)
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
    
    private func SetupMainControllerViews(){
        //Hide back button to show custom Button
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "log out", style: UIBarButtonItemStyle.plain, target: self, action:#selector(LogOutBarButtonItemPressed))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        //Main Backgroundimage
        MainBackgroundImage.image = UIImage(named: "NatureBG")
        
        //Card view
        CardView.center = view.center
        CardView.layer.cornerRadius = 20
        CardView.clipsToBounds = true
        CardBackgrounImageView.backgroundColor = UIColor.black
        
        //Imageview of CardView
        MainBackgroundImage.image = #imageLiteral(resourceName: "NatureBG")
        ProductImageView.image = #imageLiteral(resourceName: "Product_Cream")
        ProductImageView.layer.cornerRadius = 20
        ProductImageView.clipsToBounds = true
        
        //OldPrice label of CardView
        OldPriceBlurryViewBottomConstraint.constant = (ProductImageView.frame.size.height * 0.7)
        OldPriceBlurryView.layer.cornerRadius = 10
        OldPriceBlurryView.clipsToBounds = true
        OldPriceBlurryView.transform = CGAffineTransform(rotationAngle: Double(-35).degreesToRadians)
        
        //NewPrice label of CardView
        NewPriceBlurryView.layer.cornerRadius = 10
        NewPriceBlurryView.clipsToBounds = true
        ProductInformationSheet.alpha = 0
        ProductInformationSheet.transform = CGAffineTransform(translationX: 0, y: (ProductInformationSheet.frame.size.height + 100))
        ProductInformationSheet.layer.cornerRadius = 20
        
        //Wire targets
        btn_Menu.addTarget(self, action: #selector(btn_Menu_Pressed), for: .touchUpInside)
        btn_ProductInformation.addTarget(self, action: #selector(btn_ProductInformation_Pressed), for: .touchUpInside)
        btn_MenuAccount.addTarget(self, action: #selector(btn_MenuAccount_Pressed), for: .touchUpInside)
        btn_MenuNews.addTarget(self, action: #selector(btn_MenuNews_Pressed), for: .touchUpInside)
        SoundSwitch.addTarget(self, action: #selector(SoundSwitch_Changed), for: .valueChanged)
        
        //Transform UIControls to initial position
        FavoritesStarImage.transform = CGAffineTransform(translationX: 0, y: FavoritesStarImage.frame.size.height * 0.4)
        btn_MenuNews.transform = CGAffineTransform(translationX: btn_MenuNews.frame.size.width + 100, y: 0)
        btn_MenuFavourites.transform = CGAffineTransform(translationX: btn_MenuFavourites.frame.size.width + 100, y: 0)
        btn_MenuGutscheine.transform = CGAffineTransform(translationX: btn_MenuGutscheine.frame.size.width + 100, y: 0)
        btn_MenuAccount.transform = CGAffineTransform(translationX: btn_MenuAccount.frame.size.width + 100, y: 0)
        SoundStack.transform = CGAffineTransform(translationX: SoundStack.frame.size.width + 100, y: 0)
    }
}
