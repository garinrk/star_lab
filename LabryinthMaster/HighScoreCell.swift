//
//  HighScoreCell.swift
//  LabryinthMaster
//
//  Created by Michael Biggs on 1/24/17.
//  Copyright © 2017 Garin Richards. All rights reserved.
//

import UIKit

class HighScoreCell: UITableViewCell {

    fileprivate var _scoreIndex: Int = 0
    var scoreIndex: Int {
        get {
            return _scoreIndex
        }
        
        set {
            _scoreIndex = newValue
            updateText()
        }
    }
    
    fileprivate var _score: ScoreInfo?
    var score: ScoreInfo? {
        get {
            return _score
        }
        
        set {
            _score = newValue
            updateText()
        }
    }
    
    fileprivate let scoreLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        scoreLabel.font = UIFont.systemFont(ofSize: 35)
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textColor = UIColor.white
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scoreLabel)
        
        let views: [String:UIView] = ["label":scoreLabel]
        let metrics: [String:CGFloat] = ["sp":20]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        scoreLabel.text = ""
    }
    
    fileprivate func updateText() {
        if (_score != nil) {
            scoreLabel.text = "\(_scoreIndex). \(_score!.name)\t-\(_score!.score)-\t\(_score!.difficulty)"
        } else {
            scoreLabel.text = ""
        }
    }
}
