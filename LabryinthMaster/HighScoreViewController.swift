//
//  HighScoreViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/30/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit

protocol HighScoreViewControllerDelegate: class {
    func highScorePressedBack()
}

class HighScoreViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: HighScoreViewControllerDelegate? = nil

    fileprivate let scoreManager = ScoreManager.sharedInstance

    fileprivate var contentView: HighScoreView {
        return view as! HighScoreView
    }
    
    fileprivate var tableView: UITableView {
        return contentView.scores
    }
    
    override func loadView() {
        view = HighScoreView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.backButton.addTarget(self, action: #selector(backButtonPressed), for: UIControlEvents.touchUpInside)
        
        tableView.register(HighScoreCell.self, forCellReuseIdentifier: "HighScoreCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // for testing
//        scoreManager.generateRandomScores(numberOfScores: 25)
    }
    
    @objc fileprivate func backButtonPressed() {
        delegate?.highScorePressedBack()
    }
    
    //MARK:- UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreManager.scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HighScoreCell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath) as! HighScoreCell
        
        cell.score = scoreManager.scores[indexPath.row]
        cell.scoreIndex = indexPath.row + 1
        
        return cell
    }
    
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            return 50.0
        } else {
            return 30.0
        }
    }
}
