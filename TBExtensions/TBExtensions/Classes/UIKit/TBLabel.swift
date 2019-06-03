//
//  TBLabel.swift
//  TBExtensions
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 TrusBe. All rights reserved.
//

import UIKit

class TBLabel: UILabel {
    override func draw(_ rect: CGRect) {
        let inset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: inset))
    }
}

public extension UILabel {
    func drawWith(_ rect: CGRect, edge: UIEdgeInsets) {
        self.drawText(in: rect.inset(by: edge))
    }
}
