//
//  Piece.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-02.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation

class Piece{
    
    var isMoveable: Bool!
    var imageName: String!
    
    func pieceInit(n: String, m: Bool){
        isMoveable = m
        imageName = n
    }
    
}