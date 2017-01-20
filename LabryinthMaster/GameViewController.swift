//
//  GameViewController.swift
//  LabryinthMaster
//
//  Created by Garin Richards on 4/22/16.
//  Copyright © 2016 Garin Richards. All rights reserved.
//

import UIKit
import CoreMotion

protocol GameViewControllerDelegate: class {
    func backToMainPressed()
}

class GameViewController : UIViewController, GyroDelegate, EnemyViewDelegate, PlayerDelegate, GameManagerDelegate, GameTimerDelegate, PauseViewDelegate, GameOverViewControllerDelegate, LevelCompleteViewControllerDelegate {
    let screenRect = UIScreen.main.bounds
    var gyroManager : Gyro!
    
    var scoreLabel: UILabel!
    var timerLabel: UILabel!
    var levelLabel: UILabel!
    var pauseButton = UIButton(type: UIButtonType.custom)
    
    var mazeView: MazeView!
    
    var _audioManager : AudioManager = AudioManager.sharedInstance
    var _gameManager : GameManager = GameManager.sharedInstance
    
    var gameOverController : GameOverViewController?
    var levelCompleteController : LevelCompleteViewController?
    var pauseController : PauseViewController?
    
    weak var delegate: GameViewControllerDelegate? = nil
    var backgroundImage = UIImage(named: "space.jpg")
    var backgroundImageView = UIImageView(frame: CGRect.zero)
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MANAGERS
        _gameManager.delegate = self
        gyroManager = Gyro()
        gyroManager.delegate = self
        gyroManager.Start()
        gyroManager.Pause()
    }
    
    func startNewGame(name: String, difficulty: DifficultyMode)
    {
        _gameManager.playerName = name
        _gameManager.mode = difficulty
        makeNewLevel()
    }
    
    func makeNewLevel()
    {
        // get rid of old views
        for sview in view.subviews {
            sview.removeFromSuperview()
        }
        
        // put in background
        //        self.view.backgroundColor = UIColor.yellowColor()
        backgroundImageView.frame = screenRect
        backgroundImageView.image = backgroundImage
        self.view.addSubview(backgroundImageView)
        
        _gameManager.makeNewLevel()
        
        // initialize maze view
//        mazeView.backgroundColor = UIColor(white: 0, alpha: 0)
        mazeView = MazeView(frame: CGRect(x: 0, y: 50.0, width: screenRect.width, height: screenRect.width))
        for cell in _gameManager.maze.cells {
            mazeView.addCell(north: cell.north, east: cell.east, south: cell.south, west: cell.west, x: cell.x, y: cell.y)
        }
        for _ in 0 ..< _gameManager.coinAmt {
            mazeView.placeRandomCoin()
        }
        
        mazeView.placeGoal(x: 29, y: 29)
        // add subviews and assign delegates
        view.addSubview(mazeView)
        
        for enemy in _gameManager.enemies {
            view.addSubview(enemy)
            enemy.delegate = self
        }
        view.addSubview(_gameManager.player)
        _gameManager.player.delegate = self
        
        _gameManager.timer.delegate = self
        
        scoreLabel = UILabel(frame: CGRect(x: 50.0, y: screenRect.width + 75.0, width: screenRect.width, height: 80.0))
        scoreLabel.textColor = UIColor.white
        scoreLabel.text = "SCORE: \(_gameManager.currentScore)"
        view.addSubview(scoreLabel)
        
        timerLabel = UILabel(frame: CGRect(x: 50.0, y: screenRect.width + 115.0, width: screenRect.width, height: 80.0))
        timerLabel.textColor = UIColor.white
        timerLabel.text = "TIME LEFT: \(_gameManager.timeLeft)"
        view.addSubview(timerLabel)
        
        levelLabel = UILabel(frame: CGRect(x: 50.0, y: screenRect.width + 155.0, width: screenRect.width, height: 80.0))
        levelLabel.textColor = UIColor.white
        levelLabel.text = "LEVEL: \(_gameManager.currentLevel)"
        view.addSubview(levelLabel)
        
        pauseButton.frame = CGRect(x: 0,y: 0, width: 75, height: 40.0)
        pauseButton.setTitle("PAUSE", for: UIControlState())
        pauseButton.setTitleColor(UIColor.white, for: UIControlState())
        pauseButton.layer.borderWidth = 5
        pauseButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        pauseButton.layer.cornerRadius = 5
        pauseButton.layer.borderColor = UIColor.white.cgColor
        pauseButton.addTarget(self, action: #selector(GameViewController.PauseGame), for: UIControlEvents.touchUpInside)
        view.addSubview(pauseButton)
        
        // start the game
        _gameManager.startGame()
        gyroManager.Unpause()
        
        _audioManager.PlayAudio(type: SoundType.startLevel)
    }
    
    // MARK: GyroDelegate functions
    
    /**
     Updates the player's position on the view, from the
     GyroDelegate
     
     - parameter x: magnitude in x
     - parameter y: magnitude in y
     */
    func UpdatePlayerPosition(magX: CGFloat, magY: CGFloat)
    {
        _gameManager.currentGyroMagX = magX
        _gameManager.currentGyroMagY = magY
    }
    
    func PauseGame(){
        _gameManager.pause()
        gyroManager.Pause()
        pauseController = PauseViewController()
        pauseController!.delegate = self
        _audioManager.PlayAudio(type: SoundType.confirm)
        self.present(pauseController!, animated: false, completion: nil)
    }

    func UnpauseGame() {
        _audioManager.PlayAudio(type: SoundType.confirm)
        _gameManager.unpause()
        gyroManager.Unpause()
    }
    
    // MARK: EnemyViewDelegate functions
    func getMazeDimension() -> Int
    {
        return _gameManager.maze.dimension
    }
    
    func getMazeCellPos(x: Int, y: Int) -> CGPoint
    {
        return mazeView.getCellPos(x: x, y: y)
    }
    
    func getMazeCellAt(x: Int, y: Int) -> MazeViewCell?
    {
        return mazeView.cells["\(x),\(y)"]
    }
    
    func getMazeCellSize() -> CGSize
    {
        return mazeView.getCellSize()
    }
    
    func detectCollisionFromEnemy(square: CGRect) -> Collision
    {
        return mazeView.detectCollisionWith(rect: square)
    }
    
    func getPlayerCell() -> MazeViewCell
    {
        return getMazeCellAt(x: _gameManager.player.cellX, y: _gameManager.player.cellY)!
    }

    func reportPlayerCollision()
    {
        _audioManager.PlayAudio(type: SoundType.enemyKill)
        _gameManager.kill()
    }

    
    // MARK: PlayerDelegate functions
    func detectCollisionFromPlayer(square: CGRect) -> Collision
    {
        return mazeView.detectCollisionWith(rect: square)
    }
    
    func coinCollected(coll collision: Collision)
    {        
        for coinView in mazeView.subviews{
            if coinView.tag == collision.collisionTag
            {
                coinView.setNeedsDisplay()
            }
        }
        mazeView.cells["\(collision.cellX),\(collision.cellY)"]?.hasCoin = false
        _gameManager.coinCollected()
        _audioManager.PlayAudio(type: SoundType.coin)
        scoreLabel.text = "SCORE: \(_gameManager.currentScore)"
    }
    
    func reportNewCollider(position: CGRect)
    {
        for enemy in _gameManager.enemies
        {
            enemy.updatePlayerCollision(location: position)
        }
    }
    
    func goalReached()
    {
        _audioManager.PlayAudio(type: SoundType.win)
        _gameManager.win()
        levelLabel.text = "LEVEL: \(_gameManager.currentLevel)"
    }
    
    // MARK: GameManagerDelegate functions
    func GameOverCall(score: Int){
        gameOverController = GameOverViewController()
        gameOverController?.lifetimeScore = score
        gameOverController?.delegate = self
//        _audioManager.StopAllAudio()
        gyroManager.Pause()
        self.present(gameOverController!, animated: false, completion: nil)
    }
    
    func WinGameCall(score : Int){
        levelCompleteController = LevelCompleteViewController()
        levelCompleteController?.delegate = self
        levelCompleteController?.lifetimeScore = score
//        _audioManager.StopAllAudio()
        //silence sound effects maybe?
        gyroManager.Pause()
        self.present(levelCompleteController!, animated: false, completion: nil)
    }
    
    // MARK: GameTimerDelegate functions
    func updateTime(time: Int)
    {
        _gameManager.timeLeft = time
        timerLabel.text = "TIME LEFT: \(_gameManager.timeLeft)"
        if time <= 0
        {
            _audioManager.PlayAudio(type: SoundType.outOfTime)
            _gameManager.kill()
        }
    }

    // MARK: GameOverViewControllerDelegate functions
    func gameOverPressedRetry()
    {
        self.dismiss(animated: false, completion: nil)
        makeNewLevel()
    }
    
    func gameOverPressedExit()
    {
        _audioManager.PlayAudio(type: SoundType.confirm)
        _gameManager.quit()
        self.dismiss(animated: false, completion: nil)
        delegate?.backToMainPressed()
    }
    
    // MARK: LevelCompleteViewControllerDelegate functions
    func levelCompletePressedRetry()
    {
        self.dismiss(animated: false, completion: nil)
        makeNewLevel()
    }
    
    func levelCompletePressedExit()
    {
        _audioManager.PlayAudio(type: SoundType.confirm)
        _gameManager.quit()
        self.dismiss(animated: false, completion: nil)
        delegate?.backToMainPressed()
    }
    
    // MARK: PauseViewDelegate functions
    func pausePressedQuit() {
        _audioManager.PlayAudio(type: SoundType.confirm)
        _gameManager.quit()
        self.dismiss(animated: false, completion: nil)
        delegate?.backToMainPressed()
    }
    
    func pausePressedUnpause() {
        self.dismiss(animated: false, completion: nil)
        UnpauseGame()
    }
}
