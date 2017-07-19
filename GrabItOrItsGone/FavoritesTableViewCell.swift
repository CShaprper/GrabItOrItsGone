//
//  FavoritesTableViewCell.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet var ProductImage: UIImageView!
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var lbl_Subtitle: UILabel!
    @IBOutlet var lbl_OriginalPrice: UILabel!
    @IBOutlet var lbl_OurPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func ConfigureCell(product: ProductCard){
        ProductImage.image = product.ProdcutImage!
        ProductImage.layer.cornerRadius = 10
        ProductImage.clipsToBounds = true
        lbl_Title.text = product.Title != nil ? product.Title! : ""
        lbl_Subtitle.text = product.Subtitle != nil ? product.Subtitle! : ""
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        lbl_OriginalPrice.text = product.OriginalPrice != nil ? formatter.string(for: product.OriginalPrice!) : ""
        lbl_OurPrice.text = product.NewPrice != nil ? formatter.string(for: product.NewPrice!) : ""
    }
}
