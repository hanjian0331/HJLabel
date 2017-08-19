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

    @IBInspectable var text: String? { didSet{ setNeedsDisplay() } }
    @IBInspectable var font: UIFont = UIFont.systemFont(ofSize: 17) { didSet{ setNeedsDisplay() } }
    @IBInspectable var textColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) { didSet{ setNeedsDisplay() } }
    @IBInspectable var textAlignment: NSTextAlignment = .left { didSet{ setNeedsDisplay() } }
    @IBInspectable var lineBreakMode: NSLineBreakMode = .byWordWrapping { didSet{ setNeedsDisplay() } }
    @IBInspectable var attributedText: NSAttributedString? { didSet{ setNeedsDisplay() } }
    
    var _attributedText: NSAttributedString? {
        get{
            if let attributedText = attributedText {
                return attributedText
            }
            
            guard text != nil else {
                return nil
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            paragraphStyle.lineBreakMode = lineBreakMode
            
            var attributes = [String:Any]()
            attributes[NSFontAttributeName] = font
            attributes[NSForegroundColorAttributeName] = textColor
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
            
            let attString = NSAttributedString(string: text!, attributes: attributes)
            return attString
        }
    }
    
    override open class var layerClass: Swift.AnyClass {
        get{
            return HJLabelLayer.self
        }
    }

    override func draw(_ rect: CGRect) {
        
    }
}
