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
    
    func checkIfDataExist(name: String, coreDataStack: CoreDataStack) -> Bool{
        let fetchRequest = NSFetchRequest(entityName: name)
        
        var error: NSError?
        let count = coreDataStack.context.countForFetchRequest(fetchRequest, error: &error)
        
        if count == NSNotFound {
            println("Could not fethc \(error), \(error!.userInfo)")
        }
        
        if count > 0{
            return true
        } else {
            return false
        }
    }
    
    //func saveData(name: String, playerBinary: [NSData], boardBinary: [NSData], coreDataStack: CoreDataStack){
    func saveData(name: String, player: [Player], board: [Board], coreDataStack: CoreDataStack){
        if checkIfDataExist(name, coreDataStack: coreDataStack){
            
            let batchUpdate = NSBatchUpdateRequest(entityName: name)
            
            batchUpdate.propertiesToUpdate = ["player1" : player[0] as Player]
            batchUpdate.propertiesToUpdate = ["player2" : player[1] as Player]
            batchUpdate.propertiesToUpdate = ["board" : board[0] as Board]
            batchUpdate.affectedStores = coreDataStack.psc.persistentStores
            batchUpdate.resultType = .UpdatedObjectsCountResultType
            
            var batchError: NSError?
            let batchResult = coreDataStack.context.executeRequest(batchUpdate, error: &batchError) as NSBatchUpdateResult?
            
            if let result = batchResult{
                println("Records updates \(result.result!)")
            } else {
                println("Could not update \(batchError), \(batchError!.userInfo)")
            }
        } else {
            let savedEntity = NSEntityDescription.entityForName(name, inManagedObjectContext: coreDataStack.context)
            
            let saved = Saved(entity: savedEntity!, insertIntoManagedObjectContext: coreDataStack.context)
            
            saved.player1 = player[0] as Player
            saved.player2 = player[1] as Player
            saved.board = board[0] as Board
            
            coreDataStack.saveContext()
        }
    }
    
    //func loadData(name: String, coreDataStack: CoreDataStack) -> (pb: [NSData], bb: [NSData], wasEmpty: Bool){
    func loadData(name: String, coreDataStack: CoreDataStack) -> (pb: [Player], bb: [Board], wasEmpty: Bool){
        var stemp: [Saved]! = []
        var bb: [Board]! = []
        var pb: [Player]! = []
        var wasEmpty: Bool = true
        
        if checkIfDataExist(name, coreDataStack: coreDataStack) {
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
            
            wasEmpty = false
        }
        
        return (pb, bb, wasEmpty)
    }
    
}
