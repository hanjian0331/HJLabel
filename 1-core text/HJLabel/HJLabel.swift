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
    @IBInspectable var textAlignment: NSTextAlignment = .left
    @IBInspectable var lineBreakMode: NSLineBreakMode = .byWordWrapping
    
    override func draw(_ rect: CGRect) {
        
        guard let text = text else {
            return
        }
        
        //1
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //2
//        context.translateBy(x: 0, y: rect.height)
//        context.scaleBy(x: 1, y: -1)
        
        //3
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        var attributes = [String:Any]()
        attributes[NSFontAttributeName] = font
        attributes[NSForegroundColorAttributeName] = textColor
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        
        let attString = NSAttributedString(string: text, attributes: attributes)
        
        //4
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
    
        //5
        let path = CGMutablePath()
        path.addRect(rect)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path, nil)
        
        //6
        CTFrameDraw(frame, context)
        
    }

}
