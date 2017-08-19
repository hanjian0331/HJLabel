//
//  HJLabelLayer.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/2.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

class HJLabelLayer: CALayer {

    override func draw(in ctx: CGContext) {
        
        let label = self.delegate as! HJLabel
        guard let _attributedText = label._attributedText else {
            return
        }
        
        //2
        ctx.translateBy(x: 0, y: bounds.height)
        ctx.scaleBy(x: 1, y: -1)
        
        //4
        let framesetter = CTFramesetterCreateWithAttributedString(_attributedText)
        
        //5
        let path = CGMutablePath()
        path.addRect(bounds)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, _attributedText.length), path, nil)
        
        //6
        CTFrameDraw(frame, ctx)
    }
    
}
