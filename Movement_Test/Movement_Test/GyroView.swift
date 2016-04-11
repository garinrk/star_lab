//
//  GyroView.swift
//  Movement_Test
//
//  Created by Garin Richards on 4/10/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit


class GyroView : UIView{
    
    var yawLabel : UILabel = UILabel()
    var pitchLabel : UILabel = UILabel()
    var rollLabel : UILabel = UILabel()
    
    var accXLabel : UILabel = UILabel()
    var accYLabel : UILabel = UILabel()
    var accZLabel : UILabel = UILabel()
    
    override func drawRect(rect: CGRect) {
        
        yawLabel.frame = CGRectMake(50, 50, 500, 200)
        pitchLabel.frame = CGRectMake(50, 100, 500, 200)
        rollLabel.frame = CGRectMake(50, 150, 500, 200)
        
        accXLabel.frame = CGRectMake(50,250,500,200)
        accYLabel.frame = CGRectMake(50,300,500,200)
        accZLabel.frame = CGRectMake(50, 350, 500, 200)
        
        
        yawLabel.text = "Yaw bitch"
        pitchLabel.text = "Pitch bitch"
        rollLabel.text = "Roll Bitch"
        
        accXLabel.text = "AccX Bitch"
        accYLabel.text = "AccY Bitch"
        accZLabel.text = "AccZ Bitch"
        
        self.addSubview(accXLabel)
        self.addSubview(accYLabel)
        self.addSubview(accZLabel)
        
        self.addSubview(yawLabel)
        self.addSubview(pitchLabel)
        self.addSubview(rollLabel)
    }
    
}