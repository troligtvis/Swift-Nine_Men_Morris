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
    
    var cellX: [CGFloat] = []
    var cellY: [CGFloat] = []
    
    
    // Must fix the sizes
    var cellWidth = 40
    var cellHeight = 40
    var squares = 49
    var markers = 24
    var leftX = 100/2
    var topY = 100/2
    
    var which: Int!
    
    var whichX: CGFloat!
    var whichY: CGFloat!
    
    
    var markerX: [CGFloat] = []
    var markerY: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var i = 0
        var row = 0
        var col = 0
        var firstColor = 0
        
        println(gridCell.capacity)
        println(marker.capacity)
        
        for var i = 0; i < squares; ++i {
            
            var x = (leftX + ( cellWidth * col))
            var y = (topY + ( cellHeight * row))
            
            if firstColor == 0 {
                gridCell.append(UIImageView(image: UIImage(named: "Black")))
            } else {
                gridCell.append(UIImageView(image: UIImage(named: "Red")))
            }
            
            
            /*
            marker.append(UIImageView(image: UIImage(named: "White")))
            marker[i].hidden = true
            */
            
            gridCell[i].frame = CGRectMake(CGFloat((leftX + (cellWidth * col))), CGFloat((topY + (cellHeight * row))), CGFloat(cellWidth), CGFloat(cellHeight))
            
            //marker[i].frame = CGRectMake(CGFloat((leftX + (cellWidth * col))), CGFloat((topY + (cellHeight * row))), CGFloat(cellWidth), CGFloat(cellHeight))
            
            
            cellX.append(gridCell[i].center.x)
            cellY.append(gridCell[i].center.y)
            
            if checkIfOk(i){
                self.view.addSubview(gridCell[i])
            }
            //self.view.addSubview(marker[i])
            
            col += 1
            firstColor = 1 - firstColor
            if col > 6 {
                row += 1
                //firstColor = 1 - firstColor
                col = 0
            }
            
            //gridCell[i].userInteractionEnabled = true
            //gridCell[i].multipleTouchEnabled = true
            
        }
        
        row = 0
        col = 0
        
        for var i = 0; i < markers ; ++i {
            marker.append(UIImageView(image: UIImage(named: "White")))
            marker[i].hidden = false
            marker[i].frame = CGRectMake(CGFloat((leftX + (cellWidth * col))), cellY[squares-1] + CGFloat(( cellHeight + (cellHeight * row))), CGFloat(cellWidth), CGFloat(cellHeight))
            
            
            
            col += 1
            if col > 6 {
                row += 1
                col = 0
            }
            self.view.addSubview(marker[i])
            
            marker[i].userInteractionEnabled = true
            marker[i].multipleTouchEnabled = true
        }
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var touch = touches.anyObject() as UITouch
        var point = touch.locationInView(self.view)
        
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
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        //self.touchesBegan(touches, withEvent: event)
        
        var touch = touches.anyObject() as UITouch
        
        //for touch in touches {
        let location = touch.locationInView(self.view)
        //let touchedNode = nodeAtPoint(location)
        //touchedNode.position = location
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

