//
//  HJLabelLayer.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/2.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

class HJLabelLayer: CALayer {

    override func display() {
        
        let label = self.delegate as! HJLabel
        guard let _attributedText = label._attributedText else {
            return
        }
        
        let bounds = self.bounds
        let contentsScale = self.contentsScale
        let isOpaque = self.isOpaque
        
        DispatchQueue.global().async {
            //1
            UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, contentsScale)
            guard let ctx = UIGraphicsGetCurrentContext() else {
                UIGraphicsEndImageContext()
                return
            }
            
            //2
            ctx.translateBy(x: 0, y: bounds.height)
            ctx.scaleBy(x: 1, y: -1)
            
            //3
            if isOpaque {
                if label.backgroundColor != nil {
                    label.backgroundColor?.setFill()
                } else {
                    UIColor.white.setFill()
                }
                ctx.fill(bounds)
            }
            
            //4
            let framesetter = CTFramesetterCreateWithAttributedString(_attributedText)
            
            //5
            let path = CGMutablePath()
            path.addRect(bounds)
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, _attributedText.length), path, nil)
            
            //6
            CTFrameDraw(frame, ctx)
            
            //7
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //8
            self.contents = image?.cgImage
            
//            DispatchQueue.main.async {
                //8
//                self.contents = image?.cgImage
//            }
        }
        
    }
}
