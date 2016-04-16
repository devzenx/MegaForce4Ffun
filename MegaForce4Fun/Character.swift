//
//  Character.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 16/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation
import UIKit

class Character {
    
// PROPERTIES
    
    var _name: String
    var _hp: Int
    var _shieldCount: Int
    var _charBattleBg: UIImage
    var _charBattleGround: UIImage
    

// COMPUTED PROPERTIES
    
    var name: String {
        get {
            return _name
        }
    }
    
    var hp: Int {
        get {
            return _hp
        }
        set(newValue) {
            return _hp = newValue
        }
    }
    
    var shieldCount: Int {
        get {
            return _shieldCount
        }
        
        set(newValue) {
            return _shieldCount = newValue
        }
    }
    
    var charBattleBg: UIImage {
        get {
            return _charBattleBg
        }
    }
    
    var charBattleGround: UIImage {
        get {
            return _charBattleGround
        }
    }
    
    
// INITIALIZER
    
    init(){
    self._name = "Default"
    self._hp = 4
    self._shieldCount = 0
    self._charBattleBg = UIImage (named:"bgBlueBattle.png")!
    self._charBattleGround = UIImage (named:"bgBlueGround.png")!
    }
    
    
// METHODS
    
}