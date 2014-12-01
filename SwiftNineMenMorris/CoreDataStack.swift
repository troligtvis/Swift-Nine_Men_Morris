//
//  CoreDataStack.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-30.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack{
    var context: NSManagedObjectContext
    var psc: NSPersistentStoreCoordinator
    var model: NSManagedObjectModel
    var store: NSPersistentStore?
    
    init(){
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("SwiftNineMenMorris", withExtension:"momd")
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        psc = NSPersistentStoreCoordinator(managedObjectModel:model)
        
        context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        
        let documentsURL = applicationDocumentsDirectory()
        let storeURL = documentsURL.URLByAppendingPathComponent("SwiftNineMenMorris")
        
        let options = [NSMigratePersistentStoresAutomaticallyOption: true]
        
        var error: NSError? = nil
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType,
            configuration: nil,
            URL: storeURL,
            options: options,
            error:&error)
        
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
    }
    
    func saveContext() {
        
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            println("Could not save: \(error), \(error?.userInfo)")
        }
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory,
            inDomains: .UserDomainMask) as Array<NSURL>
        
        return urls[0]
    }
}
