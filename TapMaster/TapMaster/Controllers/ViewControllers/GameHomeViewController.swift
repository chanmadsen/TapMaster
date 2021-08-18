//
//  GameHomeViewController.swift
//  TapMaster
//
//  Created by lijia xu on 8/18/21.
//

import UIKit

class GameHomeViewController: UIViewController {
    
    // MARK: - Views
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
    
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = "TIMER"
    
        return label
    }()
    
    
    private lazy var playerOneScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        
        label.backgroundColor = .red
        
        return label
    }()
    
    private lazy var playerTwoScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        
        label.backgroundColor = .blue
        
        return label
    }()

    // MARK: - Properties
    var playerOneScores: Int?
    var playerTwoScores: Int?
    
    let playerButtonHeight: CGFloat = 150
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        layoutViews()
    }
    
    // MARK: - Button Actions
    
    @objc func playerOneTappedButton(){
        print("tapped 1")
    }
    
    @objc func playerTwoTappedButton(){
        print("tapped 2")
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
        
        //TimerLabel
        view.addSubview(timerLabel)
        timerLabel.centerY(inView: view)
        timerLabel.setDimensions(height: 80, width: 150)
        timerLabel.anchor(left: view.leftAnchor, paddingLeft: 5)
        timerLabel.transform = timerLabel.transform.rotated(by: -0.5 * CGFloat.pi)
        
        //playerOneScoreLabel
        view.addSubview(playerOneScoreLabel)
        playerOneScoreLabel.setDimensions(height: 50, width: 130)
        playerOneScoreLabel.centerY(inView: view, constant: 50)
        playerOneScoreLabel.anchor( right: view.rightAnchor, paddingRight: 50)
        
        //playTwoScoreLabel
        view.addSubview(playerTwoScoreLabel)
        playerTwoScoreLabel.setDimensions(height: 50, width: 130)
        playerTwoScoreLabel.centerY(inView: view, constant: -50)
        playerTwoScoreLabel.anchor( right: view.rightAnchor, paddingRight: 50)
        
        
    }///End of  Layout views
    
    
}///End of  extension
