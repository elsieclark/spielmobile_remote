//
//  SliderVert.swift
//  spielmobile_remote
//
//  Created by Will Clark on 2016-10-30.
//  Copyright © 2016 WillClark. All rights reserved.
//

import UIKit

class SliderVert: UIView {
    
    var screenWidth : CGFloat!
    var yValue : Int = 0
    var track : UIView!
    var knob : UIView!
    var percentLabel : UILabel!

    init(xPos : CGFloat, screenWidth: CGFloat, parent: UIView) {
        
        self.screenWidth = screenWidth
        
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth / 15, height: screenWidth * (9/16) * 0.7))
        
        self.center = CGPoint(x: screenWidth * xPos, y: screenWidth * (10/32))
        
        self.percentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.15, height: 50))
        self.percentLabel.text =  "0"
        parent.addSubview(self.percentLabel)
        self.percentLabel.center = CGPoint(x: self.center.x, y: screenWidth * (9/16) * 0.10)
        self.percentLabel.textAlignment = .center
        self.percentLabel.font = UIFont(name: "Helvetica-Light", size: 40)
        self.percentLabel.textColor = UIColor.white
        
        self.track = UIView(frame: CGRect(x: self.frame.width / 2 - 2, y: 0, width: 4, height: self.frame.height))
        self.track.backgroundColor = UIColor.gray
        self.track.layer.cornerRadius = self.track.frame.width / 2
        
        self.knob = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth / 15, height: screenWidth / 15))
        self.knob.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.knob.backgroundColor = UIColor.green
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(SliderVert.pan(_:)))
        panRecognizer.maximumNumberOfTouches = 1
        panRecognizer.minimumNumberOfTouches = 1
        self.knob.addGestureRecognizer(panRecognizer)
        self.knob.isUserInteractionEnabled = true
        
        self.knob.backgroundColor = UIColor(patternImage: resizeImage(UIImage(named: "joyknob_01.png")!, targetSize: CGSize(width: self.knob.frame.width, height: self.knob.frame.height)))
        
        self.addSubview(track)
        self.addSubview(knob)
        
        self.superview?.bringSubview(toFront: self.knob)
        
        parent.addSubview(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 5.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func pan(_ recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: recognizer.view!)
        
        self.knob.center.y = self.frame.height / 2 + translation.y
        
        if translation.y > self.frame.height / 2 - self.knob.frame.height / 2 {
            self.knob.center.y = self.frame.height - self.knob.frame.height / 2
        }
        else if translation.y < -(self.frame.height / 2 - self.knob.frame.height / 2) {
            self.knob.center.y = self.knob.frame.height / 2
        }
        
        switch recognizer.state {
        case .began:
            self.superview?.bringSubview(toFront: self.knob)
        case .ended:
            self.knob.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            
        default: break
        }
        
        let w = (self.frame.height - self.knob.frame.height) / 2
        self.yValue = Int(((-100*(self.knob.center.y - self.frame.height / 2)/w) + 0.001).rounded())

        //print(String(describing: yValue))
        
        self.percentLabel.text = String(describing: yValue)
        
        
    }

}
