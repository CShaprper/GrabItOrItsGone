//
//  AdminAddProductController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 18.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices

class AdminAddProductController: UIViewController, UITextFieldDelegate, IFirebaseWebService {
    //MARK:- Outlets
    @IBOutlet var txt_ProductTitle: UITextField!
    @IBOutlet var txt_productSubtitle: UITextField!
    @IBOutlet var txt_ProductCategory: UITextField!
    @IBOutlet var txt_OldPrice: UITextField!
    @IBOutlet var txt_NewPrice: UITextField!
    @IBOutlet var txt_ProductInformation: UITextView!
    @IBOutlet var ProductImage: UIImageView!
    @IBOutlet var ContentContainer: UIView!
    @IBOutlet var ImageContainer: UIView!
    @IBOutlet var tapped: UITapGestureRecognizer!
    @IBOutlet var btn_Save: UIButton!
    @IBOutlet var ActivityIndicator: UIActivityIndicatorView!
    
    //MARK:- Members
    var firebaseClient:FirebaseClient?
    var product:ProductCard?
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product = ProductCard()
        firebaseClient = FirebaseClient()
        firebaseClient!.ReadFirebaseProductsSection()
        firebaseClient!.delegate = self
        
        ActivityIndicator.color = UIColor.green
        ActivityIndicator.alpha = 0
        
        txt_NewPrice.delegate = self
        txt_OldPrice.delegate = self
        txt_ProductTitle.delegate = self
        txt_productSubtitle.delegate = self
        txt_ProductCategory.delegate = self
        txt_ProductInformation.text = ""
        
        
        txt_NewPrice.textColor = view.tintColor
        txt_OldPrice.textColor = view.tintColor
        txt_ProductTitle.textColor =  view.tintColor
        txt_productSubtitle.textColor = view.tintColor
        txt_ProductCategory.textColor = view.tintColor
        
        txt_NewPrice.addTarget(self, action: #selector(txt_NewPrice_Changed), for: .editingChanged)
        txt_OldPrice.addTarget(self, action: #selector(txt_OldPrice_Changed), for: .editingChanged)
        txt_ProductTitle.addTarget(self, action: #selector(txt_ProductTitle_Changed), for: .editingChanged)
        txt_productSubtitle.addTarget(self, action: #selector(txt_productSubtitle_Changed), for: .editingChanged)
        txt_ProductCategory.addTarget(self, action: #selector(txt_ProductCategory_Changed), for: .editingChanged)
        
        ImageContainer.addGestureRecognizer(tapped)
        
        btn_Save.addTarget(self, action: #selector(btn_Save_Pressed), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    @IBAction func ImageTaped(_ sender: Any) {
        product!.Productinformation = txt_ProductInformation.text!
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == false{
            return
        }
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        self.present(imgPicker, animated: true, completion:  nil)
    }
    
    @objc func btn_Save_Pressed(sender: UIButton) -> Void{
        product!.ID = UUID().uuidString
        firebaseClient!.SaveNewProdcutAsAdmin(product: product!, productImage: ProductImage.image!)
    }
    
    
    //MARK: - IFirebaseWebService implementation
    func FirebaseRequestStarted() {
        ActivityIndicator.alpha = 1
        ActivityIndicator.frame.size.width = 60
        ActivityIndicator.frame.size.height = 60
        view.addSubview(ActivityIndicator)
        view.bringSubview(toFront: ActivityIndicator)
        ActivityIndicator.center = view.center
    }
    func FirebaseRequestFinished() {
        ActivityIndicator.alpha = 0
        ActivityIndicator.removeFromSuperview()
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    @objc func txt_NewPrice_Changed(sender: UITextField) -> Void{
        product!.NewPrice = Double(sender.text!)
    }
    @objc func txt_OldPrice_Changed(sender: UITextField) -> Void{
        product!.OriginalPrice = Double(sender.text!)
    }
    @objc func txt_ProductTitle_Changed(sender: UITextField) -> Void{
        product!.Title = sender.text!
    }
    @objc func txt_productSubtitle_Changed(sender: UITextField) -> Void{
        product!.Subtitle = sender.text!
    }
    @objc func txt_ProductCategory_Changed(sender: UITextField) -> Void{
        product!.ProductCategory = sender.text!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions from Notification listeners
    @objc func KeyboardWillShow(notification: Notification) -> Void{
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            ContentContainer.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height * 0.33)
        }
    }
    @objc func KeyboardWillHide(notification: Notification) -> Void{
        ContentContainer.transform = .identity
    }
}
//Image Compression
extension UIImage
{
    var highestQualityJPEGNSData: NSData? { return UIImageJPEGRepresentation(self, 1.0)! as NSData }
    var highQualityJPEGNSData: NSData?    { return UIImageJPEGRepresentation(self, 0.75)! as NSData}
    var mediumQualityJPEGNSData: NSData?  { return UIImageJPEGRepresentation(self, 0.5)! as NSData }
    var lowQualityJPEGNSData: NSData?     { return UIImageJPEGRepresentation(self, 0.25)! as NSData}
    var lowestQualityJPEGNSData: NSData?  { return UIImageJPEGRepresentation(self, 0.0)! as NSData }
}

//ImagePicker
extension AdminAddProductController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if  mediaType == kUTTypeImage{
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                print(info)
                self.ProductImage.image = image
            } else {
                print("no image from image Picker received!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
