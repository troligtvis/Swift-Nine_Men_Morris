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
    
    var isFly: Bool!
    var pieces: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let settingsViewController = segue.sourceViewController as? SettingsViewController {
            println("segue to settingsviewcontroller")
        } else if let viewController = segue.sourceViewController as? ViewController {
            println("segue to viewcontroller")
        }
        
    }
    
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        if let settingsViewController = segue.sourceViewController as? SettingsViewController {
            println("Coming from settings")
            
            if settingsViewController.flySwitch.on{
                isFly = true
                println("on")
            } else {
                isFly = false
                println("off")
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
