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
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var messageTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lbl_MessageDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func ConfigureCell(title: String, message: String, date: String) -> Void {
        lbl_Title.text = title
        lbl_MessageDate.text = date
        messageTextView.text = message
        
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
      let size = messageTextView.sizeThatFits(CGSize(width: messageTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if  size.height > messageTextView.frame.size.height{
            messageTextViewHeightConstraint.constant = size.height
            messageTextView.setContentOffset(CGPoint.zero, animated: false)
        } else {
            messageTextViewHeightConstraint.constant = size.height
            messageTextView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
}
