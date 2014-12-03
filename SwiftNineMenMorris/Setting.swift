//
//  Setting.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-03.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import CoreData

class Setting: NSManagedObject {

    @NSManaged var isFly: NSNumber
    @NSManaged var pieces: NSNumber
    @NSManaged var isMusic: NSNumber

}
