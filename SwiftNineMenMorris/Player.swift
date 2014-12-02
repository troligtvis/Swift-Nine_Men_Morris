//
//  Player.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-01.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation

class Player{
    
    var playerColor: String!
    var pieces: [Piece] = []
    
    init(color: String, p: Int){
        playerColor = color
        
        generatePieces(p)
        
    }
    
    func generatePieces(p: Int){
        for var i = 0; i < p; ++i {
            pieces.append(Piece(o: -1, p: 0, name: playerColor))
            pieces[i].userInteractionEnabled = true
            pieces[i].multipleTouchEnabled = true
        }
    }
    
}