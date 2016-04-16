//
//  Megaman.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 16/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation
import UIKit

class Megaman: Character {
    
    override var name: String {
        return "Megaman"
    }
    
    override var charBattleBg: UIImage {
        return UIImage (named:"bgBlueBattle.png")!
    }
    
    override var charBattleGround: UIImage {
        return UIImage (named:"bgBlueGround.png")!
    }
    
}
