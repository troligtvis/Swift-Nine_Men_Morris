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
    case unknown = 0, p1occ, p2occ, empty
}



class Tile{
    var tileState: State!
    var imageName: String!
    var image: UIImageView!
    
    init(name: String) {
        imageName = name
        tileState = State.empty
        
        image = UIImageView(image: UIImage(named: name))
    }
}