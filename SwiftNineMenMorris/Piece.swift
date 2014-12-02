//
//  Piece.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-02.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import UIKit

class Piece: UIImageView{
    
    var oldPos: Int!
    var newPos: Int!
    var imageName: String!
    
    init(o: Int, p: Int, name: String) {
        super.init()
        
        oldPos = o
        newPos = p
        imageName = name
        self.image = UIImage(named: name)
        //image = UIImageView(image: UIImage(named: name))
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}