//
//  Kladd.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-02.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation



class Kladd: UIViewController {
    
    var gridCell: [UIImageView] = []
    var marker: [UIImageView] = []
    
    var state: [Int] = []
    
    var p1: [UIImageView] = []
    var p2: [UIImageView] = []
    
    var p1OnBoard: [UIImageView] = []
    var p2OnBoard: [UIImageView] = []
    
    
    var cellX: [CGFloat] = []
    var cellY: [CGFloat] = []
    
    var background: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    // Sizes and amount of squares
    var cellWidth: CGFloat = 40.0
    var cellHeight: CGFloat = 40.0
    var squares = 49
    
    var leftX: CGFloat = 100.0
    var topY: CGFloat = 100.0
    
    
    // Markers
    var markers: Int!
    
    var p1markers: Int!
    var p2markers: Int!
    var p1markers2: Int!
    var p2markers2: Int!
    
    var totalMarkers: Int!
    
    var which: Int!
    var whichX: CGFloat!
    var whichY: CGFloat!
    
    var firstMove: Int!
    var closest: Int!
    var oldClosest: Int!
    
    var closestp1: Int!
    var closestp2: Int!
    
    var markerX: [CGFloat] = []
    var markerY: [CGFloat] = []
    
    
    var isP1turn: Bool!
    var isFly: Bool!
    
    var isRemove: Bool!
    
    var phase1: Bool!
    
    // Audio
    var audioPlayer: AVAudioPlayer!
    var isPlayMusic: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstMove = 0
        closest = 0
        oldClosest = 0
        
        var row = 0
        var col = 0
        
        println("markers: \(markers) music: \(isPlayMusic) fly: \(isFly)")
        
        p1markers = markers
        p2markers = markers
        
        p1markers2 = 0
        p2markers2 = 0
        
        isRemove = false
        phase1 = true
        
        totalMarkers = markers * 2
        
        //playMusic(isPlayMusic!)
        
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
        
        for var i = 0; i < squares; ++i {
            
            gridCell.append(UIImageView(image: UIImage(named: "piece\(i).png")))
            
            gridCell[i].frame = CGRectMake((leftX + (cellWidth * CGFloat(col))), (topY + (cellHeight * CGFloat(row))), CGFloat(cellWidth), CGFloat(cellHeight))
            
            
            
            cellX.append(gridCell[i].center.x)
            cellY.append(gridCell[i].center.y)
            
            // State
            state.append(State.empty.rawValue)
            
            self.view.addSubview(gridCell[i])
            
            col += 1
            if col > 6 {
                row += 1
                col = 0
            }
        }
        
        /*
        var z = Player(color: "Green", p: 3)
        println(z.pieces[0].image)
        var t = z.pieces[0].image
        z.pieces[0].newPos = 32
        
        t.frame = CGRectMake(0+(cellWidth * CGFloat(0)), 0, cellWidth, cellHeight)
        self.view.addSubview(t)
        */
        
        //var ps = Piece(o: -1, p: 0, name: "Green")
        
        //self.view.addSubview(ps.image)
        
        // Creating player 1
        row = 0
        col = 0
        
