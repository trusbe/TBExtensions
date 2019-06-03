//
//  TBTextField.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import UIKit

public class TBTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
