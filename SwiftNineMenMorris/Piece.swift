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
    var id: Int!
    var moveAble: Bool!
    var removeAble: Bool!
    
    init(o: Int, p: Int, name: String, i: Int) {
        super.init()
        
        oldPos = o
        newPos = p
        imageName = name
        id = i
        moveAble = true
        removeAble = false
        self.image = UIImage(named: name)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}// Piece