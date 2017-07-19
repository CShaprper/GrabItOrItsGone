//
//  FavoritesDetailController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class FavoritesDetailController: UIViewController, UIScrollViewDelegate {
    //MARK:- Outlets
    @IBOutlet var BachgroundImage: UIImageView!
    @IBOutlet var BackgroundBlurrView: UIVisualEffectView!
    @IBOutlet var ContentScrollView: UIScrollView!
    @IBOutlet var ProductImage: UIImageView!
    @IBOutlet var ProductTitle: UILabel!
    @IBOutlet var ProductSubtitle: UILabel!
    @IBOutlet var ProductInformation: UITextView!
    @IBOutlet var ProductInformationHeightConstraint: NSLayoutConstraint!
    
    
    //MARK:- Members
    var selectedProduct:ProductCard!
    
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
}
