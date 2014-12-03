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
    
    var isSave: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //self.loadData()
    }
    
    @IBAction func loadBtn(sender: AnyObject) {
        self.loadData()

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
            println(action)
        }
        alertController.addAction(cancelAction)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /*
    func createPlayerBinary(p: Player){
        var pb = PlayerBinary()
        pb.addPlayer(p)
        var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(pb)
        playerBinary.append(data)
    }
    
    func createBoardBinary(b: Board){
        var bb = BoardBinary()
        bb.addBoard(b)
        var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(bb)
        boardBinary.append(data)
    }
    
    func createPlayerFromBinary(pb: NSData){
        var z = Player(coder: NSCoder())
        
        var p: Player = NSKeyedUnarchiver.unarchiveObjectWithData(pb) as Player
        playerArray.append(p)
    }
    
    func createBoardFromBinary(bb: NSData){
        var b: Board = NSKeyedUnarchiver.unarchiveObjectWithData(bb) as Board
        boardArray.append(b)
    } */
    
    func saveData(){
        //createPlayerBinary(playerArray[0])
        //createPlayerBinary(playerArray[1])
        //createBoardBinary(boardArray[0])
        
 
        //println("pb:\(playerBinary) bb:\(boardBinary)")
        //println("c:\(coreDataStack)")
        
        //saveDataHandler.saveData("Saved", playerBinary: playerBinary, boardBinary: boardBinary, coreDataStack: coreDataStack)
        saveDataHandler.saveData("Saved", player: playerArray, board: boardArray, coreDataStack: coreDataStack)
    }
    
    func loadData(){
        var returnObjects = saveDataHandler.loadData("Saved", coreDataStack: coreDataStack)
        
        if !returnObjects.wasEmpty{
            //playerBinary = returnObjects.pb
            //boardBinary = returnObjects.bb
        
            //println("HIT")
            playerArray = returnObjects.pb
            boardArray = returnObjects.bb
            
            //createPlayerFromBinary(playerBinary[0])
            //createPlayerFromBinary(playerBinary[1])
            //createBoardFromBinary(boardBinary[0])
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
            
            Async.background{
                // Save settings.
            } // Nothing to update...
            
            println("Pieces: \(pieces) Fly: \(isFly)")
        }
        
        if let viewController = segue.sourceViewController as? ViewController {
            println("Coming from game")
            
            if isSave.boolValue {
                saveData()
            }
        }
    }
}
