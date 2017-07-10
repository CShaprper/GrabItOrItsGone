//
//  AdressTableViewCell.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 10.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class AdressTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet var lbl_AddressType: UILabel!
    @IBOutlet var lbl_AddressTypeValue: UILabel!
    @IBOutlet var lbl_Fullname: UILabel!
    @IBOutlet var lbl_FullnameValue: UILabel!
    @IBOutlet var lbl_Address: UILabel!
    @IBOutlet var lbl_AddressValue: UILabel!
    @IBOutlet var lbl_City: UILabel!
    @IBOutlet var lbl_CityValue: UILabel!
    @IBOutlet var lbl_Zipcode: UILabel!
    @IBOutlet var lbl_ZipcodeValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
