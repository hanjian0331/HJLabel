//
//  HJLabel.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/2.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

class HJLabel: UIView {

    var text: String? { didSet{ setNeedsDisplay() } }
    var textColor: UIColor = colors.text { didSet{ setNeedsDisplay() } }
    var lineSpacing: CGFloat = 4 { didSet{ setNeedsDisplay() } }
    var font: UIFont = fonts.content { didSet{ setNeedsDisplay() } }
    var textAlignment: NSTextAlignment = .left { didSet{ setNeedsDisplay() } }
    var lineBreakMode: NSLineBreakMode = .byWordWrapping { didSet{ setNeedsDisplay() } }
    
    private var highlightRange: NSRange? { didSet{ setNeedsDisplay() } }
    
    lazy var framesDict: [String: CGRect] = [:] // 可以点击高亮的位置
    
    var _attributedText: NSAttributedString? {
        get{
            guard text != nil else {
                return nil
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            paragraphStyle.lineBreakMode = lineBreakMode
            paragraphStyle.lineSpacing = lineSpacing
            
            var attributes = [String:Any]()
            attributes[NSFontAttributeName] = font
            attributes[NSForegroundColorAttributeName] = textColor
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
            
            let attString = NSMutableAttributedString(string: text!, attributes: attributes).highlightText(range: highlightRange)
            return attString
        }
    }
    
    
    override open class var layerClass: Swift.AnyClass {
        get{
            return HJLabelLayer.self
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self) ?? .zero
        for (key, rect) in framesDict where rect.contains(location) {
            highlightWord(NSRangeFromString(key))
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        backToNormal()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        backToNormal()
    }
    
    
    private func highlightWord(_ range: NSRange) {
        if  highlightRange?.location != range.location || highlightRange?.length != range.length {
            highlightRange = range
        }
    }
    
    private func backToNormal() {
        if highlightRange != nil {
            highlightRange = nil
        }
    }
    
    deinit {
        print("postview dealloc \(classForCoder)")
    }
}
