//
//  NewsTableViewCell.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 08.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var lbl_Message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func ConfigureCell(title: String, message: String) -> Void {
        lbl_Title.text = title
        lbl_Message.text = message
    }
}
