//
//  ViewController.swift
//  spielmobile_remote
//
//  Created by Will Clark on 2016-10-30.
//  Copyright © 2016 WillClark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var leftSlider = SliderV(xPos: 0.1, screenWidth: self.view.frame.width, parent: self.view)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

