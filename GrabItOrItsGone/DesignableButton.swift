//
//  DesignableButton.swift
//  GrabIt
//
//  Created by Peter Sypek on 24.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

//@IBDesignable
public class DesignableUIButton:UIButton{
    
    @IBInspectable var CornerRadius:CGFloat = 0{
        didSet{
            self.layer.cornerRadius = CornerRadius
        }
    }
    
    @IBInspectable var BorderWidth:CGFloat = 0{
        didSet{
            self.layer.borderWidth = BorderWidth
        }
    }
    
    @IBInspectable var BorderColor:UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = BorderColor.cgColor
        }
    }
}
