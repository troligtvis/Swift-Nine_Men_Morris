//
//  Rules.swift
//  SwiftNineMenMorris
//
//  Created by Kj Drougge on 2014-12-02.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation

class Rules{
    
   // var state: [State]! = []
    
    func checkIfOk(s: Int) -> Bool{
       // if state[s] != State.empty.rawValue{
         //   return false
        //} else {
            
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
       // }
        return false
    }// checkIfOk
    
    func checkFly(from: Int, to: Int , s: State)->Bool{
        /*if from == -1 && s == State.empty {
            return checkIfOk(to)
        }*/
        
        if s != State.empty {
            return false
        }
        
        if(from == to){
            return true
        }
        
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
    }// checkFly
    
    func checkIfMill(p: Int, r: State, s: [Tile]) -> Bool{
        
        if(p == 0 && ((s[3].tileState == r  && s[6].tileState == r) || (s[21].tileState == r && s[42].tileState == r))){
            return true
        }
        if(p == 3 && ((s[0].tileState == r && s[6].tileState == r ) || (s[10].tileState == r && s[17].tileState == r))){
            return true
        }
        if(p == 6 && ((s[0].tileState == r && s[3].tileState == r) || (s[27].tileState == r && s[48].tileState == r))){
            return true
        }
        if(p == 8 && ((s[10].tileState == r && s[12].tileState == r) || (s[22].tileState == r && s[36].tileState == r))){
            return true
        }
        if(p == 10 && ((s[3].tileState == r && s[17].tileState == r) || (s[8].tileState == r && s[12].tileState == r))){
            return true
        }
        if(p == 12 && ((s[8].tileState == r && s[10].tileState == r) || (s[26].tileState == r && s[40].tileState == r))){
            return true
        }
        if(p == 16 && ((s[17].tileState == r && s[18].tileState == r) || (s[23].tileState == r && s[30].tileState == r))){
            return true
        }
        if(p == 17 && ((s[3].tileState == r && s[10].tileState == r) || (s[16].tileState == r && s[18].tileState == r))){
            return true
        }
        if(p == 18 && ((s[25].tileState == r && s[32].tileState == r) || (s[16].tileState == r && s[17].tileState == r))){
            return true
        }
        if(p == 21 && ((s[22].tileState == r && s[23].tileState == r) || (s[0].tileState == r && s[42].tileState == r))){
            return true
        }
        if(p == 22 && ((s[21].tileState == r && s[23].tileState == r) || (s[8].tileState == r && s[36].tileState == r))){
            return true
        }
        if(p == 23 && ((s[21].tileState == r && s[22].tileState == r) || (s[16].tileState == r && s[30].tileState == r))){
            return true
        }
        if(p == 25 && ((s[26].tileState == r && s[27].tileState == r) || (s[18].tileState == r && s[32].tileState == r))){
            return true
        }
        if(p == 26 && ((s[25].tileState == r && s[27].tileState == r) || (s[12].tileState == r && s[40].tileState == r))){
            return true
        }
        if(p == 27 && ((s[25].tileState == r && s[26].tileState == r) || (s[6].tileState == r && s[48].tileState == r))){
            return true
        }
        if(p == 30 && ((s[31].tileState == r && s[32].tileState == r) || (s[16].tileState == r && s[23].tileState == r))){
            return true
        }
        if(p == 31 && ((s[30].tileState == r && s[32].tileState == r) || (s[38].tileState == r && s[45].tileState == r))){
            return true
        }
        if(p == 32 && ((s[30].tileState == r && s[31].tileState == r) || (s[18].tileState == r && s[25].tileState == r))){
            return true
        }
        if(p == 36 && ((s[8].tileState == r && s[22].tileState == r) || (s[38].tileState == r && s[40].tileState == r))){
            return true
        }
        if(p == 38 && ((s[31].tileState == r && s[45].tileState == r) || (s[36].tileState == r && s[40].tileState == r))){
            return true
        }
        if(p == 40 && ((s[12].tileState == r && s[26].tileState == r) || (s[36].tileState == r && s[38].tileState == r))){
            return true
        }
        if(p == 42 && ((s[0].tileState == r && s[21].tileState == r) || (s[45].tileState == r && s[48].tileState == r))){
            return true
        }
        if(p == 45 && ((s[31].tileState == r && s[38].tileState == r) || (s[42].tileState == r && s[48].tileState == r))){
            return true
        }
        if(p == 48 && ((s[6].tileState == r && s[27].tileState == r) || (s[42].tileState == r && s[45].tileState == r))){
            return true
        }
        
        return false
        
        
    }// checkIfMill
    
    
    /*
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
    }// checkIfMiller
*/

    
}// Rules