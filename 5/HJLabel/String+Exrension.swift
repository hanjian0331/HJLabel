//
//  String+Exrension.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/5.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

extension String{
    
    func sizeWithConstrained(to size: CGSize, fromFont font: UIFont, lineSpace: CGFloat) -> CGSize {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        
        var attributes = [String:Any]()
        attributes[NSFontAttributeName] = font
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        
        let string = NSAttributedString(string: self, attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(string)
        
        let result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, string.length), nil, size, nil)
        return result
    }
}
