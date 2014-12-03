//
//  SaveDataHandler.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-30.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import CoreData

class SaveDataHandler: NSObject{
    
    func checkIfDataExist(name: String, coreDataStack: CoreDataStack, checkValue: Int) -> Bool{
        let fetchRequest = NSFetchRequest(entityName: name)
        
        var error: NSError?
        let count = coreDataStack.context.countForFetchRequest(fetchRequest, error: &error)
        
        if count == NSNotFound {
            println("Could not fethc \(error), \(error!.userInfo)")
        }
        
        if count > checkValue{
            return true
        } else {
            return false
        }
    }
    
    //func saveData(name: String, playerBinary: [NSData], boardBinary: [NSData], coreDataStack: CoreDataStack){
    func saveData(name: String, player: [Player], board: [Board], coreDataStack: CoreDataStack){
        if checkIfDataExist(name, coreDataStack: coreDataStack, checkValue: 0){
            
            println("Deleting data")
            let fetchRequest = NSFetchRequest(entityName: name)
            var error: NSError? = nil
            
            let resultscount = coreDataStack.context.countForFetchRequest(fetchRequest, error: &error)
            
            if resultscount != 0 {
                
                var fetchError: NSError? = nil
                let results = coreDataStack.context.executeFetchRequest(fetchRequest, error: &fetchError)
                
                for object in results!{
                    let oldSave = object as Saved
                    coreDataStack.context.deleteObject(oldSave)
                }
                
                coreDataStack.saveContext()
            }
        }
        
        println("Saving data")
        let savedEntity = NSEntityDescription.entityForName(name, inManagedObjectContext: coreDataStack.context)
        
        let saved = Saved(entity: savedEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        saved.player1 = player[0] as Player
        saved.player2 = player[1] as Player
        saved.board = board[0] as Board
        
        coreDataStack.saveContext()
    }
    
    //func loadData(name: String, coreDataStack: CoreDataStack) -> (pb: [NSData], bb: [NSData], wasEmpty: Bool){
    func loadData(name: String, coreDataStack: CoreDataStack) -> (pb: [Player], bb: [Board], wasEmpty: Bool){
        var bb: [Board]! = []
        var pb: [Player]! = []
        var wasEmpty: Bool = true
        
        if checkIfDataExist(name, coreDataStack: coreDataStack, checkValue: 0) {
            println("Data Exist")
            var fetchRequest = NSFetchRequest(entityName: name)
            
            var error: NSError?
            
            let results = coreDataStack.context.executeFetchRequest(fetchRequest, error: &error)
            
            for object in results! {
                let t = object as Saved
                bb.append(t.board as Board)
                pb.append(t.player1 as Player)
                pb.append(t.player2 as Player)
            }
            
            println("hit")
            
            wasEmpty = false
        }
        
        return (pb, bb, wasEmpty)
    }
    
    
    func savePiecesAndTiles(p1: String, p2: String, tile: String, pieces1: [Piece], pieces2: [Piece], tiles: [Tile], coreDataStack: CoreDataStack){
        
        if checkIfDataExist(p1, coreDataStack: coreDataStack, checkValue: 0){
            println("Deleting data")
            let fetchRequest1 = NSFetchRequest(entityName: p1)
            var error1: NSError? = nil
            
            let resultscount1 = coreDataStack.context.countForFetchRequest(fetchRequest1, error: &error1)
            
            if resultscount1 != 0 {
                
                var fetchError1: NSError? = nil
                let results1 = coreDataStack.context.executeFetchRequest(fetchRequest1, error: &fetchError1)
                
                for object in results1!{
                    let oldSave = object as PieceEntity
                    coreDataStack.context.deleteObject(oldSave)
                }
                
                coreDataStack.saveContext()
            }
        }
        
        println("Saving data pieces1: \(pieces1.count)")
        
        
        for var i = 0; i < pieces1.count; ++i {
            let piece1Entity = NSEntityDescription.entityForName(p1, inManagedObjectContext: coreDataStack.context)
            
            let piece1 = PieceEntity(entity: piece1Entity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            piece1.piece = pieces1[i] as Piece
        }

        coreDataStack.saveContext()
        
        
        if checkIfDataExist(p2, coreDataStack: coreDataStack, checkValue: 0){
            println("Deleting data")
            let fetchRequest2 = NSFetchRequest(entityName: p2)
            var error2: NSError? = nil
            
            let resultscount2 = coreDataStack.context.countForFetchRequest(fetchRequest2, error: &error2)
            
            if resultscount2 != 0 {
                
                var fetchError2: NSError? = nil
                let results2 = coreDataStack.context.executeFetchRequest(fetchRequest2, error: &fetchError2)
                
                for object in results2!{
                    let oldSave = object as Piece2Entity
                    coreDataStack.context.deleteObject(oldSave)
                }
                
                coreDataStack.saveContext()
            }
        }
        
        println("Saving data pieces2: \(pieces2.count)")
        
        
        for var i = 0; i < pieces2.count; ++i {
            let piece2Entity = NSEntityDescription.entityForName(p2, inManagedObjectContext: coreDataStack.context)
            
            let piece2 = Piece2Entity(entity: piece2Entity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            piece2.piece = pieces2[i] as Piece
        }
        
        coreDataStack.saveContext()
        
        
        if checkIfDataExist(tile, coreDataStack: coreDataStack, checkValue: 0){
            println("Deleting data")
            let fetchRequest3 = NSFetchRequest(entityName: tile)
            var error3: NSError? = nil
            
            let resultscount3 = coreDataStack.context.countForFetchRequest(fetchRequest3, error: &error3)
            
            if resultscount3 != 0 {
                
                var fetchError3: NSError? = nil
                let results3 = coreDataStack.context.executeFetchRequest(fetchRequest3, error: &fetchError3)
                
                for object in results3!{
                    let oldSave = object as TileEntity
                    coreDataStack.context.deleteObject(oldSave)
                }
                
                coreDataStack.saveContext()
            }
        }
        
        println("Saving data tile :\(tiles.count)")
        
        
        for var i = 0; i < tiles.count; ++i {
            let tileEntity = NSEntityDescription.entityForName(tile, inManagedObjectContext: coreDataStack.context)
            
            let t = TileEntity(entity: tileEntity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            t.tile = tiles[i] as Tile
        }
        
        coreDataStack.saveContext()
    }
    
    func loadTilesAndPieces(player1: String, player2: String, tile: String, coreDataStack: CoreDataStack) -> (p1: [Piece], p2: [Piece], t: [Tile]){
        var p1: [Piece]! = []
        var p2: [Piece]! = []
        var t: [Tile]! = []
        
        if checkIfDataExist(player1, coreDataStack: coreDataStack, checkValue: 0) {
            
            var fetchRequest1 = NSFetchRequest(entityName: player1)
            
            var error1: NSError?
            
            let results1 = coreDataStack.context.executeFetchRequest(fetchRequest1, error: &error1)
            
            for object in results1! {
                let q = object as PieceEntity
                p1.append(q.piece as Piece)
            }
            println("Load pieces1: \(p1.count)")
        }
        
        if checkIfDataExist(player2, coreDataStack: coreDataStack, checkValue: 0) {
            
            var fetchRequest2 = NSFetchRequest(entityName: player2)
            
            var error2: NSError?
            
            let results2 = coreDataStack.context.executeFetchRequest(fetchRequest2, error: &error2)
            
            for object in results2! {
                let q = object as Piece2Entity
                p2.append(q.piece as Piece)
            }
            println("Load pieces2: \(p2.count)")
        }
        
        if checkIfDataExist(tile, coreDataStack: coreDataStack, checkValue: 0) {
            
            var fetchRequest3 = NSFetchRequest(entityName: tile)
            
            var error3: NSError?
            
            let results3 = coreDataStack.context.executeFetchRequest(fetchRequest3, error: &error3)
            
            for object in results3! {
                let q = object as TileEntity
                t.append(q.tile as Tile)
            }
            println("Load tiles: \(t.count)")
        }
        
        return (p1, p2, t)

    }
}
