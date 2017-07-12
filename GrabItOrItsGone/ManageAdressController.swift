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
    @IBOutlet var AddressTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var txt_Fullname: UITextField!
    @IBOutlet var txt_Address: UITextField!
    @IBOutlet var txt_City: UITextField!
    @IBOutlet var txt_Zipcode: UITextField!
    @IBOutlet var btn_SaveAddress: DesignableUIButton!
    
    //MARK: - Members
    var blurryView:UIVisualEffectView!
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SetUp Views
        SetUpViews()
        
        //Add Notification Listeners
        AddNotificationListeners()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func AddNotificationListeners() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    func SetUpViews() -> Void {
        //Set TableView Delegate & Datasource
        AddressTableView.delegate = self
        AddressTableView.dataSource = self
        txt_City.delegate = self
        txt_Address.delegate = self
        txt_Zipcode.delegate = self
        txt_Fullname.delegate = self
        txt_City.textColor = self.view.tintColor
        txt_Address.textColor = self.view.tintColor
        txt_Zipcode.textColor = self.view.tintColor
        txt_Fullname.textColor = self.view.tintColor
        btn_SaveAddress.addTarget(self, action: #selector(btn_SaveAddress_Pressed), for: .touchUpInside)
        
        let addAddressButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action:#selector(btn_AddAddress_Pressed))
        self.navigationItem.rightBarButtonItem = addAddressButton
    }
    
    func btn_AddAddress_Pressed(sender: UIButton) -> Void {
        ShowAddAddressPopUp()
        
    }
    
    func ShowAddAddressPopUp()->Void{
        if !self.view.subviews.contains(AddAddressPopUp){
            ShowBlurryView()
            view.addSubview(AddAddressPopUp)
            AddAddressPopUp.frame.size.height = 0.5 * view.frame.size.height
            AddAddressPopUp.frame.size.width = 0.9 * view.frame.size.width
            AddAddressPopUp.center = view.center
            AddAddressPopUp.alpha = 0
            AddAddressPopUp.HangingEffectBounce(duration: 0.7, delay: 0, spring: 0.25)
        }
    }
    
    func HideAddAddressPopUp() -> Void {
        if self.view.subviews.contains(AddAddressPopUp){
            HideBlurrView()
            AddAddressPopUp.removeFromSuperview()
        }
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
    //MARK: Actions from Notification listeners
    func KeyboardWillShow(notification: Notification) -> Void{
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            AddAddressPopUp.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height * 0.33)
        }
        
    }
    func KeyboardWillHide(notification: Notification) -> Void{
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            AddAddressPopUp.transform = CGAffineTransform(translationX: 0, y: keyboardSize.height * 0.33)
        }
        
    }
    
    //MARK: - Wired actions
    func BlurryViewTouched(sender: UITapGestureRecognizer)->Void{
        HideBlurrView()
        HideAddAddressPopUp()
    }
    func btn_SaveAddress_Pressed(sender: DesignableUIButton) -> Void {
        
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
