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
    
    var playerArray: [Player]! = []
    var boardArray: [Board]! = []
    var piece1Array: [Piece]! = []
    var piece2Array: [Piece]! = []
    var tileArray: [Tile]! = []
    
    // Player 1
    var player1: Player!
    
    // Player 2
    var player2: Player!
    
    var totalMarkers: Int!
    
    var which: CGPoint!
    
    var turn: String!
    var waiting: String!
    
    // Settings
    var markers: Int!
    var isFly: Bool!
    var isFromLoad: Bool!
    
    // Audio
    var audioPlayer: AVAudioPlayer!
    var isPlayMusic: Bool!
    
    var rules: Rules! = Rules()
    var isRemove: Bool! = false
    var isGameOver: Bool!
    
    var isSave: Bool!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        tileWidth = self.view.frame.width/9
        tileHeight = self.view.frame.width/9
        leftX = self.view.frame.width/9
        topY = (tileWidth * 8) / 2
        
        if isFromLoad.boolValue {
            board = boardArray[0]
            player1 = playerArray[0]
            player2 = playerArray[1]
            
            initBoardFromLoad()
            
            if player1.turn.boolValue {
                turn = player1.playerColor
                waiting = player2.playerColor
            } else {
                turn = player2.playerColor
                waiting = player1.playerColor
            }
            
            
            
            infoLabel.text = "\(turn)s turn!"
            
        } else {
            initBoard()
            initPlayer("Green", m: markers)
            initPlayer("Red", m: markers)
        }
        
        playMusic(isPlayMusic)
        
    }// viewDidLoad
    
    func initBoardFromLoad(){
        
        board.tiles = tileArray
        player1.pieces = piece1Array
        player2.pieces = piece2Array
        
        tileX = board.tileX
        tileY = board.tileY
        
        isFly = board.isFly
        isPlayMusic = board.isPlayMusic
        markers = board.markers
        
        totalMarkers = board.totalMarkers
        
        println("tile:\(tileCount) board:\(board.tiles.count)")
        
        for var i = 0; i < tileCount; ++i{
            
            switch board.state[i]{
            case 1:
                board.tiles[i].tileState = State.Green
                break
            case 2:
                board.tiles[i].tileState = State.Red
                break
            case 3:
                board.tiles[i].tileState = State.empty
                break
            default:
                break
            }
            
            
            board.tiles[i].image = UIImageView(image: UIImage(named: "piece\(i).png"))
            board.tiles[i].image.frame = CGRect(x: board.tX[i], y: board.tY[i], width: tileWidth, height: tileHeight)
            
            self.view.addSubview(board.tiles[i].image)
        }
        
        for var i = 0; i < player1.pieces.count; ++i{
            player1.pieces[i].image = UIImage(named: "Green")
            if !player1.pieces[i].isRemoved.boolValue{
                println("pieces1: \(i) pos: \(player1.pieces[i].newPos) re:\(player1.pieces[i].isRemoved)")
                println("mov: \(player1.pieces[i].moveAble)")
                
                player1.pieces[i].frame = CGRectMake(tileX[player1.pieces[i].newPos], tileY[player1.pieces[i].newPos], tileWidth , tileHeight)
                player1.pieces[i].center = CGPointMake(tileX[player1.pieces[i].newPos], tileY[player1.pieces[i].newPos])
                
                self.view.addSubview(player1.pieces[i])
            }
        }
    
        for var i = 0; i < player2.pieces.count; ++i{
            player2.pieces[i].image = UIImage(named: "Red")
            if !player2.pieces[i].isRemoved.boolValue{
                println("pieces2: \(i) pos: \(player2.pieces[i].newPos) re:\(player2.pieces[i].isRemoved)")
                println("mov: \(player2.pieces[i].moveAble)")
                
                player2.pieces[i].frame = CGRectMake(tileX[player2.pieces[i].newPos], tileY[player2.pieces[i].newPos], tileWidth , tileHeight)
                player2.pieces[i].center = CGPointMake(tileX[player2.pieces[i].newPos], tileY[player2.pieces[i].newPos])
                self.view.addSubview(player2.pieces[i])
            }
        }
    }
    
    func initBoard(){
        
        board = Board(tileCount: tileCount, tileSize: Float(tileWidth))
        board.isFly = isFly
        board.isPlayMusic = isPlayMusic
        board.markers = markers
        
        var col = 0, row = 0
        for var i = 0; i < tileCount; ++i{
            
            var x = (leftX + (tileWidth * CGFloat(col)))
            var y = (topY + (tileHeight * CGFloat(row)))
            var height = CGFloat(tileWidth)
            var width = CGFloat(tileHeight)
            
            var t = board.tiles[i].image
            
            t.frame = CGRectMake(x, y, height, width)
            //println("\(t.frame)")
            tileX.append(t.center.x)
            tileY.append(t.center.y)
            
            board.tX.append(x)
            board.tY.append(y)
            
            self.view.addSubview(t)
            
            col += 1
            if col > 6{
                row += 1
                col = 0
            }
        }
        
        board.tileX = tileX
        board.tileY = tileY
        
        turn = "Green"
        waiting = "Red"
        isRemove = false
        totalMarkers = 2 * markers
    
        
        board.isRemove = isRemove
        
        setInfoLabel("\(turn)s turn")
        
    }// initBoard
    
    func initPlayer(name: String, m: Int){
        if name == "Green" {
            player1 = Player(color: name, p: m)
        } else {
            player2 = Player(color: name, p: m)
        }
        
        var col = 0, row = 0
        for var i = 0; i < m; ++i {
            var p: UIImageView!
            
            if name == "Green" {
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
    
    func setInfoLabel(s: String){
        infoLabel.text = s
    }// setInfoLabel
    
    @IBAction func backBtn(sender: AnyObject) {
        var titleOnAlert = ""
        var messageOnAlert = "What to do?"
        
        let alertController = UIAlertController(title: titleOnAlert, message: messageOnAlert, preferredStyle: .Alert)
        
        let quitAction = UIAlertAction(title: "Quit", style: .Default) { (action) in
            // Handle save & quit
            //println(action)
            self.isSave = false
            
            self.performSegueWithIdentifier("toMainFromGame", sender: nil)
        }
        alertController.addAction(quitAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // Do nothing
            println(action)
        }
        alertController.addAction(cancelAction)
    
        let saveAndQuitAction = UIAlertAction(title: "Save & Quit", style: .Destructive) { (action) in
            // Handle save & quit
            
            //println("player1: \(player1.score) player2: \(player2.score)")
            self.isSave = true
            //println(action)
            
            
            
            self.performSegueWithIdentifier("toMainFromGame", sender: nil)
        }
        alertController.addAction(saveAndQuitAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }// backBtn
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMainFromGame" {
            var mv = segue.destinationViewController as MenuViewController
            
            println("Sending back: \(playerArray)")
            println("Sending back -> player1: \(player1.score) player2: \(player2.score)")
            
            if isSave.boolValue {
                
                if turn == player1.playerColor {
                    player1.turn = true
                    player2.turn = false
                } else {
                    player1.turn = false
                    player2.turn = true
                }
                
                board.totalMarkers = totalMarkers
                for var i = 0; i < tileCount; ++i{
                    //println("state: \(board.tiles[i].tileState.rawValue)")
                    board.state.append(CGFloat(board.tiles[i].tileState.rawValue))
                }
                
                playerArray.append(player1)
                playerArray.append(player2)
                boardArray.append(board)
                
                tileArray.removeAll(keepCapacity: false)
                tileArray = []
                piece1Array.removeAll(keepCapacity: false)
                piece1Array = []
                piece2Array.removeAll(keepCapacity: false)
                piece2Array = []
                
                for var i = 0; i < tileCount; ++i {
                    tileArray.append(board.tiles[i])
                }
                
                for var i = 0; i < player1.pieces.count; ++i{
                    piece1Array.append(player1.pieces[i])
                }
                
                for var i = 0; i < player2.pieces.count; ++i {
                    piece2Array.append(player2.pieces[i])
                }
                
                //mv.isSave = isSave
                mv.boardArray = boardArray
                mv.playerArray = playerArray
                mv.tileArray = tileArray
                mv.piece1Array = piece1Array
                mv.piece2Array = piece2Array
            }
            mv.isSave = isSave
        }
    }
    
    func gameCameToAnEnd(winner: String){
        
        
        var titleOnAlert = "Game Over"
        var messageOnAlert = "\(winner) won!"
        
        let alertController = UIAlertController(title: titleOnAlert, message: messageOnAlert, preferredStyle: .Alert)
        
        let destroyAction = UIAlertAction(title: "Quit", style: .Destructive) { (action) in
            // Handle save & quit
            println(action)
            
            self.performSegueWithIdentifier("toMainFromGame", sender: nil)
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)

        
    }// gameCameToAnEnd
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var point = touch.locationInView(self.view)
        
        if let m = touch.view as? Piece{
            if !isRemove {
                which = m.center
            } else {
                if ((m.imageName == waiting) && (m.removeAble)) {
                    m.removeFromSuperview()
                    m.isRemoved = true
                    
                    if (waiting == "Green"){
                        player1.score = player1.score - 1
                    } else {
                        player2.score = player2.score - 1
                    }
                    
                    board.tiles[m.newPos].tileState = State.empty
                    
                    var t = turn
                    turn = waiting
                    waiting = t
                    
                    setInfoLabel("\(turn)s turn")
                    
                    isRemove = false
                    
                    if player1.score == 2 || player2.score == 2{
                        isSave = false
                        gameCameToAnEnd(t)
                    }
                }
            }
        }
    }// touchesBegan
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        let location = touch.locationInView(self.view)
        
        if let m = touch.view as? Piece{
            if m.moveAble.boolValue && m.imageName == turn { // Change this to turn <-----
                m.center = location
            }
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
                    if m.moveAble.boolValue{
                        closest = findClosest(m.center)
                       
                        if rules.checkIfOk(closest){
                            println("\((m.newPos == -1 && board.tiles[closest].tileState == State.empty))")
                            if (m.newPos == -1 && board.tiles[closest].tileState == State.empty) {
                                m.newPos = closest
                            }
                            
                            if rules.checkFly(m.newPos, to: closest , s: board.tiles[closest].tileState){
                                
                                    board.tiles[m.newPos].tileState = State.empty
                                
                                    m.newPos = closest
                                    m.oldPos = 1
                                    m.center = CGPointMake(tileX[closest], tileY[closest])
                                    
                                    if "Green" == turn{
                                        board.tiles[closest].tileState = State.Green
                                    } else {
                                        board.tiles[closest].tileState = State.Red
                                    }
                                
                                
                                    if rules.checkIfMill(m.newPos, r:board.tiles[closest].tileState , s: board.tiles){
                                        setInfoLabel("\(turn) got MILLER!")
                                        isRemove = true
                                    } else {
                                        var t = turn
                                        turn = waiting
                                        waiting = t
                                        
                                        setInfoLabel("\(turn)s turn")
                                    }
                                    
                                    if totalMarkers > 0{
                                        totalMarkers = totalMarkers - 1
                                        m.moveAble = false
                                        m.removeAble = true
                                        if totalMarkers == 0{
                                            for var i = 0; i < markers; ++i {
                                                player1.pieces[i].moveAble = true
                                                player2.pieces[i].moveAble = true
                                            }
                                        }
                                    }
                                } else {
                                    m.center = which
                                }
                        } else {
                            m.center = which
                        }
                    }
            } else {
                m.center = which
            }
        }
        
        //println("player1: \(player1.score) player2: \(player2.score)")
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
    
}// ViewController

