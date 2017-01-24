//
//  NewGameView.swift
//  UI_Test
//
//  Created by Garin Richards on 4/20/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

class NewGameView : UIView, UITextFieldDelegate {
    
    let backButton = UIButton(type: UIButtonType.custom)
    let easyButton = UIButton(type: UIButtonType.custom)
    let hardButton = UIButton(type: UIButtonType.custom)
    let startButton = UIButton(type: UIButtonType.custom)
    let nameTextField = UITextField(frame: CGRect.zero)

    fileprivate let background = UIImageView(image: UIImage(named: "space1.jpg"))
    fileprivate let title = UIImageView(image: UIImage(named: "newmission.png"))
    fileprivate let stackView = UIStackView()
    fileprivate let inputContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        background.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(background)
        
        backButton.setTitle("Back", for: UIControlState())
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        backButton.layer.borderWidth = 5
        backButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        title.contentMode = .scaleAspectFit
        title.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(title)
        
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(inputContainer)
        
        nameTextField.textAlignment = NSTextAlignment.center
        nameTextField.font = UIFont.systemFont(ofSize: 15)
        nameTextField.placeholder = "Enter Name"
        nameTextField.delegate = self
        nameTextField.textColor = UIColor.black
        nameTextField.borderStyle = UITextBorderStyle.roundedRect
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.keyboardType = UIKeyboardType.default
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(nameTextField)

        easyButton.setTitle("Easy", for: UIControlState())
        easyButton.setTitleColor(UIColor.white, for: UIControlState())
        easyButton.layer.borderWidth = 5
        easyButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        easyButton.layer.cornerRadius = 5
        easyButton.layer.borderColor = UIColor.white.cgColor
        easyButton.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(easyButton)
        
        hardButton.setTitle("Hard", for: UIControlState())
        hardButton.setTitleColor(UIColor.white, for: UIControlState())
        hardButton.layer.borderWidth = 5
        hardButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        hardButton.layer.cornerRadius = 5
        hardButton.layer.borderColor = UIColor.white.cgColor
        hardButton.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(hardButton)
        
        startButton.setTitle("Start Game", for: UIControlState())
        startButton.setTitleColor(UIColor(white: 1, alpha: 0.5), for: UIControlState.disabled)
        startButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        startButton.layer.borderWidth = 5
        startButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        startButton.layer.cornerRadius = 5
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(startButton)
        
        let views: [String:UIView] = ["background":background, "back":backButton, "stackView":stackView, "title":title, "input":inputContainer, "easy":easyButton, "hard":hardButton, "start":startButton, "text": nameTextField]
        
        let metrics: [String:CGFloat] = ["sp":20, "vsp":NewGameView.verticalSpacer, "bw":NewGameView.buttonWidth, "bh":NewGameView.buttonHeight]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[background]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-sp-[back(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-sp-[back(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-vsp-[stackView]-vsp-|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[start(bw)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[start(bh)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        inputContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[text]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        inputContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[easy(bw)]-sp-[hard(bw)]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        inputContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[text(bh)]-sp-[easy(bh)]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        inputContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[text]-sp-[hard(bh)]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
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
