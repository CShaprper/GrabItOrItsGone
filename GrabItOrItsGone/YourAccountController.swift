//
//  YourAccountController.swift
//  GrabIt
//
//  Created by Peter Sypek on 06.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class YourAccountController: UIViewController {
    //MARK: - Outlets
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var BackgroundBlurryView: UIVisualEffectView!
    //ManageAdressContainer
    @IBOutlet var ManageAdressContainer: UIView!
    @IBOutlet var ManageAdressImageView: UIImageView!
    @IBOutlet var lbl_manageAddress: UILabel!
    @IBOutlet var lbl_ManageAddressArrow: UILabel!
    //ManageFavoritesContainer
    @IBOutlet var ManageFavoritesContainer: UIView!
    @IBOutlet var ManageFavoritesImage: UIImageView!
    @IBOutlet var lbl_ManageFavorites: UILabel!
    @IBOutlet var lbl_ManageFavoritesArrow: UILabel!
    //Filter Categories Container
    @IBOutlet var FilterCategoriesContainer: UIView!
    @IBOutlet var FilterCategoriesImage: UIImageView!
    @IBOutlet var lbl_FilterCategories: UILabel!
    @IBOutlet var lbl_FilterCategoriesArrow: UILabel!
    //Your Purchases Container
    @IBOutlet var PurchasesContainer: UIView!
    @IBOutlet var PurchasesImage: UIImageView!
    @IBOutlet var lbl_Purchases: UILabel!
    @IBOutlet var lbl_PurchasesArrow: UILabel!
    
    
    
    //MARK: -Members
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("product array count: \(productsArray.count)")
        
        //Setup Controller Views
        SetUpViews ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetUpViews() -> Void {
        self.navigationItem.title = String.YourAccount_Controller_TitleString
        //Manage Address Container
        lbl_manageAddress.text = String.lbl_manageAddress_String
        lbl_manageAddress.textColor = view.tintColor
        lbl_ManageAddressArrow.textColor = view.tintColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ManageAdressContainer_Touched))
        ManageAdressContainer.addGestureRecognizer(gesture)
        
        //Manage Favorites Container
        lbl_ManageFavorites.text = String.lbl_manageFavorites_String
        lbl_ManageFavorites.textColor = view.tintColor
        lbl_ManageFavoritesArrow.textColor = view.tintColor
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(ManageFavoritesContainer_Touched))
        ManageFavoritesContainer.addGestureRecognizer(gesture2)
        
        //Category Filter Container
        lbl_FilterCategories.text = String.lbl_FilterCategories_String
        lbl_FilterCategories.textColor = view.tintColor
        lbl_FilterCategoriesArrow.textColor = view.tintColor
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(FilterCategoriesContainer_Touched))
        FilterCategoriesContainer.addGestureRecognizer(gesture3)
        
        //Category Filter Container
        lbl_Purchases.text = String.lbl_Purchases_String
        lbl_Purchases.textColor = view.tintColor
        lbl_PurchasesArrow.textColor = view.tintColor
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(PurchaseContainer_Touched))
        PurchasesContainer.addGestureRecognizer(gesture4)
    }
    
    @objc func ManageAdressContainer_Touched(sender: UITapGestureRecognizer) -> Void {
        self.performSegue(withIdentifier: .SegueToAddressController_Identifier, sender: nil)
    }
    
    @objc func ManageFavoritesContainer_Touched(sender: UITapGestureRecognizer) -> Void{
        self.performSegue(withIdentifier: .SegueToFavoritesController_Identifier, sender: nil)
    }
    @objc func FilterCategoriesContainer_Touched(sender: UITapGestureRecognizer) -> Void {
          self.performSegue(withIdentifier: String.SegueToCategoriesController_Identifier, sender: nil)
    }
    @objc func PurchaseContainer_Touched(sender: UITapGestureRecognizer) -> Void{
        self.performSegue(withIdentifier: String.SegueToPurchaseController_Identifier, sender: nil)
    }
}
