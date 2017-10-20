//
//  ManageFavoritesController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource, IFirebaseWebService {
    //MARK:- Outlets
    @IBOutlet var BackgroundImange: UIImageView!
    @IBOutlet var BackgroundImageBlurrView: UIVisualEffectView!
    @IBOutlet var FavoritesTableView: UITableView!
    
    //Favorites Detail view
    @IBOutlet var FavoritesDetailView: UIView!
    @IBOutlet var ProductTitle: UILabel!
    @IBOutlet var ProductSubtitle: UILabel!
    @IBOutlet var ProductImage: UIImageView!
    @IBOutlet var ProductInfoText: UITextView!
    @IBOutlet var NopeLabelContainer: UIView!
    @IBOutlet var BuyLabelContainer: UIView!
    
    //MARK:- Members
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var firebaseClient:FirebaseClient!
    var selectedProduct:ProductCard!
    
    //MARK:- Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseClient = FirebaseClient()
        firebaseClient.delegate = self
        self.navigationItem.title = .ManageFavoritesController_TitleString       
        firebaseClient.ReadFirebaseFavoritesSection()
       
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
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var direction:String = ""
    var isFavoritesVisible:Bool = false
    var isBuyVisible:Bool = false
    var isNopeVisible:Bool = false
    @objc func Handle_InfoViewPan(sender: UIPanGestureRecognizer) -> Void {
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
        
        print("pan")
        
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
                //FavoritesLabelContainer.alpha = 0
                
            } else if xPercentFromCenter < 0 && !isFavoritesVisible && (direction == "" || direction == "x"){
                
                view.bringSubview(toFront: NopeLabelContainer)
                NopeLabelContainer.alpha = abs(xPercentFromCenter)
                isNopeVisible = true
                //FavoritesLabelContainer.alpha = 0
                
            } else if yPercentFromCenter > 0.2 && !isNopeVisible && !isBuyVisible && (direction == "" || direction == "y") {
                
                //view.bringSubview(toFront: FavoritesLabelContainer)
                //FavoritesLabelContainer.alpha = yPercentFromCenter
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
                       // AlertFromFirebaseService(title: title, message: message)
                        
                        ResetCardAfterSwipeOff(card: card)
                        
                        return
                        
                    } else {
                        
                        //Move downways if drag reached swipe limit bottom
                        SwipeCardOffBottom(swipeDuration: swipeDuration, card: card, xSpin: xSpin)
                        
                        return
                    }
                } else {
                    // Reset card if no drag limit reached
                    self.ResetCardAfterSwipeOff(card: card)
                }
            }
    }
    
    private func SwipeCardOffLeft(swipeDuration: TimeInterval, card: UIView, ySpin: CGFloat){
        //facade.PlaySwooshSound()
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
        //facade.PlaySwooshSound()
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
        //facade.PlaySwooshSound()
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
        //facade.PlayYeahSound()
        UIView.animate(withDuration: swipeDuration, animations: {
            card.center.y = card.center.y + self.view.frame.size.height
            card.center.x = card.center.x + xSpin
        }, completion: { (true) in
            //Card arise in Center for new view
            self.ResetCardAfterSwipeOff(card: card)
            self.SetNewCardProdcutAfterSwipe(card: card)
        })
    }
    
    private func ResetCardAfterSwipeOff(card: UIView){
        
        direction = ""
        isNopeVisible = false
        //isFavoritesVisible = false
        isBuyVisible = false
        NopeLabelContainer.alpha = 0
        BuyLabelContainer.alpha = 0
        //FavoritesLabelContainer.alpha = 0
        card.alpha = 0
        card.center = self.view.center
        card.transform = CGAffineTransform(rotationAngle: Double(0).degreesToRadians)
        card.Arise(duration: 0.7, delay: 0, options: [.allowUserInteraction], toAlpha: 1) 
        
    }
    var currentImageIndex:Int = 0
    private func SetNewCardProdcutAfterSwipe(card: UIView){
        print(favoritesArray.count)
        if favoritesArray.count > 0 {
            //OldPriceBlurryView.alpha = 1
            //NewPriceBlurryView.alpha = 1
            currentImageIndex = currentImageIndex == favoritesArray.count - 1 ? 0 : currentImageIndex + 1
            ProductImage.image = favoritesArray[currentImageIndex].ProdcutImage
            ProductTitle.text = favoritesArray[currentImageIndex].Title!
            ProductSubtitle.text = favoritesArray[currentImageIndex].Subtitle!
            ProductInfoText.text = favoritesArray[currentImageIndex].Productinformation!
            
           // lbl_OldPrice.text = FormatToCurrency(digit: productsArray[currentImageIndex].OriginalPrice!)
           // lbl_NewPrice.text = FormatToCurrency(digit: productsArray[currentImageIndex].NewPrice!)
           // NewPriceInfoSheet.text = FormatToCurrency(digit: productsArray[currentImageIndex].NewPrice!)
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoritesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.FavoritesTableViewCell_Identifier, for: indexPath) as! FavoritesTableViewCell
        if favoritesArray.count > 0{
            cell.ConfigureCell(product: favoritesArray[indexPath.row])
        }
        return cell
        
    }
    
    fileprivate func ShowFavoritesDetailView() {
        
        FavoritesDetailView.frame.size.width = view.frame.width * 0.95
        FavoritesDetailView.frame.size.height = view.frame.height * 0.8
        FavoritesDetailView.center = view.center
        FavoritesDetailView.layer.borderColor = UIColor.gray.cgColor
        FavoritesDetailView.layer.borderWidth = 3
        FavoritesDetailView.layer.cornerRadius = 30
        FavoritesDetailView.clipsToBounds = true
        ProductTitle.text = selectedProduct.Title != nil ? selectedProduct.Title! : ""
        ProductSubtitle.text = selectedProduct.Subtitle != nil ? selectedProduct.Subtitle! : ""
        ProductImage.image = selectedProduct.ProdcutImage != nil ? selectedProduct.ProdcutImage! : #imageLiteral(resourceName: "Image-placeholder")
        ProductInfoText.text = selectedProduct.Productinformation != nil ? selectedProduct.Productinformation! : ""
        
        let infoViewPan = UIPanGestureRecognizer(target: self, action: #selector(Handle_InfoViewPan))
        FavoritesDetailView.addGestureRecognizer(infoViewPan)
        
        view.addSubview(FavoritesDetailView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedProduct = favoritesArray[indexPath.row]
        
        ShowFavoritesDetailView()
        
       // performSegue(withIdentifier: String.SegueToFavoritesDetailController_Identifier, sender: nil)
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            firebaseClient.DeleteProductFromFirebaseFavorites(idToDelete: favoritesArray[indexPath.row].ID!)
            favoritesArray.remove(at: indexPath.row)
        }
        
    }
    
    
    //MARK:- IFirebaseDataReceivedDelegate implementation
    func FirebaseRequestFinished() {
        FavoritesTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String.SegueToFavoritesDetailController_Identifier{
            if let destination = segue.destination as? FavoritesDetailController{
                if selectedProduct != nil{
                    destination.selectedProduct = selectedProduct
                }
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}
