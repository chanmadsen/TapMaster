//
//  TapMaster.swift
//  TapMaster
//
//  Created by Lon Chandler Madsen on 8/18/21.
//

import Foundation

class TapMaster {
    
    var playerOneScore: Int
    var playerTwoScore: Int
    var counterNumber: Int
    var timer: Timer
    
    
    
    init(playerOneScore: Int, playerTwoScore: Int, counterNumber: Int, timer: Timer){
        self.playerOneScore = playerOneScore
        self.playerTwoScore = playerTwoScore
        self.counterNumber = counterNumber
        self.timer = timer
        
    }
}//End of class
