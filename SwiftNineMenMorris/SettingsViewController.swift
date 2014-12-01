//
//  SettingsViewController.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-30.
//  Copyright (c) 2014 kj. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var flySwitch: UISwitch!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBAction func backButton(sender: AnyObject) {
        //println("\(flySwitch.on)")
                
        
        //performSegueWithIdentifier("unwindToMenu", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
}
