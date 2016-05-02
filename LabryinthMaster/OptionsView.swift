//
//  OptionsView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class OptionsView : UIView{
    
    var musicSlider : UISlider = UISlider()
    var fxSlider : UISlider = UISlider()
    var backButton = UIButton(type: UIButtonType.Custom)

    
    var titleImage = UIImage(named: "options.png")
    var titleImageBackground = UIImageView(frame: CGRectZero)
    
    var musicImage = UIImage(named: "musiclevel.png")
    var musicImageBackground = UIImageView()
    
    var fxImage = UIImage(named: "fxlevel.png")
    var fxImageBackground = UIImageView()
    
    var screenRect = UIScreen.mainScreen().bounds
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        titleImageBackground.image = titleImage
        addSubview(titleImageBackground)
        titleImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        musicImageBackground.image = musicImage
        addSubview(musicImageBackground)
        musicImageBackground.translatesAutoresizingMaskIntoConstraints = false

        fxImageBackground.image = fxImage
        addSubview(fxImageBackground)
        fxImageBackground.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setTitle("Back to Menu", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(musicSlider)
        musicSlider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fxSlider)
        fxSlider.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:UIView] = ["title":titleImageBackground, "back":backButton, "music":musicImageBackground, "musicSlider":musicSlider, "fx":fxImageBackground, "fxSlider":fxSlider]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[title]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-100-[music(==musicSlider)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-100-[musicSlider]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-100-[fx(==musicSlider)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-100-[fxSlider(==musicSlider)]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[back]-80-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[title]-40-[music]-[musicSlider]-[fx]-[fxSlider]-80-[back(<=100,>=50)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))


        addConstraint(NSLayoutConstraint(item: titleImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: titleImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 2.2, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: musicImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: musicImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 3.6, constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: fxImageBackground, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: fxImageBackground, attribute: NSLayoutAttribute.Height, multiplier: 2.7, constant: 0.0))
    
    
//        addConstraint(NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: backButton, attribute: NSLayoutAttribute.Width, multiplier: 0.2, constant: 0.0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
