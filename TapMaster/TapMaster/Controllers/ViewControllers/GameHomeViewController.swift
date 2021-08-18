//
//  GameHomeViewController.swift
//  TapMaster
//
//  Created by lijia xu on 8/18/21.
//

import UIKit
import Combine

class GameHomeViewController: UIViewController {
    
    // MARK: - Views
    //buttons
    private lazy var playerOneButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        
        btn.addTarget(self, action: #selector(playerOneTappedButton), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var playerTwoButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        
        btn.addTarget(self, action: #selector(playerTwoTappedButton), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        
        btn.addTarget(self, action: #selector(startGamePressed), for: .touchUpInside)
        
        return btn
    }()
    
    //Labels
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = ""
        
        return label
    }()
    
    
    private lazy var playerOneScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = .center
        label.textColor = .red
        
        return label
    }()
    
    private lazy var playerTwoScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = .center
        label.textColor = .blue
        
        return label
    }()
    
    
    // MARK: - Properties
    let playerButtonHeight: CGFloat = 150
    let countDownFrom: Int = 5
    
    var playerOneScores: Int?
    var playerTwoScores: Int?
    
    
    
    var subscriptions = Set<AnyCancellable>()
    
    var isGameInProgress: Bool = false {
        didSet {
            startButton.isHidden = isGameInProgress
            
            playerOneButton.isHidden = !isGameInProgress
            playerTwoButton.isHidden = !isGameInProgress
        }
    }
    
    var counterForPlayerOne: Int = 0 {
        didSet{
            playerOneScoreLabel.text = "\(counterForPlayerOne)"
        }
    }
    var counterForPlayerTwo: Int = 0 {
        didSet {
            playerTwoScoreLabel.text = "\(counterForPlayerTwo)"
        }
    }
    var countDownNum: Int = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        layoutViews()
    }
    
    // MARK: - Button Actions
    @objc func playerOneTappedButton(){
        guard isGameInProgress else { return }
        counterForPlayerOne += 1
    }
    
    @objc func playerTwoTappedButton(){
        guard isGameInProgress else { return }
        counterForPlayerTwo += 1
    }
    
    @objc func startGamePressed() {
        startTheGameWithCountDown()
    }
    
}///End of  GameHomeViewController


// MARK: - LayoutViews
extension GameHomeViewController {
    
    func layoutViews() {
        
        //PlayerOneButton
        view.addSubview(playerOneButton)
        playerOneButton.setDimensions(
            height: playerButtonHeight,
            width: playerButtonHeight
        )
        playerOneButton.centerX(inView: view)
        playerOneButton.anchor(
            bottom: view.bottomAnchor,
            paddingBottom: view.frame.height * 0.15
        )
        playerOneButton.layer.cornerRadius = playerButtonHeight / 2.0
        
        //PlayerTwoButton
        view.addSubview(playerTwoButton)
        playerTwoButton.setDimensions(
            height: playerButtonHeight,
            width: playerButtonHeight
        )
        playerTwoButton.centerX(inView: view)
        playerTwoButton.anchor(
            top: view.topAnchor,
            paddingTop: view.frame.height * 0.15
        )
        playerTwoButton.layer.cornerRadius = playerButtonHeight / 2.0
        
        //hide buttons in begining
        playerOneButton.isHidden = true
        playerTwoButton.isHidden = true
        
        //TimerLabel
        view.addSubview(timerLabel)
        timerLabel.centerY(inView: view)
        timerLabel.anchor(left: view.leftAnchor, paddingLeft: 0)
        timerLabel.transform = timerLabel.transform.rotated(by: -0.5 * CGFloat.pi)
        timerLabel.setDimensions(height: 80, width: 220)
        
        //playerOneScoreLabel
        view.addSubview(playerOneScoreLabel)
        playerOneScoreLabel.setDimensions(height: 50, width: 130)
        playerOneScoreLabel.centerY(inView: view, constant: 50)
        playerOneScoreLabel.anchor( right: view.rightAnchor, paddingRight: 50)
        playerOneScoreLabel.text = ""
        
        //playTwoScoreLabel
        view.addSubview(playerTwoScoreLabel)
        playerTwoScoreLabel.setDimensions(height: 50, width: 130)
        playerTwoScoreLabel.centerY(inView: view, constant: -50)
        playerTwoScoreLabel.anchor( right: view.rightAnchor, paddingRight: 50)
        playerTwoScoreLabel.transform = playerTwoScoreLabel.transform.rotated(by: -1 * CGFloat.pi)
        playerTwoScoreLabel.text = ""
        
        view.addSubview(startButton)
        startButton.setDimensions(height: 60, width: 80)
        startButton.centerX(inView: view)
        startButton.centerY(inView: view)
        startButton.tintColor = .green
        
    }///End of  Layout views
    
    
}///End of  extension

// MARK: - Helpers
extension GameHomeViewController {
    
    func startTheGameWithCountDown() {
        guard subscriptions.isEmpty else { return }
        
        resetGameStatus()

        isGameInProgress = true
        createTimerPublisher()
            .sink { [weak self] _ in
                self?.countDownNum -= 1
                self?.timerLabel.text = "\(self?.countDownNum ?? 0) secs"
                if self?.countDownNum == 0 {
                    self?.isGameInProgress = false
                    self?.subscriptions.removeAll()
                    self?.displayResult()
                }
                
            }///End of  sink
            .store(in: &subscriptions)

    }///End of func
    
    func resetGameStatus() {
        countDownNum = countDownFrom
        timerLabel.text = "\(countDownNum) secs"
        counterForPlayerOne = 0
        counterForPlayerTwo = 0
    }
    
    func displayResult() {
        switch (counterForPlayerOne, counterForPlayerTwo) {
        case let (a , b) where a > b :
            timerLabel.text = "Player 1 Won"
        case let (a , b) where a < b :
            timerLabel.text = "Player 2 Won"
        case let (a , b) where a == b :
            timerLabel.text = "DRAW"
        default:
            break
        }
    }
    
    func createTimerPublisher() -> AnyPublisher<Date,Never> {
        return Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .eraseToAnyPublisher()
    }
    
}///End of  GameHomeViewController
