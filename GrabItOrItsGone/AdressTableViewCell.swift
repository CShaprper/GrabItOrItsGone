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
    @IBOutlet var lbl_AddressTypeValue: UILabel!
    @IBOutlet var lbl_FullnameValue: UILabel!
    @IBOutlet var lbl_AddressValue: UILabel!
    @IBOutlet var lbl_CityValue: UILabel!
    @IBOutlet var lbl_ZipcodeValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ConfigureCell(address:Address) -> Void {
        if address.isDeliveryAddress{
        lbl_AddressTypeValue.text = "AddressTypeShipment".localized
        } else {
            lbl_AddressTypeValue.text = "AddressTypeInvoice".localized
        }
        
    lbl_FullnameValue.text = "\(String(describing: address.firstname!)) \(String(describing: address.lastname!))"
        lbl_ZipcodeValue.text = address.zipnumber!
        lbl_AddressValue.text = "\(String(describing: address.streetname!)) \(String(describing: address.houseneumber!))"
        lbl_CityValue.text = address.city!
    }

}
