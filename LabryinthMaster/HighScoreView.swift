//
//  HighScoreView.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class HighScoreView : UIView {
    
    let backButton = UIButton(type: UIButtonType.custom)
    let scores = UITableView()
    
    fileprivate let background = UIImageView(image: UIImage(named: "space6.jpg"))
    fileprivate let title = UIImageView(image: UIImage(named: "highscores.png"))
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(background)

        title.contentMode = .scaleAspectFit
        title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
        
        backButton.setTitle("Back", for: UIControlState())
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backButton)
        
        scores.backgroundColor = UIColor.clear
        scores.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scores)
        
        let views: [String:UIView] = ["background":background, "title":title, "back":backButton, "scores":scores]
        let metrics: [String:CGFloat] = ["sp":20, "bw":HighScoreView.buttonWidth, "bh":HighScoreView.buttonHeight, "ts":HighScoreView.buttonHeight + 40]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[background]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-sp-[back(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-sp-[back(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-sp-[title]-sp-|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-sp-[scores]-sp-|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-ts-[title]-sp-[scores]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var buttonWidth: CGFloat {
        return UIScreen.main.bounds.width / 2.5
    }
    
    static var buttonHeight: CGFloat {
        return UIScreen.main.bounds.height / 15
    }
}
