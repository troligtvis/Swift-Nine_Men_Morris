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
    
    var turn: String!
    
    // Settings
    var markers: Int!
    var isPlayMusic: Bool!
    var isFly: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initBoard()
        
        initPlayer("green", m: markers)
        initPlayer("red", m: markers)
    }// viewDidLoad
    
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
    }// initBoard
    
    func initPlayer(name: String, m: Int){
        if name == "green" {
            player1 = Player(color: name, p: m)
        } else {
            player2 = Player(color: name, p: m)
        }
        
        var col = 0, row = 0
        for var i = 0; i < m; ++i {
            var p: UIImageView!
            
            if name == "green" {
                p = player1.pieces[i]
                p.frame = CGRectMake((leftX + (tileWidth * CGFloat(col))), tileY[tileCount-1] + ( tileHeight + (tileHeight * CGFloat(row))), tileWidth, tileHeight)
                
            } else {
                p = player2.pieces[i]
                p.frame = CGRectMake((tileWidth * 5 + (tileWidth * CGFloat(col))), tileY[tileCount-1] + ( tileHeight + (tileHeight * CGFloat(row))), tileWidth, tileHeight)
            }

            col += 1
            if col > 2{
                row += 1
                col = 0
            }
            
            self.view.addSubview(p)
        }
        
    }// initPlayer
    
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
        
    }// backBtn
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var point = touch.locationInView(self.view)

        if let m = touch.view as? Piece{
            
        }
    }// touchesBegan
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        let location = touch.locationInView(self.view)

        if let m = touch.view as? Piece{
            m.center = location
        }
    }// touchesMoved
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        
        var closest: Int!
        
        if let m = touch.view as? Piece{
            if ((m.center.x > CGFloat(leftX)) &&
                (m.center.x < CGFloat(leftX) + 7.5 * CGFloat(tileWidth)) &&
                (m.center.y > CGFloat(topY)) &&
                (m.center.y < CGFloat(topY) + 7.5 * CGFloat(tileHeight))) {
                
                 closest = findClosest(m.center)
                 m.center = CGPointMake(tileX[closest], tileY[closest])
            }
        }
    }// touchesEnded
    
    func findClosest(p: CGPoint) -> Int{
        var min = CGFloat(tileWidth) * CGFloat(tileWidth) * 2.0
        var closest = 0
        var dSquared: CGFloat = 0.0
        var dX: CGFloat!
        var dY: CGFloat!
        
        dX = p.x - tileX[1]
        dY = p.y - tileY[1]
        
        min = dX * dX + dY * dY + 1.0
        
        for var i = 0; i < tileCount; ++i {
            dX = p.x - tileX[i]
            dY = p.y - tileY[i]
            
            dSquared = dX * dX + dY * dY
            
            if dSquared < min {
                min = dSquared
                closest = i
            }
        }
        
        return closest
    }// findClosest

}

