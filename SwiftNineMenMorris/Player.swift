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
    
    var pieceNotOnBoardPosX: [CGFloat]! = []
    var pieceNotOnBoardPosY: [CGFloat]! = []
    
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
        self.pieceNotOnBoardPosX = aDecoder.decodeObjectForKey("pieceNotOnBoardPosX") as [CGFloat]
        self.pieceNotOnBoardPosY = aDecoder.decodeObjectForKey("pieceNotOnBoardPosY") as [CGFloat]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.playerColor, forKey: "playerColor")
        aCoder.encodeObject(self.pieces, forKey: "pieces")
        aCoder.encodeInteger(self.score, forKey: "score")
        aCoder.encodeBool(self.turn, forKey: "turn")
        aCoder.encodeObject(self.pieceNotOnBoardPosX, forKey: "pieceNotOnBoardPosX")
        aCoder.encodeObject(self.pieceNotOnBoardPosY, forKey: "pieceNotOnBoardPosY")
    }
    
    
}// Player