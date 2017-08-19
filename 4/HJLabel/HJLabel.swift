//
//  HJLabel.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/2.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit
import YYAsyncLayer

@IBDesignable
class HJLabel: UIView {

    @IBInspectable var text: String? { didSet{ commitUpdate() } }
    @IBInspectable var font: UIFont = UIFont.systemFont(ofSize: 17) { didSet{ commitUpdate() } }
    @IBInspectable var textColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) { didSet{ commitUpdate() } }
    @IBInspectable var textAlignment: NSTextAlignment = .left { didSet{ commitUpdate() } }
    @IBInspectable var lineBreakMode: NSLineBreakMode = .byWordWrapping { didSet{ commitUpdate() } }
    @IBInspectable var lineSpacing: CGFloat = 0 { didSet{ commitUpdate() } }
    @IBInspectable var attributedText: NSAttributedString? { didSet{ commitUpdate() } }

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
            paragraphStyle.lineSpacing = lineSpacing
            
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
            return YYAsyncLayer.self
        }
    }
    
    override func draw(_ rect: CGRect) {
       
    }
    
    func commitUpdate() {
        YYTransaction(target: self, selector:#selector(contentNeedUpdate)).commit()
    }
    
    @objc
    func contentNeedUpdate() {
        layer.setNeedsDisplay()
    }
}

extension HJLabel: YYAsyncLayerDelegate {
    func newAsyncDisplayTask() -> YYAsyncLayerDisplayTask {
        let task = YYAsyncLayerDisplayTask()
        task.willDisplay = { layer in
            
        }
        task.display = { [weak self] (context, size, isCancelled) in
            if isCancelled() {
                return;
            }
            guard let _attributedText = self?._attributedText else {
                return
            }
            if isCancelled() {
                return;
            }
            
            //2
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1, y: -1)
            
            //3
            if self?.layer.isOpaque ?? false {
                if self?.backgroundColor != nil {
                    self?.backgroundColor?.setFill()
                } else {
                    UIColor.white.setFill()
                }
                context.fill(CGRect(origin: .zero, size: size))
            }
            
            //4
            let framesetter = CTFramesetterCreateWithAttributedString(_attributedText)
            
            //5
            let path = CGMutablePath()
            path.addRect(CGRect(origin: .zero, size: size))
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, _attributedText.length), path, nil)
            
            //6
            CTFrameDraw(frame, context)
        }
        task.didDisplay = { layer, finished in
            
        }
        return task
    }
}
