//
//  UIStyleHelper.swift
//  GrabIt
//
//  Created by Peter Sypek on 25.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

enum eUIStyles:String {
    case City = "City"
    case Mandala = "Mandala"
    case Nature = "Nature"
}

public class UIStyleHelper{
    private var styleViews:[UIView] = []
    
    func AddToViewsForStyling(views:[UIView]){
        for view in views{
            styleViews.append(view)
        }
    }
    
    func RemoveViewsForStyling(views:[UIView]){
        for view in views{
            styleViews.remove(at: styleViews.index(of: view)!)
        }
    }
    
    func ChangeStyle(uiStyle:eUIStyles){
        for view in styleViews
        {
            if let v = view as? UITextView
            {
                v.backgroundColor = GetTextPresenterColor(uiStyle: uiStyle)
                v.textColor = GetFontColor(uiStyle: uiStyle)
            }
            else if let v = view as? UITextField
            {
                v.backgroundColor = GetTextPresenterColor(uiStyle: uiStyle)
            }
            else if let v = view as? UIButton
            {
                v.backgroundColor = GetButtonColor(uiStyle: uiStyle)
                v.setTitleColor(GetFontColor(uiStyle: uiStyle), for: .normal)
                v.layer.borderColor = GetBorderColor(uiStyle: uiStyle).cgColor
            }
            else if let v = view as? UILabel
            {
                v.textColor = GetFontColor(uiStyle: uiStyle)
                v.backgroundColor = UIColor.clear
            }
            else if let v = view as? UISegmentedControl
            {
                v.tintColor = GetFontColor(uiStyle: uiStyle)
                v.backgroundColor = UIColor.clear
            }
            else if let v = view as? UIImageView
            {
                v.image = ChangeBackgroundImage(uiStyle: uiStyle)
                v.backgroundColor = UIColor.clear
            }
            else
            {
                view.backgroundColor = GetBackGroundColor(uiStyle: uiStyle)
            }
        }
    }
    
    private func GetBackGroundColor(uiStyle:eUIStyles) -> UIColor {
        switch uiStyle {
        case .City:
            return UIColor(red: 69/255, green: 73/255, blue: 74/255, alpha: 1)
        case .Mandala:
            return UIColor(red: 183/255, green: 28/255, blue: 28/255, alpha: 1)
        case .Nature:
            return UIColor(red: 54/255, green: 109/255, blue: 54/255, alpha: 1)
        }
    }
    
    private func GetTextPresenterColor(uiStyle:eUIStyles) -> UIColor {
        switch uiStyle {
        case .City:
            return UIColor(red: 148/255, green: 149/255, blue: 145/255, alpha: 1)
        case .Mandala:
            return UIColor(red: 255/255, green: 138/255, blue: 128/255, alpha: 1)
        case .Nature:
            return UIColor(red: 79/255, green: 194/255, blue: 64/255, alpha: 1)
        }
    }
    
    private func GetButtonColor(uiStyle:eUIStyles) -> UIColor {
        switch uiStyle {
        case .City:
            return UIColor(red: 102/255, green: 101/255, blue: 96/255, alpha: 1)
        case .Mandala:
            return UIColor(red: 255/255, green: 82/255, blue: 82/255, alpha: 1)
        case .Nature:
            return UIColor(red: 70/255, green: 137/255, blue: 65/255, alpha: 1)
        }
    }
    
    private func GetFontColor(uiStyle:eUIStyles) -> UIColor {
        switch uiStyle {
        case .City:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        case .Mandala:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        case .Nature:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
    }
    
    private func GetBorderColor(uiStyle:eUIStyles) -> UIColor{
        switch uiStyle {
        case .City:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        case .Mandala:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        case .Nature:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
    }
    
    private func ChangeBackgroundImage(uiStyle:eUIStyles) -> UIImage {
        switch uiStyle {
        case .City:
            return UIImage(named: "LogInSignUpBG")!
        case .Mandala:
            return UIImage(named: "LoginSignUpBG2")!
        case .Nature:
            return UIImage(named: "LoginSignUpBG3")!
            
        }
    }
}
