//
//  ViewController.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-27.
//  Copyright (c) 2014 kj. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var board: Board!
    var tileCount: Int = 49
    var tileHeight: CGFloat!
    var tileWidth: CGFloat!
    
    var tileX: [CGFloat] = []
    var tileY: [CGFloat] = []
    
    var topY: CGFloat!
    var leftX: CGFloat!
    
    // Player 1
    var player1: Player!
    
    // Player 2
    var player2: Player!
    
    // Settings
    var markers: Int!
    var isPlayMusic: Bool!
    var isFly: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initBoard()
        
        initPlayer(player1, name: "green", m: markers)
        initPlayer(player2, name: "red", m: markers)
    }
    
    func initBoard(){
        tileWidth = self.view.frame.width/9
        tileHeight = self.view.frame.width/9
        leftX = self.view.frame.width/9
        topY = (tileWidth * 8) / 2
        
        board = Board(tileCount: tileCount, tileSize: 57)
        var col = 0, row = 0
        for var i = 0; i < tileCount; ++i{
            var t = board.tiles[i].image
            t.frame = CGRectMake((leftX + (tileWidth * CGFloat(col))), (topY + (tileHeight * CGFloat(row))), CGFloat(tileWidth), CGFloat(tileHeight))
            tileX.append(t.center.x)
            tileY.append(t.center.y)
            
            self.view.addSubview(t)
            
            col += 1
            if col > 6{
                row += 1
                col = 0
            }
        }
    }
    
    func initPlayer(player: Player, name: String, m: Int){
        
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        var titleOnAlert = ""
        var messageOnAlert = "What to do?"
        
        let alertController = UIAlertController(title: titleOnAlert, message: messageOnAlert, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // Do nothing
            println(action)
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Save & Quit", style: .Destructive) { (action) in
            // Handle save & quit
            println(action)
            
            self.performSegueWithIdentifier("toMainFromGame", sender: nil)
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var point = touch.locationInView(self.view)
        
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        let location = touch.locationInView(self.view)

        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
    }
}

