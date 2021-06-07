//
//  TBLayer.swift
//  TBExtensions
//
//  Created by mac on 2021/6/7.
//  Copyright © 2021 TrusBe. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow(color: UIColor? = .black,
                   alpha: CGFloat = 0.5,
                   x: CGFloat = 0,
                   y: CGFloat = 2,
                   blur: CGFloat = 4,
                   spread: CGFloat = 0) {
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur * 0.5
        shadowColor = color?.cgColor
        shadowOpacity = Float(alpha)

        let rect = bounds.insetBy(dx: -spread, dy: -spread)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        shadowPath = path.cgPath
    }
}
