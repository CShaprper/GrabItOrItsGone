//
//  DesingableUIView.swift
//  GrabIt
//
//  Created by Peter Sypek on 24.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

@IBDesignable
public class DesignableUIView: UIView{    
    
    @IBInspectable public var CornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = CornerRadius
        }
    }

}
