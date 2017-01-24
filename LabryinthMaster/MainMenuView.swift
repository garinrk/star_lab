//
//  MainMenuView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/17/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class MainMenuView : UIView{
    
    let newGameButton = UIButton(type: UIButtonType.custom)
    let optionsButton = UIButton(type: UIButtonType.custom)
    let scoresButton = UIButton(type: UIButtonType.custom)
    
    fileprivate let background = UIImageView(image: UIImage(named: "space2.jpg"))
    fileprivate let titleContainer = UIView()
    fileprivate let title = UIImageView(image: UIImage(named: "title_logo.png"))
    fileprivate let authors = UIImageView(image: UIImage(named: "authors.png"))
    fileprivate let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(background)
        
        title.contentMode = .scaleAspectFit
        title.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(title)
        
        authors.contentMode = .scaleAspectFit
        authors.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(authors)

        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleContainer)
        
        newGameButton.setTitle("New Game", for: UIControlState())
        newGameButton.setTitleColor(UIColor.white, for: UIControlState())
        newGameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        newGameButton.layer.borderWidth = 5
        newGameButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        newGameButton.layer.cornerRadius = 5
        newGameButton.layer.borderColor = UIColor.white.cgColor
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(newGameButton)
        
        optionsButton.setTitle("Options",for: UIControlState())
        optionsButton.setTitleColor(UIColor.white, for: UIControlState())
        optionsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        optionsButton.layer.borderWidth = 5
        optionsButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        optionsButton.layer.cornerRadius = 5
        optionsButton.layer.borderColor = UIColor.white.cgColor
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(optionsButton)
        
        scoresButton.setTitle("High Scores", for: UIControlState())
        scoresButton.setTitleColor(UIColor.white, for: UIControlState())
        scoresButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        scoresButton.layer.borderWidth = 5
        scoresButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        scoresButton.layer.cornerRadius = 5
        scoresButton.layer.borderColor = UIColor.white.cgColor
        scoresButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(scoresButton)
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        let views: [String:UIView] = ["stackView":stackView, "background":background, "titleContainer":titleContainer, "title":title, "authors":authors, "newGame":newGameButton, "options":optionsButton, "scores":scoresButton]
        
        let metrics: [String:CGFloat] = ["sp" : MainMenuView.spacer, "bsp" : MainMenuView.bigSpacer, "vsp" : MainMenuView.verticalSpacer, "bw" : MainMenuView.buttonWidth, "bh" : MainMenuView.buttonHeight]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[background]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-vsp-[stackView]-vsp-|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        titleContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[title]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        titleContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-bsp-[authors]-bsp-|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        titleContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[title]-sp-[authors]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        // constrain button sizes
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[newGame(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[scores(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[options(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[newGame(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[scores(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[options(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var spacer: CGFloat {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            return 20
        } else {
            return 0
        }
    }
    
    static var bigSpacer: CGFloat {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            return 80
        } else {
            return 50
        }
    }
    
    static var verticalSpacer: CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    
    static var buttonWidth: CGFloat {
        return UIScreen.main.bounds.width / 2.5
    }
    
    static var buttonHeight: CGFloat {
        return UIScreen.main.bounds.height / 15
    }
}
