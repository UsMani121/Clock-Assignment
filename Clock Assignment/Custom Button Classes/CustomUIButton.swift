//
//  CustomUIButton.swift
//  Clock Assignment
//
//  Created by Muhammad Usman on 08/07/2021.
//

import Foundation
import UIKit

enum MyButtonState {
    case Start,Stop,Reset,Lap
}

@IBDesignable
class CustomUIButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
   
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0 {
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    
    
    
   // var customState: MyButtonState = .Start
    
    
}
