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
    
    override func drawRect(rect: CGRect) {
        yawLabel.frame = CGRectMake(50, 50, 50, 20)
        pitchLabel.frame = CGRectMake(50, 100, 50, 20)
        rollLabel.frame = CGRectMake(50, 150, 50, 20)
        
        self.addSubview(yawLabel)
        self.addSubview(pitchLabel)
        self.addSubview(rollLabel)
    }
    
}