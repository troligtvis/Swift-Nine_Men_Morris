//
//  ViewController.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-11-27.
//  Copyright (c) 2014 kj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gridCell: [UIImageView] = []
    var marker: [UIImageView] = []
    
    var p1: [UIImageView] = []
    var p2: [UIImageView] = []
    
    var cellX: [CGFloat] = []
    var cellY: [CGFloat] = []
    
    var background: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var cellWidth: CGFloat = 40.0
    var cellHeight: CGFloat = 40.0
    var squares = 49
    var markers = 9
    
    var p1markers = 9
    var p2markers = 9
    
    var leftX: CGFloat = 100.0
    var topY: CGFloat = 100.0
    
    var which: Int!
    
    var whichX: CGFloat!
    var whichY: CGFloat!
    
    
    var markerX: [CGFloat] = []
    var markerY: [CGFloat] = []
    
    
    var isP1turn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var row = 0
        var col = 0
        
        isP1turn = true
        
        // Set background with an image
        background = UIImageView(image: UIImage(named: "Background"))
        background.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(background)
        
        
        infoLabel.text = "Player 1's turn"
        self.view.addSubview(infoLabel)
        
        leftX = self.view.frame.width/9
     
        cellWidth = self.view.frame.width/9
        cellHeight = cellWidth
        
        topY = (cellWidth * 8) / 2
        
        println("cell: \(cellWidth)")
        
        
        for var i = 0; i < squares; ++i {
           
            gridCell.append(UIImageView(image: UIImage(named: "piece\(i).png")))
            
            gridCell[i].frame = CGRectMake((leftX + (cellWidth * CGFloat(col))), (topY + (cellHeight * CGFloat(row))), CGFloat(cellWidth), CGFloat(cellHeight))
            
            cellX.append(gridCell[i].center.x)
            cellY.append(gridCell[i].center.y)
            
            self.view.addSubview(gridCell[i])

            col += 1
            if col > 6 {
                row += 1
                col = 0
            }
        }
        
        
        // Creating player 1
        row = 0
        col = 0
        
        for var i = 0; i < markers ; ++i {
            p1.append(UIImageView(image: UIImage(named: "Green")))
            p1[i].hidden = false
            p1[i].frame = CGRectMake((leftX + (cellWidth * CGFloat(col))), cellY[squares-1] + ( cellHeight + (cellHeight * CGFloat(row))), cellWidth, cellHeight)
            
            col += 1
            if col > 2 {
                row += 1
                col = 0
            }
            self.view.addSubview(p1[i])
            
            p1[i].userInteractionEnabled = true
            p1[i].multipleTouchEnabled = true
        }
        
        
        // Creating player 2
        col = 0
        row = 0
        
        for var i = 0; i < markers ; ++i {
            p2.append(UIImageView(image: UIImage(named: "Red")))
            p2[i].hidden = false
            p2[i].frame = CGRectMake((cellWidth * 5 + (cellWidth * CGFloat(col))), cellY[squares-1] + ( cellHeight + (cellHeight * CGFloat(row))), cellWidth, cellHeight)
            
            col += 1
            if col > 2 {
                row += 1
                col = 0
            }
            self.view.addSubview(p2[i])
            
            p2[i].userInteractionEnabled = true
            p2[i].multipleTouchEnabled = true
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var touch = touches.anyObject() as UITouch
        var point = touch.locationInView(self.view)
        
        if isP1turn.boolValue {
            marker = p1
        } else {
            marker = p2
        }
        
        which = 0
        for var i = 0 ; i < markers ; ++i {
            if touch.view == marker[i] {
                whichX = marker[i].center.x
                whichY = marker[i].center.y
                
                marker[i].center = point
                which = i
            }
        }
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        var titleOnAlert = "Back to menu"
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
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        
        let location = touch.locationInView(self.view)
        for var i = 0 ; i < markers ; ++i {
            if touch.view == marker[i] {
                marker[i].center = location
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        
        var min = CGFloat(cellWidth) * CGFloat(cellWidth) * 2.0
        var closest = 0
        var dSquared: CGFloat = 0.0
        var dX: CGFloat!
        var dY: CGFloat!
        
        if which >= 0 {
            if ((marker[which].center.x > CGFloat(leftX)) &&
                (marker[which].center.x < CGFloat(leftX) + 7.5 * CGFloat(cellWidth)) &&
                (marker[which].center.y > CGFloat(topY)) &&
                (marker[which].center.y < CGFloat(topY) + 7.5 * CGFloat(cellHeight))) {
                    
                    dX = marker[which].center.x - cellX[1]
                    dY = marker[which].center.y - cellY[1]
                    
                    min = dX * dX + dY * dY + 1.0
                    
                    for var i = 0; i < squares; ++i {
                        dX = marker[which].center.x - cellX[i]
                        dY = marker[which].center.y - cellY[i]
                        
                        dSquared = dX * dX + dY * dY
                        
                        if dSquared < min {
                            min = dSquared
                            closest = i
                        }
                    }
                    
                    if checkIfOk(closest){
                        marker[which].center = CGPointMake(cellX[closest], cellY[closest])
                        
                        if isP1turn.boolValue {
                            isP1turn = false
                            infoLabel.text = "Player 2's turn"
                        } else {
                            isP1turn = true
                            infoLabel.text = "Player 1's turn"
                        }
                        
                    } else {
                        marker[which].center = CGPointMake(whichX, whichY)
                    }
                    
                    println("Places \(which) on square \(closest)")
            }
        }
    }
    
    func checkIfOk(s: Int) -> Bool{
        if s == 0 || s == 3 || s == 6 {
            return true
        }
        
        if s == 8 || s == 10 || s == 12 {
            return true
        }
        
        if s == 16 || s == 17 || s == 18 {
            return true
        }
        
        if s == 21 || s == 22 || s == 23 || s == 25 || s == 26 || s == 27 {
            return true
        }
        
        if s == 30 || s == 31 || s == 32 {
            return true
        }
        
        if s == 36 || s == 38 || s == 40 {
            return true
        }
        
        if s == 42 || s == 45 || s == 48 {
            return true
        }
        
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

