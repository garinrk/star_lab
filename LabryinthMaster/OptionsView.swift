//
//  OptionsView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/18/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class OptionsView : UIView {
    
    let musicSlider = UISlider()
    let fxSlider = UISlider()
    let backButton = UIButton(type: UIButton.ButtonType.custom)
    
    fileprivate let background = UIImageView(image: UIImage(named: "space3.jpg"))
    fileprivate let title = UIImageView(image: UIImage(named: "options.png"))
    fileprivate let musicLabel = UIImageView(image: UIImage(named: "musiclevel.png"))
    fileprivate let fxLabel = UIImageView(image: UIImage(named: "fxlevel.png"))
    fileprivate let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(background)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        title.contentMode = .scaleAspectFit
        title.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(title)
        
        musicLabel.contentMode = .scaleAspectFit
        musicLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(musicLabel)
        
        musicSlider.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(musicSlider)

        fxLabel.contentMode = .scaleAspectFit
        fxLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(fxLabel)
        
        fxSlider.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(fxSlider)

        backButton.setTitle("Back", for: UIControl.State())
        backButton.setTitleColor(UIColor.white, for: UIControl.State())
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backButton)
        
        let views: [String:UIView] = ["background":background, "stackView":stackView, "title":title, "back":backButton, "music":musicLabel, "musicSlider":musicSlider, "fx":fxLabel, "fxSlider":fxSlider]
        let metrics: [String:CGFloat] = ["sp":20, "vsp":OptionsView.verticalSpacer, "bw":OptionsView.buttonWidth, "bh":OptionsView.buttonHeight, "lw":OptionsView.labelWidth, "tw":OptionsView.titleWidth]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[background]|", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-vsp-[stackView]-vsp-|", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-sp-[back(bw)]", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-sp-[back(bh)]", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        self.addConstraint(NSLayoutConstraint(item: backButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[title(tw)]", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[music(lw)]", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[musicSlider(lw)]", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[fx(lw)]", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[fxSlider(lw)]", options: NSLayoutConstraint.FormatOptions(), metrics: metrics, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var verticalSpacer: CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    
    static var titleWidth: CGFloat {
        return UIScreen.main.bounds.width * 0.9
    }
    
    static var labelWidth: CGFloat {
        return UIScreen.main.bounds.width / 2
    }
    
    static var buttonWidth: CGFloat {
        return UIScreen.main.bounds.width / 2.5
    }
    
    static var buttonHeight: CGFloat {
        return UIScreen.main.bounds.height / 15
    }
}
