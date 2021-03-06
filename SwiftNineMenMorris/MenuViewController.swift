//
//  MenuViewController.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-30.
//  Copyright (c) 2014 kj. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
    
    var coreDataStack: CoreDataStack!
    var saveDataHandler: SaveDataHandler!
    var settingsDataHandler: SettingsDataHandler!
    
    var isFly: Bool = true
    var pieces: Int = 9
    var isPlayMusic: Bool = true
    var isFromLoad: Bool = false
    
    var playerArray: [Player]! = []
    var boardArray: [Board]! = []
    var tileArray: [Tile]! = []
    var piece1Array: [Piece]! = []
    var piece2Array: [Piece]! = []
    
    var isSave: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
   
        clearArrays()
        
    }
    
    @IBAction func loadBtn(sender: AnyObject) {
        loadData()

        var titleOnAlert = "Load Game"
        var messageOnAlert = ""
        if !isFromLoad{
            messageOnAlert = "No saved games found!"
        }
        
        let alertController = UIAlertController(title: titleOnAlert, message: messageOnAlert, preferredStyle: .Alert)
        
        let loadAction = UIAlertAction(title: "Load", style: .Destructive) { (action) in
            // Handle save & quit
            println(action)
            
            self.performSegueWithIdentifier("gameSegue", sender: nil)
        }
        
        if isFromLoad {
            alertController.addAction(loadAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // Do nothing
            self.isFromLoad = false
        }
        alertController.addAction(cancelAction)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func saveData(){
        saveDataHandler.saveData("Saved", player: playerArray, board: boardArray, coreDataStack: coreDataStack)
        saveDataHandler.savePiecesAndTiles("PieceEntity", p2: "Piece2Entity", tile: "TileEntity", pieces1: piece1Array, pieces2: piece2Array, tiles: tileArray, coreDataStack: coreDataStack)
        
        clearArrays()
    }
    
    func clearArrays(){
        piece1Array.removeAll(keepCapacity: false)
        piece2Array.removeAll(keepCapacity: false)
        tileArray.removeAll(keepCapacity: false)
        piece1Array = []
        piece2Array = []
        tileArray = []
    }
    
    func loadData(){
        var returnObjects = saveDataHandler.loadData("Saved", coreDataStack: coreDataStack)
        
        if !returnObjects.wasEmpty{
            playerArray = returnObjects.pb
            boardArray = returnObjects.bb

            clearArrays()
            
            var returnObjects2 = saveDataHandler.loadTilesAndPieces("PieceEntity", player2: "Piece2Entity", tile: "TileEntity", coreDataStack: coreDataStack)
            piece1Array = returnObjects2.p1
            piece2Array = returnObjects2.p2
            tileArray = returnObjects2.t
            
            isFromLoad = true
        }
        
        println("loadData: \(isFromLoad)")
    }

    // Passing data to the ViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settingsSegue" {
            if let navController = segue.destinationViewController as? UINavigationController {
                if let settingsViewController = navController.topViewController as? SettingsViewController {
                    println("Segue to settingsviewcontroller")
                }
            }
        } else if segue.identifier == "gameSegue" {
            //println("pieces: \(pieces) fly: \(isFly) music: \(isPlayMusic)")
            
            if let navController = segue.destinationViewController as? UINavigationController {
                if let viewController = navController.topViewController as? ViewController{
                    println("Segue to viewcontroller")
                    viewController.markers = pieces
                    viewController.isPlayMusic = isPlayMusic
                    viewController.isFly = isFly
                    
                    viewController.isFromLoad = isFromLoad
                    isFromLoad = false
                    viewController.boardArray = boardArray
                    viewController.playerArray = playerArray
                
                    viewController.piece1Array = piece1Array
                    viewController.piece2Array = piece2Array
                    viewController.tileArray = tileArray
                }
            }
        }
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        if let settingsViewController = segue.sourceViewController as? SettingsViewController {
            println("Coming from settings")
            
            if settingsViewController.flySwitch.on{
                isFly = true
                println("fly on")
            } else {
                isFly = false
                println("fly off")
            }
            
            
            if settingsViewController.musicSwitch.on{
                isPlayMusic = true
                println("music on")
            } else {
                isPlayMusic = false
                println("music off")
            }
            
            switch settingsViewController.segment.selectedSegmentIndex {
                case 0:
                    pieces = 3
                    break;
                case 1:
                    pieces = 6
                    break;
                case 2:
                    pieces = 9
                    break;
                default:
                    pieces = 9 // If something went wrong. 9 by default.
                    break;
            }
            
            /*
            Async.background{

            } // Nothing to update...
            */
            println("Pieces: \(pieces) Fly: \(isFly)")
        }
        
        if let viewController = segue.sourceViewController as? ViewController {
            println("Coming from game")
            
            if isSave.boolValue {
                
                var t1 = piece1Array
                var t2 = piece2Array
                var t3 = tileArray
                clearArrays()
                piece1Array = t1
                piece2Array = t2
                tileArray = t3
                saveData()
            }
        }
    }
}
