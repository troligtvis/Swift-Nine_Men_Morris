//
//  Board.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-01.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation



class Board {
    
    var tiles: [Tile] = []
    
    init(tileCount: Int, tileSize: Float){
        for var i = 0; i < tileCount; ++i {
            tiles.append(Tile(name: "piece\(i).png"))
        }
    }
}