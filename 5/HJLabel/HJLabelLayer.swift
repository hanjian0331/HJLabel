//
//  HJLabelLayer.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/2.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

class HJLabelLayer: CALayer {
    
    private var label: HJLabel {
        get{
            return self.delegate as! HJLabel
        }
    }

    override func display() {
        
        let label = self.delegate as! HJLabel
        guard let _attributedText = label._attributedText else {
            return
        }
        
        let bounds = self.bounds
        let contentsScale = self.contentsScale
        let isOpaque = label.isOpaque

        
        DispatchQueue.global().async { [weak self] in
            //1
            UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, contentsScale)
            guard let ctx = UIGraphicsGetCurrentContext() else {
                UIGraphicsEndImageContext()
                return
            }
            
            //2
            ctx.textMatrix = .identity
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
//            CTFrameDraw(frame, ctx)
            self?.draw(frame: frame, ctx: ctx)
            
            //7
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                //8
                self?.contents = image?.cgImage
                
//                self?.debugDraw()
            }

        }
        
    }
    
    //6
    private func draw(frame: CTFrame, ctx: CGContext){
        
        let lines = CTFrameGetLines(frame)
        
        let numberOfLines = CFArrayGetCount(lines)
        
        var lineOrigins = [CGPoint](repeating: CGPoint.zero, count: numberOfLines)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), &lineOrigins)
        
        let textColor = label.textColor
        
        for lineIndex in 0..<numberOfLines {
            var lineOrigin = lineOrigins[lineIndex]
            lineOrigin = CGPoint(x: ceil(lineOrigin.x), y: ceil(lineOrigin.y))
            ctx.textPosition = lineOrigin
            
            //1
            let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, lineIndex), to: CTLine.self)
            //1.1
            CTLineDraw(line, ctx)
            
            //2
            let runs = CTLineGetGlyphRuns(line) as! [CTRun]
            for j in 0 ..< runs.count {
                var runAscent: CGFloat = 0
                var runDescent: CGFloat = 0
                let run = runs[j]
                
                //2.1
//                CTRunDraw(run, ctx, CFRangeMake(0, 0))
                
                let attributes = CTRunGetAttributes(run) as! [String: Any]
                
                guard let fgColor = attributes["NSColor"] else { continue }
                
                if (fgColor as! UIColor) != textColor {
                    let range = CTRunGetStringRange(run)
                    let width = CGFloat(CTRunGetTypographicBounds(run, CFRange(location: 0, length: 0), &runAscent, &runDescent, nil))
                    let offset = CTLineGetOffsetForStringIndex(line, range.location, nil)
                    let runRect = CGRect(x: lineOrigin.x + offset, y: bounds.height - lineOrigin.y - runAscent + runDescent / 2, width: width, height: runAscent)
                    let nRange = NSRange(location: range.location, length: range.length)
                    label.framesDict[NSStringFromRange(nRange)] = runRect
                }
            }
        }
    }
    
    private func debugDraw() {
        for value in label.framesDict.values {
            let v = UIView(frame: value)
            v.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
            label.addSubview(v)
        }
    }
    
    deinit {
        print("postview dealloc \(classForCoder)")
    }
}


