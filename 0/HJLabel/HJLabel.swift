//
//  HJLabel.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/2.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

@IBDesignable
class HJLabel: UIView {

    @IBInspectable var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        text?.draw(at: .zero, withAttributes: nil)
    }

}
