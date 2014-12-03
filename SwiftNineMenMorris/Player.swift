//
//  Player.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-01.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import UIKit

class Player: NSObject, NSCoding{

    var playerColor: String!
    var pieces: [Piece] = []
    var score: Int!
    var turn: Bool!
    
    init(color: String, p: Int){
        super.init()
        
        playerColor = color
        generatePieces(p)
        score = p
        
        turn = false
    }
    
    func generatePieces(p: Int){
        for var i = 0; i < p; ++i {
            pieces.append(Piece(o: -1, p: -1, name: playerColor, i: i))
            pieces[i].multipleTouchEnabled = true
            pieces[i].userInteractionEnabled = true
        }
    }// generatePieces
    
    
    required init(coder aDecoder: NSCoder) {
        self.playerColor = aDecoder.decodeObjectForKey("playerColor") as String
        self.pieces = aDecoder.decodeObjectForKey("pieces") as [Piece]
        self.score = aDecoder.decodeIntegerForKey("score")
        self.turn = aDecoder.decodeBoolForKey("turn")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.playerColor, forKey: "playerColor")
        aCoder.encodeObject(self.pieces, forKey: "pieces")
        aCoder.encodeInteger(self.score, forKey: "score")
        aCoder.encodeBool(self.turn, forKey: "turn")
    }
    
    
}// Player