        for var i = 0; i < markers ; ++i {
            p1.append(UIImageView(image: UIImage(named: "Green")))
            //p1[i].hidden = false
            p1[i].frame = CGRectMake((leftX + (cellWidth * CGFloat(col))), cellY[squares-1] + ( cellHeight + (cellHeight * CGFloat(row))), cellWidth, cellHeight)
            
            //p1[i].frame = CGRectMake(0+(cellWidth * CGFloat(col)), 0, cellWidth, cellHeight)
            
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
            //p2[i].hidden = false
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
        
        if isP1turn.boolValue {
            
            if !isRemove.boolValue {
                
                if (p1markers != 0){
                    marker = p1
                    markers = p1.count
                } else {
                    marker = p1OnBoard
                    markers = p1OnBoard.count
                }
            } else {
                println("remove from p2")
                marker = p2OnBoard
                markers = p2OnBoard.count
            }
        } else {
            if !isRemove.boolValue {
                if (p2markers != 0){
                    marker = p2
                    markers = p2.count
                } else {
                    marker = p2OnBoard
                    markers = p2OnBoard.count
                }
            } else {
                println("remove from p1")
                marker = p1OnBoard
                markers = p1OnBoard.count
            }
        }
        
        var closest = 0
        which = -1
        
        for var i = 0 ; i < markers ; ++i {
            if touch.view == marker[i] {
                
                whichX = marker[i].center.x
                whichY = marker[i].center.y
                
                marker[i].center = point
                which = i
                
                if isRemove.boolValue {
                    if isP1turn.boolValue {
                        p2OnBoard[i].removeFromSuperview()
                        p2OnBoard.removeAtIndex(i)
                        p2markers2 = p2OnBoard.count
                        isP1turn = false
                        isRemove = false
                        infoLabel.text = "Player 2's turn"
                        
                    } else {
                        p1OnBoard[i].removeFromSuperview()
                        p1OnBoard.removeAtIndex(i)
                        p1markers2 = p1OnBoard.count
                        isP1turn = true
                        isRemove = false
                        infoLabel.text = "Player 1's turn"
                        
                    }
                    
                    state[findClosest()] = State.empty.rawValue
                }
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        
        let location = touch.locationInView(self.view)
        if !isRemove.boolValue {
            if isP1turn.boolValue {
                if (p1markers != 0){
                    marker = p1
                    markers = p1markers
                } else {
                    marker = p1OnBoard
                    markers = p1markers2
                }
            } else {
                if (p2markers != 0){
                    marker = p2
                    markers = p2markers
                } else {
                    marker = p2OnBoard
                    markers = p2markers2
                }
            }
            
            for var i = 0 ; i < markers ; ++i {
                if touch.view == marker[i] {
                    marker[i].center = location
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        
        if isP1turn.boolValue {
            if (p1markers != 0){
                marker = p1
                markers = p1markers
            } else {
                //closest = closestp1
                marker = p1OnBoard
                markers = p1markers2
            }
        } else {
            if (p2markers != 0){
                marker = p2
                markers = p2markers
            } else {
                //closest = closestp2
                marker = p2OnBoard
                markers = p2markers2
            }
        }
        
        if isRemove.boolValue {
            println("Just a removing operation going on. Nothing to do here")
        } else {
            
            if (which >= 0 ) {
                if ((marker[which].center.x > CGFloat(leftX)) &&
                    (marker[which].center.x < CGFloat(leftX) + 7.5 * CGFloat(cellWidth)) &&
                    (marker[which].center.y > CGFloat(topY)) &&
                    (marker[which].center.y < CGFloat(topY) + 7.5 * CGFloat(cellHeight))) {
                        
                        if firstMove != 0 {
                            oldClosest = closest
                        }
                        
                        closest = findClosest()
                        
                        if p1markers == 0 && p2markers == 0 {
                            phase1 = false
                        }
                        
                        println("oldClosest:\(oldClosest) closest:\(closest)")
                        
                        if phase1.boolValue {
                            if checkIfOk(closest){
                                var oldState = state
                                
                                if isP1turn.boolValue {
                                    closestp1 = closest
                                    
                                    state[closest] = State.p1occ.rawValue
                                    if checkIfMill(State.p1occ.rawValue, pos: state, oldpos: oldState){
                                        infoLabel.text = "Player 1 MILLER!"
                                        isRemove = true
                                    } else {
                                        
                                        if (p1markers != 0){
                                            p1OnBoard.append(marker[which])
                                            p1.removeAtIndex(which)
                                            
                                            p1markers = p1.count
                                            p1markers2 = p1OnBoard.count
                                        } else {
                                            if firstMove != 0 {
                                                state[oldClosest] = State.empty.rawValue
                                            }
                                        }
                                        
                                        isP1turn = false
                                        infoLabel.text = "Player 2's turn"
                                    }
                                    
                                } else {
                                    closestp2 = closest
                                    
                                    state[closest] = State.p2occ.rawValue
                                    if checkIfMill(State.p2occ.rawValue, pos: state, oldpos: oldState){
                                        infoLabel.text = "Player 2 MILLER!"
                                        isRemove = true
                                    } else {
                                        
                                        if (p2markers != 0){
                                            p2OnBoard.append(marker[which])
                                            p2.removeAtIndex(which)
                                            
                                            p2markers = p2markers - 1
                                            p2markers2 = p2markers2 + 1
                                        } else {
                                            if firstMove != 0 {
                                                state[oldClosest] = State.empty.rawValue
                                            }
                                        }
                                        
                                        isP1turn = true
                                        infoLabel.text = "Player 1's turn"
                                    }
                                }
                                
                                firstMove = 1
                                
                                marker[which].center = CGPointMake(cellX[closest], cellY[closest])
                            } else {
                                marker[which].center = CGPointMake(whichX, whichY)
                            }
                        } else {
                            if checkFly(oldClosest, to: closest){
                                
                                var oldState = state
                                
                                if isP1turn.boolValue {
                                    println("fly p1: \(checkFly(oldClosest, to: closest))")
                                    
                                    state[oldClosest] = State.empty.rawValue
                                    state[closest] = State.p1occ.rawValue
                                    if checkIfMill(State.p1occ.rawValue, pos: state, oldpos: oldState){
                                        infoLabel.text = "Player 1 MILLER!"
                                        isRemove = true
                                    } else {
                                        
                                        isP1turn = false
                                        infoLabel.text = "Player 2's turn"
                                    }
                                    closestp1 = closest
                                } else {
                                    println("fly p2: \(checkFly(oldClosest, to: closest))")
                                    
                                    state[oldClosest] = State.empty.rawValue
                                    state[closest] = State.p2occ.rawValue
                                    if checkIfMill(State.p2occ.rawValue, pos: state, oldpos: oldState){
                                        infoLabel.text = "Player 2 MILLER!"
                                        isRemove = true
                                    } else {
                                        
                                        isP1turn = true
                                        infoLabel.text = "Player 1's turn"
                                    }
                                    closestp2 = closest
                                }
                                
                                marker[which].center = CGPointMake(cellX[closest], cellY[closest])
                            } else {
                                marker[which].center = CGPointMake(whichX, whichY)
                            }
                        }
                }
            }
        }
        
        //println("->  \(state)")
    }
    
    func findClosest() -> Int{
        var min = CGFloat(cellWidth) * CGFloat(cellWidth) * 2.0
        var closest = 0
        var dSquared: CGFloat = 0.0
        var dX: CGFloat!
        var dY: CGFloat!
        
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
        
        return closest
    }
    
    func playMusic(isPlayMusic: Bool){
        if isPlayMusic {
            var audioPath = NSString(string: NSBundle.mainBundle().pathForResource("Battleblock", ofType: "mp3")!)
            
            println(audioPath)
            
            var error : NSError? = nil
            self.audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
            
            if (self.audioPlayer == nil)
            {
                if let playerError = error as NSError!
                {
                    let des : String? = playerError.localizedDescription
                    println("Error: \(des)")
                }
            }
            else
            {
                self.audioPlayer.play()
            }
        } else {
            println("No music mr boring")
        }
    }
    
    func checkFly(from: Int, to: Int)->Bool{
        
        if(from == 0 && (to == 3 || to == 21)){
            return true;
        }
        if(from == 3 && (to == 0 || to == 6 || to == 10)){
            return true;
        }
        if(from == 6 && (to == 3 || to == 12)){
            return true;
        }
        if(from == 8 && (to == 22 || to == 10)){
            return true;
        }
        if(from == 10 && (to == 3 || to == 8) || to == 17 || to == 12){
            return true;
        }
        if(from == 12 && (to == 10 || to == 26)){
            return true;
        }
        if(from == 16 && (to == 17 || to == 23)){
            return true;
        }
        if(from == 17 && (to == 10 || to == 16 || to == 18)){
            return true;
        }
        if(from == 18 && (to == 17 || to == 25)){
            return true;
        }
        if(from == 21 && (to == 0 || to == 42 || to == 22)){
            return true;
        }
        if(from == 22 && (to == 21 || to == 8 || to == 23 || to == 36)){
            return true;
        }
        if(from == 23 && (to == 16 || to == 30 || to == 22)){
            return true;
        }
        if(from == 25 && (to == 18 || to == 32 || to == 26)){
            return true;
        }
        if(from == 26 && (to == 25 || to == 12 || to == 27 || to == 40)){
            return true;
        }
        if(from == 27 && (to == 26 || to == 6 || to == 48)){
            return true;
        }
        if(from == 30 && (to == 23 || to == 31)){
            return true;
        }
        if(from == 31 && (to == 30 || to == 32 || to == 38)){
            return true;
        }
        if(from == 32 && (to == 25 || to == 31)){
            return true;
        }
        if(from == 36 && (to == 22 || to == 38)){
            return true;
        }
        if(from == 38 && (to == 31 || to == 36 || to == 45 || to == 40)){
            return true;
        }
        if(from == 40 && (to == 26 || to == 38)){
            return true;
        }
        if(from == 42 && (to == 21 || to == 45)){
            return true;
        }
        if(from == 45 && (to == 42 || to == 38 || to == 48)){
            return true;
        }
        if(from == 48 && (to == 45 || to == 27)){
            return true;
        }
        
        return false;
    }
    
    func checkIfMill(p: Int, pos: [Int], oldpos: [Int]) -> Bool{
        
        if(pos[0] == p && pos[3] == p && pos[6] == p ) != (oldpos[0] == p && oldpos[3] == p && oldpos[6] == p ){
            return true
        } else if(pos[8] == p && pos[10] == p && pos[12] == p ) != (oldpos[8] == p && oldpos[10] == p && oldpos[12] == p ){
            return true
        } else if(pos[16] == p && pos[17] == p && pos[18] == p ) != (oldpos[16] == p && oldpos[17] == p && oldpos[18] == p ){
            return true
        } else if(pos[21] == p && pos[22] == p && pos[23] == p ) != (oldpos[21] == p && oldpos[22] == p && oldpos[23] == p ){
            return true
        } else if(pos[25] == p && pos[26] == p && pos[27] == p ) != (oldpos[25] == p && oldpos[26] == p && oldpos[27] == p ){
            return true
        } else if(pos[30] == p && pos[31] == p && pos[32] == p ) != (oldpos[30] == p && oldpos[31] == p && oldpos[32] == p ){
            return true
        } else if(pos[36] == p && pos[38] == p && pos[40] == p ) != (oldpos[36] == p && oldpos[38] == p && oldpos[40] == p ){
            return true
        } else if(pos[42] == p && pos[45] == p && pos[48] == p ) != (oldpos[42] == p && oldpos[45] == p && oldpos[48] == p ){
            return true
        } else if(pos[0] == p && pos[21] == p && pos[42] == p ) != (oldpos[0] == p && oldpos[21] == p && oldpos[42] == p ){
            return true
        } else if(pos[8] == p && pos[22] == p && pos[36] == p ) != (oldpos[8] == p && oldpos[22] == p && oldpos[36] == p ){
            return true
        } else if(pos[3] == p && pos[10] == p && pos[17] == p ) != (oldpos[3] == p && oldpos[10] == p && oldpos[17] == p ){
            return true
        } else if(pos[31] == p && pos[38] == p && pos[45] == p ) != (oldpos[31] == p && oldpos[38] == p && oldpos[45] == p ){
            return true
        } else if(pos[18] == p && pos[25] == p && pos[32] == p ) != (oldpos[18] == p && oldpos[25] == p && oldpos[32] == p ){
            return true
        } else if(pos[12] == p && pos[26] == p && pos[40] == p ) != (oldpos[12] == p && oldpos[26] == p && oldpos[40] == p ){
            return true
        } else if(pos[6] == p && pos[27] == p && pos[48] == p ) != (oldpos[6] == p && oldpos[27] == p && oldpos[48] == p ){
            return true
        }
        
        return false
    }
    
    func checkIfOk(s: Int) -> Bool{
        if state[s] != State.empty.rawValue{
            return false
        } else {
            
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
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


