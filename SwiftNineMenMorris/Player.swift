//
//  Player.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-01.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import UIKit

class Player{
    
    var playerColor: String!
    var pieces: [Piece] = []
    var score: Int!
    
    init(color: String, p: Int){
        playerColor = color
        generatePieces(p)
        score = p
    }
    
    func generatePieces(p: Int){
        for var i = 0; i < p; ++i {
            pieces.append(Piece(o: -1, p: -1, name: playerColor, i: i))
            pieces[i].multipleTouchEnabled = true
            pieces[i].userInteractionEnabled = true
        }
    }// generatePieces
    
}// Player