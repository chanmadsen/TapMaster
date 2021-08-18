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
    var timer: Timer
    
    
    
    init(playerOneScore: Int, playerTwoScore: Int, timer: Timer = Timer()){
        self.playerOneScore = playerOneScore
        self.playerTwoScore = playerTwoScore
        self.timer = timer
        
        
    }
}//End of class
