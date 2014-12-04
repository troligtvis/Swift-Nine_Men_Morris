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
    var tX: [CGFloat] = []
    var tY: [CGFloat] = []
    
    var tileX: [CGFloat] = []
    var tileY: [CGFloat] = []
    
    var totalMarkers: Int!
    var isRemove: Bool!
    
    var state: [CGFloat] = []
    
    var isFly: Bool!
    var isPlayMusic: Bool!
    var markers: Int!
    
    init(tileCount: Int, tileSize: Float){
        super.init()
        
        for var i = 0; i < tileCount; ++i {
            tiles.append(Tile(name: "piece\(i).png", state: State.empty))
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.tiles = aDecoder.decodeObjectForKey("tiles") as [Tile]
        self.tileX = aDecoder.decodeObjectForKey("tileX") as [CGFloat]
        self.tileY = aDecoder.decodeObjectForKey("tileY") as [CGFloat]
        self.tX = aDecoder.decodeObjectForKey("tX") as [CGFloat]
        self.tY = aDecoder.decodeObjectForKey("tY") as [CGFloat]
        self.totalMarkers = aDecoder.decodeIntegerForKey("totalMarkers")
        self.isRemove = aDecoder.decodeBoolForKey("isRemove")
        
        self.isFly = aDecoder.decodeBoolForKey("isFly")
        self.isPlayMusic = aDecoder.decodeBoolForKey("isPlayMusic")
        self.markers = aDecoder.decodeIntegerForKey("markers")
        
        self.state = aDecoder.decodeObjectForKey("state") as [CGFloat]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.tiles, forKey: "tiles")
        aCoder.encodeObject(self.tileX, forKey: "tileX")
        aCoder.encodeObject(self.tileY, forKey: "tileY")
        aCoder.encodeObject(self.tX, forKey: "tX")
        aCoder.encodeObject(self.tY, forKey: "tY")
        aCoder.encodeInteger(self.totalMarkers, forKey: "totalMarkers")
        aCoder.encodeBool(self.isRemove, forKey: "isRemove")
        
        aCoder.encodeBool(self.isFly, forKey: "isFly")
        aCoder.encodeBool(self.isPlayMusic, forKey: "isPlayMusic")
        aCoder.encodeInteger(self.markers, forKey: "markers")
        
        aCoder.encodeObject(self.state, forKey: "state")
    }
    
}// Board