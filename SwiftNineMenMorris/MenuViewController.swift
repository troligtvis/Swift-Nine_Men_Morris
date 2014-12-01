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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
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
        }
    }
}
