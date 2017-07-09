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
    @IBOutlet var ManageAdressContainer: UIView!
    @IBOutlet var ManageAdressImageView: UIImageView!
    @IBOutlet var lbl_manageAddress: UILabel!
    @IBOutlet var lbl_ManageAddressArrow: UILabel!
    
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
        self.navigationItem.title = view.YourAccount_Controller_TitleString
        lbl_manageAddress.text = view.lbl_manageAddress_String
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ManageAdressContainer_Touched))
        ManageAdressContainer.addGestureRecognizer(gesture)
        
        // var a = Address(context: appDel.persistentContainer.viewContext)
        
    }

    func ManageAdressContainer_Touched(sender: UITapGestureRecognizer) -> Void {
        self.performSegue(withIdentifier: "SegueToManageAddressController", sender: nil)
    }
}
