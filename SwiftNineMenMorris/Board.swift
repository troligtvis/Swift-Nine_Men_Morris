//
//  Board.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-01.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import UIKit

class Board: NSObject, NSCoding {
    
    var tiles: [Tile] = []
    
    init(tileCount: Int, tileSize: Float){
        super.init()
        
        for var i = 0; i < tileCount; ++i {
            tiles.append(Tile(name: "piece\(i).png", state: State.empty))
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.tiles = aDecoder.decodeObjectForKey("tiles") as [Tile]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.tiles, forKey: "tiles")
    }
    
}// Board