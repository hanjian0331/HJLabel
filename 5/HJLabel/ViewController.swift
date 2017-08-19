//
//  ViewController.swift
//  HJLabel
//
//  Created by seemelk on 2017/5/2.
//  Copyright © 2017年 罕见. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = HJLabel()
        let content = "2月访日的#美国防部长#马蒂斯也经由该基地前往首相官邸，这里距离其造访的美国大使馆仅一箭之遥。直升机不论深夜还是清晨都在这里和横田基地等处之间不定期飞行。对于附近居民而言，噪音和对事故的不安难以消除。2月访日的美国防部长马蒂斯也经由该基地前往首相官邸，这里距离其造访的美国大使馆仅一箭之遥。直升机不论深夜还是清晨都在这里和横田基地等处之间不定期飞行。对于附近居民而言，噪音和对事故的不安难以消除。2月访日的美国防部长马蒂斯也经由该基地前往首相官邸，这里距离其造访的美国大使馆仅一箭之遥。直升机不论深夜还是清晨都在这里和横田基地等处之间不定期飞行。对于附近居民而言，噪音和对事故的不安难以消除。2月访日的美国防部长马蒂斯也经由该基地前往首相官邸，这里距离其造访的美国大使馆仅一箭之遥。直升机不论深夜还是清晨都在这里和横田基地等处之间不定期飞行。对于附近居民而言，噪音和对事故的不安难以消除。"
        
        
        
        let size = content.sizeWithConstrained(to: CGSize(width:320, height:CGFloat(HUGE)), fromFont: label.font, lineSpace: label.lineSpacing)
        label.frame = CGRect(x: 0, y: 20, width: 320, height: size.height)
        
        label.text = content
        view.addSubview(label)
        
        
        
    }



}

