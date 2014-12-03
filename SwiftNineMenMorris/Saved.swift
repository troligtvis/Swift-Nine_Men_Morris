//
//  Saved.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-03.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import CoreData

class Saved: NSManagedObject {

    @NSManaged var player1: AnyObject
    @NSManaged var board: AnyObject
    @NSManaged var player2: AnyObject

}
