//
//  Protoman.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 16/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation
import UIKit

class Protoman: Character {
    
    override var name: String {
        return "Protoman"
    }
    
    override var charBattleBg: UIImage {
        return UIImage (named:"bgRedBattle.png")!
    }
    
    override var charBattleGround: UIImage {
        return UIImage (named:"bgRedGround.png")!
    }
}