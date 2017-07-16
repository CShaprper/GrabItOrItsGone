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
    
    //MARK: -Members
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Controller Views
        SetUpViews ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetUpViews() -> Void {
        self.navigationItem.title = .YourAccount_Controller_TitleString
        //Manage Address Container
        lbl_manageAddress.text = .lbl_manageAddress_String
        lbl_manageAddress.textColor = view.tintColor
        lbl_ManageAddressArrow.textColor = view.tintColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ManageAdressContainer_Touched))
        ManageAdressContainer.addGestureRecognizer(gesture)
        
        //Manage Favorites Container
        lbl_ManageFavorites.text = .lbl_manageFavorites_String
        lbl_ManageFavorites.textColor = view.tintColor
        lbl_ManageFavoritesArrow.textColor = view.tintColor
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(ManageFavoritesContainer_Touched))
        ManageFavoritesContainer.addGestureRecognizer(gesture2)
    }
    
    func ManageAdressContainer_Touched(sender: UITapGestureRecognizer) -> Void {
        self.performSegue(withIdentifier: .SegueToAddressController_Identifier, sender: nil)
    }
    
    func ManageFavoritesContainer_Touched(sender: UITapGestureRecognizer) -> Void{
        self.performSegue(withIdentifier: .SegueToFavoritesController_Identifier, sender: nil)
    }
}
