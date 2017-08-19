//
//  NSMutableAttributedString+Extension.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/3.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

// 对应高亮颜色、正则表达式的key
let kRegexHighlightViewTypeURL = "url"
let kRegexHighlightViewTypeAccount = "account"
let kRegexHighlightViewTypeTopic = "topic"
let kRegexHighlightViewTypeEmoji = "emoji"

// 正则表达式
let URLRegular = "(http|https)://(t.cn/|weibo.com/)+(([a-zA-Z0-9/])*)"
let EmojiRegular = "(\\[\\w+\\])"
let AccountRegular = "@[一-龥a-zA-Z0-9_-]{2,30}"
let TopicRegular = "#[^#]+#"

//Define the definition to use
let definition = [
    kRegexHighlightViewTypeAccount: AccountRegular,
    kRegexHighlightViewTypeURL: URLRegular,
    kRegexHighlightViewTypeTopic: TopicRegular,
    kRegexHighlightViewTypeEmoji: EmojiRegular,
]

extension NSMutableAttributedString{
    func highlightText(range highlightRange: NSRange?) -> NSMutableAttributedString {
        //Create a mutable attribute string to set the highlighting
        let string = self.string
        let range = NSRange(location: 0, length: string.characters.count)
        
        //For each definition entry apply the highlighting to matched ranges
        for (_, expression) in definition {
            
            guard let matches = try? NSRegularExpression(pattern: expression, options: .dotMatchesLineSeparators).matches(in: string, options: [], range: range) else { continue }
            for match in matches {

                if let currentRange = highlightRange {
                    if currentRange.location>=match.range.location && currentRange.length+currentRange.location<=match.range.length+match.range.location {
                        addAttribute(NSBackgroundColorAttributeName, value: colors.highlight.withAlphaComponent(0.2), range: match.range)
                    }
                }
                // 正则中定义需要特殊处理的字符串
                addAttribute(NSForegroundColorAttributeName, value: colors.highlight, range: match.range)
            }
        }
        return self
    }
}
