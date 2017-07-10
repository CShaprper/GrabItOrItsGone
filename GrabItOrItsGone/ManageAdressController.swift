//
//  ManageAdressController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 09.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class ManageAdressController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //MARK: - Outlets
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var BackgroundBlurrView: UIVisualEffectView!
    @IBOutlet var AddressTableView: UITableView!
    //Address Popup
    @IBOutlet var AddAddressPopUp: UIView!
    @IBOutlet var AddAddressPopUpImage: UIImageView!
    @IBOutlet var AddessPopUpBackground: UIView!
    @IBOutlet var AddressPopUpRoundView: DesignableUIView!
    
    //MARK: - Members
    var blurryView:UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SetUp Views
        SetUpViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SetUpViews() -> Void {
        //Set TableView Delegate & Datasource
        AddressTableView.delegate = self
        AddressTableView.dataSource = self
        
        let addAddressButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action:#selector(btn_AddAddress_Pressed))
        self.navigationItem.rightBarButtonItem = addAddressButton
    }
    
    func btn_AddAddress_Pressed(sender: UIButton) -> Void {
        ShowBlurryView()
        ShowAddAddressPopUp()
    }
    
    func ShowAddAddressPopUp()->Void{
        view.addSubview(AddAddressPopUp)
        AddAddressPopUp.frame.size.height = 0.5 * view.frame.size.height
        AddAddressPopUp.frame.size.width = 0.9 * view.frame.size.width
        AddAddressPopUp.center = view.center
        AddAddressPopUp.alpha = 0
        AddAddressPopUp.HangingEffectBounce(duration: 0.7, delay: 0, spring: 0.25)
    }
    
    func HideAddAddressPopUp() -> Void {
        AddAddressPopUp.removeFromSuperview()
    }
    
    func ShowBlurryView(){
        blurryView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurryView.frame.size.width = view.frame.size.width
        blurryView.frame.size.height = view.frame.size.height
        blurryView.center = view.center
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(BlurryViewTouched))
        blurryView.addGestureRecognizer(tapRecognizer)
        view.addSubview(blurryView!)
    }
    
    func HideBlurrView() -> Void {
        blurryView.removeFromSuperview()
    }
    
    //MARK: - Wired actions
    func BlurryViewTouched(sender: UITapGestureRecognizer)->Void{
        HideBlurrView()
        HideAddAddressPopUp()
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: - TableView SetUp
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
