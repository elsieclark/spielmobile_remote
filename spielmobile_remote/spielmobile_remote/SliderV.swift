//
//  SliderV.swift
//  spielmobile_remote
//
//  Created by Will Clark on 2016-10-30.
//  Copyright © 2016 WillClark. All rights reserved.
//

import UIKit

class SliderV: UIView {
    
    var screenWidth : CGFloat!
    var currentSetting : CGFloat = 0
    var knob : UIView!

    init(xPos : CGFloat, screenWidth: CGFloat, parent: UIView) {
        
        self.screenWidth = screenWidth
        
        var frame = CGRect(x: 0, y: 0, width: screenWidth * 0.1, height: screenWidth * 0.8)
        
        
        super.init(frame: frame)
        
        self.center = CGPoint(x: screenWidth * xPos, y: screenWidth * (9/32))
        
        self.backgroundColor = UIColor.blue
        
        parent.addSubview(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
