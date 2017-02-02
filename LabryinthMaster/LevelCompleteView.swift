//
//  LevelCompleteView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class LevelCompleteView : UIView {

    var lifetimeScoreAmt : Int = 0
    
    let continueButton = UIButton(type: UIButtonType.custom)
    let quitButton = UIButton(type: UIButtonType.custom)
    
    fileprivate let stackView = UIStackView()
    fileprivate let background = UIImageView(image: UIImage(named: "blackHole.jpg"))
    fileprivate var title = UIImageView(image: UIImage(named: "missioncomplete.png"))
    fileprivate let scoreTitleLabel = UILabel()
    fileprivate let scoreLabel = UILabel()
    fileprivate let buttonStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

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
        
        scoreTitleLabel.text = "Total Score:"
        scoreTitleLabel.adjustsFontSizeToFitWidth = true
        scoreTitleLabel.textAlignment = .center
        scoreTitleLabel.textColor = UIColor.white
        scoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        scoreTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(scoreTitleLabel)

        scoreLabel.text = lifetimeScoreAmt.description
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = UIColor.white
        scoreLabel.font = UIFont.systemFont(ofSize: 30)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(scoreLabel)
        
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.distribution = .equalSpacing
        buttonStackView.spacing = 20
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(buttonStackView)
        
        quitButton.setTitle("Quit",for: UIControlState())
        quitButton.setTitleColor(UIColor.white, for: UIControlState())
        quitButton.layer.borderWidth = 5
        quitButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderColor = UIColor.white.cgColor
        quitButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(quitButton)
        
        continueButton.setTitle("Continue", for: UIControlState())
        continueButton.setTitleColor(UIColor.white, for: UIControlState())
        continueButton.layer.borderWidth = 5
        continueButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        continueButton.layer.cornerRadius = 5
        continueButton.layer.borderColor = UIColor.white.cgColor
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(continueButton)
        
        let views: [String:UIView] = ["bg":background, "stackView":stackView, "quit":quitButton, "continue":continueButton]
        let metrics: [String:CGFloat] = ["sp":20, "vsp":LevelCompleteView.verticalSpacer, "bh":LevelCompleteView.buttonHeight, "bw":LevelCompleteView.buttonWidth]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bg]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[bg]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-sp-[stackView]-sp-|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-vsp-[stackView]-vsp-|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        // constrain button sizes
        
        buttonStackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[quit(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        buttonStackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[continue(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        buttonStackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[quit(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        buttonStackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[continue(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
