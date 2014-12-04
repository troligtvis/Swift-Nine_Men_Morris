//
//  SettingsDataHandler.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-30.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import CoreData

class SettingsDataHandler{
    
    /*
    func saveSettings(isFly: NSNumber, isMusic: NSNumber, pieces: Int, coreDataStack: CoreDataStack){
        deleteSettings(coreDataStack)
        
        let settingEntity = NSEntityDescription.entityForName("Setting", inManagedObjectContext: coreDataStack.context)
        let setting = Setting(entity: settingEntity!, insertIntoManagedObjectContext: coreDataStack.context)
        
        setting.isFly = isFly.boolValue
        setting.isMusic = isMusic.boolValue
        setting.pieces = pieces
        
        coreDataStack.saveContext()
        println("Saved settings")
    }
    
    func loadSettings(coreDataStack: CoreDataStack) -> (p1: Bool, p2: Bool, p3: Int){
        let settingsFetch = NSFetchRequest(entityName: "Setting")
        var error: NSError?
        
        var p1: Bool! = true
        var p2: Bool! = true
        var p3: Int! = 9
        
        let fetchedSettingsResults = coreDataStack.context.executeFetchRequest(settingsFetch, error: &error) as [Setting]?
        
        if let results = fetchedSettingsResults{
            
            println("Loading DB to local")
            //for var k = 0; k < results.count; ++k{
            p1 = results[0].isFly
            p2 = results[0].isMusic
            p3 = results[0].pieces
            //}
            println("Done loading DB to local")
        }
        return (p1, p2, p3)
    }
    
    func deleteSettings(coreDataStack: CoreDataStack){
        let settingFetch = NSFetchRequest(entityName: "Setting")
        var error: NSError?
        let fetchedSettingResults = coreDataStack.context.executeFetchRequest(settingFetch, error: &error) as [Setting]?
        
        if let results = fetchedSettingResults{
            for test in results{
                let ngt = test as Setting
                coreDataStack.context.deleteObject(ngt)
            }
            coreDataStack.saveContext()
        }
        println("deleted settings from DB")
    }
    
    func isSettingsEmpty(coreDataStack: CoreDataStack) -> Bool{
        let settingFetch = NSFetchRequest(entityName: "Setting")
        var error: NSError?
        let fetchedResults = coreDataStack.context.executeFetchRequest(settingFetch, error: &error) as [Setting]?
        let results = fetchedResults
        if let results = fetchedResults{
            if results.count < 1{
                println("DB is empty")
                return true
            }else{
                println("DB is not empty")
                return false
            }
        }
        return true
    }
*/
}