//
//  Saved.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-30.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import CoreData

class Saved: NSManagedObject {

    @NSManaged var player1pieces: NSNumber
    @NSManaged var player2pieces: NSNumber
    @NSManaged var positionsStatus: NSData
    @NSManaged var positions: NSData

}
