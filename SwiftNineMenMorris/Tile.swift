//
//  Tile.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-01.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import UIKit


enum State: Int {
    case unknown = 0, green, red, empty
}

class Tile: NSObject, NSCoding{
    var tileState: State!
    var imageName: String!
    var image: UIImageView!
    
    init(name: String, state: State) {
        super.init()
        
        imageName = name
        tileState = state
        
        image = UIImageView(image: UIImage(named: name))
    }
    
    
    required init(coder aDecoder: NSCoder) {
        self.tileState = State(rawValue: (aDecoder.decodeObjectForKey("tileState") as Int))
        self.imageName = aDecoder.decodeObjectForKey("imageName") as String
        self.image = aDecoder.decodeObjectForKey("image") as UIImageView
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.tileState.rawValue, forKey: "tileState")
        aCoder.encodeObject(self.imageName, forKey: "imageName")
        aCoder.encodeObject(self.image, forKey: "image")
    }
    
}// Tile