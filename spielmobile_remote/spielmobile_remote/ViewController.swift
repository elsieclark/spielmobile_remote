//
//  ViewController.swift
//  spielmobile_remote
//
//  Created by Will Clark on 2016-10-30.
//  Copyright © 2016 WillClark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var screenWidth : CGFloat!
    var prevLeft : Int = 0
    var prevRight : Int = 0
    var leftSlider : SliderVert!
    var rightSlider : SliderVert!
    var videoWindow : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenWidth = self.view.frame.width
        
        self.view.backgroundColor = UIColor.black
        
        self.rightSlider = SliderVert(xPos: 0.9375, screenWidth: screenWidth, parent: self.view)
        self.leftSlider = SliderVert(xPos: 0.0625, screenWidth: screenWidth, parent: self.view)
        
        self.videoWindow = UIView(frame: CGRect(x: screenWidth * 0.125, y: 0, width: screenWidth * 3 / 4, height: screenWidth * 9 / 16))
        videoWindow.backgroundColor = UIColor.darkGray
        self.view.addSubview(videoWindow)
        
        let _ = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(ViewController.checkForUpdates), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForUpdates() {
        var postRequired = false
        
        if prevLeft != leftSlider.yValue {
            prevLeft = leftSlider.yValue
            postRequired = true
        }
        if prevRight != rightSlider.yValue {
            prevRight = rightSlider.yValue
            postRequired = true
        }
        
        if postRequired {
            SocketIOManager.sharedInstance.sendMessage(message: String(prevLeft) + "+" + String(prevRight))
        }
        
    }
}

