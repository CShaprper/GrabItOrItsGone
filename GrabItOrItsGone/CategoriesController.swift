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

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
