//
//  ManageAdressController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 09.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class AdressController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, IAlertMessageDelegate {
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
    @IBOutlet var txt_Firstname: UITextField!
    @IBOutlet var txt_Lastname: UITextField!
    @IBOutlet var txt_Address: UITextField!
    @IBOutlet var txt_Housenumber: UITextField!
    @IBOutlet var txt_City: UITextField!
    @IBOutlet var txt_Zipcode: UITextField!
    @IBOutlet var btn_SaveAddress: DesignableUIButton!
    
    //MARK: - Members
    var blurryView:UIVisualEffectView!
    var facade:AddressFacade!
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureFacade()
        SetUpViews()
        AddNotificationListeners()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Actions from Notification listeners
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
    func AddressTypeSegmentedControl_Switched(sender: UISegmentedControl) -> Void {
        if sender.selectedSegmentIndex == 0{
            facade.address.isDeliveryAddress = true
        } else {
            facade.address.isDeliveryAddress = false
        }
    }
    func btn_SaveAddress_Pressed(sender: DesignableUIButton) -> Void {
        if facade.ValidateUserInput(segmentedControl: AddressTypeSegmentedControl) {
            facade.SaveAddress()
            HideAddAddressPopUp()
            AddressTableView.reloadData()
        }
    }
    func btn_AddAddress_Pressed(sender: UIButton) -> Void {
        ShowAddAddressPopUp()
    }
    
    
    //MARK:- IAlertMessageDelegate implementation
    func initAlertMessageDelegate(delegate: IAlertMessageDelegate) {
        ValidationFactory.alertMessageDelegate = self 
    }    
    func ShowAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func txt_Firstname_TextChanged(sender: UITextField) -> Void {
        facade.address.firstname = sender.text!
    }
    func txt_Lastname_TextChanged(sender: UITextField) -> Void {
        facade.address.lastname = sender.text!
    }
    func txt_Address_TextChanged(sender: UITextField) -> Void {
        facade.address.streetname = sender.text!
    }
    func txt_Housenumber_TextChanged(sender: UITextField) -> Void {
        facade.address.houseneumber = sender.text!
    }
    func txt_Zipcode_TextChanged(sender: UITextField) -> Void {
        facade.address.zipnumber = sender.text!
    }
    func txt_City_TextChanged(sender: UITextField) -> Void {
        facade.address.city = sender.text!
    }
    
    
    //MARK: - TableView SetUp
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facade.addresses.count
    }
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: .AdressTableViewCell_Identifier) as! AdressTableViewCell
        myCell.ConfigureCell(address: facade.addresses[indexPath.row])
        return myCell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            facade.DeleteAddress(address: facade.addresses[indexPath.row])
            facade.addresses.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    //MARK: - Helper Methods
    func SetUpViews() -> Void {
        AddressTableView.delegate = self
        AddressTableView.dataSource = self
        txt_City.delegate = self
        txt_Address.delegate = self
        txt_Zipcode.delegate = self
        txt_Firstname.delegate = self
        txt_Lastname.delegate = self
        txt_Housenumber.delegate = self
        txt_City.textColor = self.view.tintColor
        txt_Address.textColor = self.view.tintColor
        txt_Zipcode.textColor = self.view.tintColor
        txt_Firstname.textColor = self.view.tintColor
        txt_Lastname.textColor = self.view.tintColor
        txt_Housenumber.textColor = self.view.tintColor
        txt_Firstname.placeholder = .AddressPopUpFirstname_PlaceholderString
        txt_Lastname.placeholder = .AddressPopUpLastname_PlaceholderString
        txt_Address.placeholder = .AddressPopUpAddress_PlaceholderString
        txt_Housenumber.placeholder = .AddressPopUpHousenumber_PlaceholderString
        txt_Zipcode.placeholder = .AddressPopUpZipcode_PlaceholderString
        txt_City.placeholder = .AddressPopUpCity_PlaceholderString
        AddressTypeSegmentedControl.setTitle(.AddressTypeShipment, forSegmentAt: 0)
        AddressTypeSegmentedControl.setTitle(.AddressTypeInvoice, forSegmentAt: 1)
        AddressTypeSegmentedControl.selectedSegmentIndex = -1
        self.navigationItem.title = .ManageAddressController_TitleString
        //Textfield Events
        txt_Firstname.addTarget(self, action: #selector(txt_Firstname_TextChanged), for: .editingChanged)
        txt_Lastname.addTarget(self, action: #selector(txt_Lastname_TextChanged), for: .editingChanged)
        txt_Address.addTarget(self, action: #selector(txt_Address_TextChanged), for: .editingChanged)
        txt_Housenumber.addTarget(self, action: #selector(txt_Housenumber_TextChanged), for: .editingChanged)
        txt_Zipcode.addTarget(self, action: #selector(txt_Zipcode_TextChanged), for: .editingChanged)
        txt_City.addTarget(self, action: #selector(txt_City_TextChanged), for: .editingChanged)
        
        btn_SaveAddress.addTarget(self, action: #selector(btn_SaveAddress_Pressed), for: .touchUpInside)
        AddressTypeSegmentedControl.addTarget(self, action: #selector(AddressTypeSegmentedControl_Switched), for: .valueChanged)
        
        let addAddressButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action:#selector(btn_AddAddress_Pressed))
        self.navigationItem.rightBarButtonItem = addAddressButton
    }
    func AddNotificationListeners() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    func ConfigureFacade() -> Void {
        facade = AddressFacade()
        facade.FetchAdresses()
        initAlertMessageDelegate(delegate: self)
    }
    func ShowAddAddressPopUp()->Void{
        if !self.view.subviews.contains(AddAddressPopUp){
            facade.CreateNewAddressToInsert()
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
}
