//
//  FilterCategoriesController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 17.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class CategoriesController: UIViewController {
    //MARK:- Outlets
    @IBOutlet var BakcgroundImage: UIImageView!
    @IBOutlet var BackgroundBlurrView: UIVisualEffectView!
    @IBOutlet var lbl_CategoryElectronic: UILabel!
    @IBOutlet var switchCategoryElectronic: UISwitch!
    @IBOutlet var lbl_CategoryClothes: UILabel!
    @IBOutlet var switchCategoryClothes: UISwitch!
    @IBOutlet var lbl_CategoryJewelry: UILabel!
    @IBOutlet var switchCategoryJewelry: UISwitch!
    @IBOutlet var lbl_CategoryCosmetics: UILabel!
    @IBOutlet var switchCategoryCosmetics: UISwitch!
    
    //MARK:- Member
    var firebaseClient:FirebaseClient!
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetSWitchValuesOnViewDidLoad()
        ConfigureView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseClient.ReadFirebaseProductsSection()
    }
    
    //MARK: - Wired actions
    func Category_Changed(sender: UISwitch) -> Void{
        if sender.isOn { UserDefaults.standard.set(true, forKey: eProductCategory.Electronic.rawValue) }
        else { UserDefaults.standard.set(false, forKey: eProductCategory.Electronic.rawValue)
           appDel.productsArray = [] // Reset products array 
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.hasUncheckedCategory.rawValue) }
    }
    func Clothes_Changed(sender: UISwitch) -> Void{
        if sender.isOn { UserDefaults.standard.set(true, forKey: eProductCategory.Clothes.rawValue)  }
        else { UserDefaults.standard.set(false, forKey: eProductCategory.Clothes.rawValue)
            appDel.productsArray = [] // Reset products array
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.hasUncheckedCategory.rawValue) }
    }
    func Jewelry_Changed(sender: UISwitch) -> Void{
        if sender.isOn { UserDefaults.standard.set(true, forKey: eProductCategory.Jewelry.rawValue)  }
        else { UserDefaults.standard.set(false, forKey: eProductCategory.Jewelry.rawValue)
            appDel.productsArray = [] // Reset products array
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.hasUncheckedCategory.rawValue) }
    }
    func Cosmetics_Changed(sender: UISwitch) -> Void{
        if sender.isOn { UserDefaults.standard.set(true, forKey: eProductCategory.Cosmetics.rawValue) }
        else { UserDefaults.standard.set(false, forKey: eProductCategory.Cosmetics.rawValue)
            appDel.productsArray = [] // Reset products array
            UserDefaults.standard.set(true, forKey: eUserDefaultKeys.hasUncheckedCategory.rawValue) }
    }
    
    //MARK: Helper functions
    func SetSWitchValuesOnViewDidLoad(){
        switchCategoryElectronic.isOn = UserDefaults.standard.bool(forKey: eProductCategory.Electronic.rawValue)
        switchCategoryClothes.isOn = UserDefaults.standard.bool(forKey: eProductCategory.Clothes.rawValue)
        switchCategoryJewelry.isOn = UserDefaults.standard.bool(forKey: eProductCategory.Jewelry.rawValue)
        switchCategoryCosmetics.isOn = UserDefaults.standard.bool(forKey: eProductCategory.Cosmetics.rawValue)
    }
    
    func ConfigureView(){
        firebaseClient = FirebaseClient()
        switchCategoryElectronic.addTarget(self, action: #selector(Category_Changed), for: .valueChanged)
        switchCategoryClothes.addTarget(self, action: #selector(Clothes_Changed), for: .valueChanged)
        switchCategoryJewelry.addTarget(self, action: #selector(Jewelry_Changed), for: .valueChanged)
        switchCategoryCosmetics.addTarget(self, action: #selector(Cosmetics_Changed), for: .valueChanged)
    }
}
