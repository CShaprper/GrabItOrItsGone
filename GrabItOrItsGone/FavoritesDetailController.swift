//
//  FavoritesDetailController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class FavoritesDetailController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    //MARK:- Outlets
    @IBOutlet var BachgroundImage: UIImageView!
    @IBOutlet var BackgroundBlurrView: UIVisualEffectView!
    @IBOutlet var ContentScrollView: UIScrollView!
    @IBOutlet var ProductImage: UIImageView!
    @IBOutlet var ProductTitle: UILabel!
    @IBOutlet var ProductSubtitle: UILabel!
    @IBOutlet var ProductInformation: UITextView!
    @IBOutlet var ProductInformationHeightConstraint: NSLayoutConstraint!
    @IBOutlet var Pinch: UIPinchGestureRecognizer!
    @IBOutlet var Pan: UIPanGestureRecognizer!
    
    
    //MARK:- Members
    var selectedProduct:ProductCard!
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureViews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        if let image = selectedProduct.ProdcutImage{
            ProductImage.image = image
        }
        if let title = selectedProduct.Title{
            ProductTitle.text = title
        }
        if let subtitle = selectedProduct.Subtitle{
            ProductSubtitle.text = subtitle
        }
        if let productinformation = selectedProduct.Productinformation {
            ProductInformation.text = productinformation
        }
        print("product array count: \(productsArray.count)")
    }
    
    func ConfigureViews(){
        self.navigationItem.title = String.FavotritesDetailsController_Title
        ContentScrollView.delegate = self
        /*ProductTitle.frame.size.width = view.frame.size.width * 0.95
        ProductSubtitle.frame.size.width = view.frame.size.width * 0.95
        ProductImage.frame.size.width = view.frame.size.width * 0.95
        ProductInformation.frame.size.width = view.frame.size.width * 0.95*/
        ProductImage.layer.cornerRadius = 20
        ProductImage.clipsToBounds = true        
        Pinch.addTarget(self, action: #selector(Image_Pinch))
        Pinch.delegate = self
        ProductImage.addGestureRecognizer(Pinch)
        view.bringSubview(toFront: ProductImage)
        Pan.addTarget(self, action: #selector(Image_Drag))
        Pan.delegate = self
        ProductImage.addGestureRecognizer(Pan)
        ProductInformation.text = ""
        ProductInformation.translatesAutoresizingMaskIntoConstraints = false
        let size = ProductInformation.sizeThatFits(CGSize(width: ProductInformation.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if  size.height > ProductInformation.frame.size.height{
            ProductInformationHeightConstraint.constant = size.height
            ProductInformation.setContentOffset(CGPoint.zero, animated: false)
        } else {
            ProductInformationHeightConstraint.constant = size.height
            ProductInformation.setContentOffset(CGPoint.zero, animated: false)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ContentScrollView.contentOffset.x > 0 || ContentScrollView.contentOffset.x < 0  {
            ContentScrollView.contentOffset.x = 0
        }
    }
    @objc func Image_Pinch(sender: UIPinchGestureRecognizer) -> Void{
        view.bringSubview(toFront: ProductImage)
        ProductImage.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        if sender.state == .ended {
            ProductImage.transform = .identity
        }
    }
    @objc func Image_Drag(sender: UIPanGestureRecognizer) -> Void{
      /*  let translation = sender.translation(in: sender.view)
        let myview = sender.view!
        myview.transform = CGAffineTransform(translationX: myview.center.x + translation.x, y: myview.center.y + translation.y)
        if sender.state == .ended{
          ProductImage.transform = .identity
        }*/
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
