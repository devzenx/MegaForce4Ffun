//
//  AnimImg.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 11/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation
import UIKit

class AnimImg: UIImageView {

    var originalPosition: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // ANIMATED BACKGROUNDS
    
    
    // Character selection default background
    func playPlayerSelectBg() {
        self.image = UIImage (named: "animCharSelect11.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...3 {
            let img = UIImage(named: "animCharSelect\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 5
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    // Restart screen ending movie
    func playRestartBg() {
        self.image = UIImage (named: "animEnding15.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...15 {
            let img = UIImage(named: "animEnding\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 15
        self.animationRepeatCount = 1
        self.startAnimating()
    }

    // Enemy introduction screen
    func playEnemyIntro() {
        self.image = UIImage (named: "animEnemyIntro1.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...16 {
            let img = UIImage(named: "animEnemyIntro\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 2
        self.animationRepeatCount = 0
        self.startAnimating()
    }

    

// ALL CHARACTERS ANIMATIONS

    
    //// Play Idle animation
    
    func playIdleAnim(name: String){
        
        if name == "Protoman" {
            self.image = UIImage (named: "animProtMIdle0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...5 {
                let img = UIImage(named: "animProtMIdle\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 1
                self.animationRepeatCount = 0
                self.startAnimating()
            }
            } else if name == "Megaman" {
            self.image = UIImage (named: "animMegaMIdle0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...6 {
                let img = UIImage(named: "animMegaMIdle\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 1.2
                self.animationRepeatCount = 0
                self.startAnimating()
            }
            } else {
            self.image = UIImage (named: "animAirMIdle0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...7 {
                let img = UIImage(named: "animAirMIdle\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 1.2
                self.animationRepeatCount = 0
                self.startAnimating()
            }

        }
    }
    
    
    //// Play Attack animation
    
    func playAttackAnim(name: String){
        
        if name == "Protoman" {
            self.image = UIImage (named: "animProtMAttack0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...5 {
                let img = UIImage(named: "animProtMAttack\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playProtMIdle), userInfo: nil, repeats: false)
            }
        } else if name == "Megaman" {
            self.image = UIImage (named: "animMegaMAttack0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...5 {
                let img = UIImage(named: "animMegaMAttack\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playMegaMIdle), userInfo: nil, repeats: false)
            }
        } else {
            self.image = UIImage (named: "animAirMAttack0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...6 {
                let img = UIImage(named: "animAirMAttack\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playAirMIdle), userInfo: nil, repeats: false)
            }
            
        }
    }
 
    //// Play Hurt animation   
    func playHurtAnim(name: String){
        
        if name == "Protoman" {
            self.image = UIImage (named: "animProtMHurt0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...2 {
                let img = UIImage(named: "animProtMHurt\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playProtMIdle), userInfo: nil, repeats: false)
            }
        } else if name == "Megaman" {
            self.image = UIImage (named: "animMegaMHurt0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...4 {
                let img = UIImage(named: "animMegaMHurt\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playMegaMIdle), userInfo: nil, repeats: false)
            }
        } else {
            self.image = UIImage (named: "animAirMHurt0.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...3 {
                let img = UIImage(named: "animAirMHurt\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playAirMIdle), userInfo: nil, repeats: false)
            }
            
        }
    }
    
    //// Play Win animation   
    func playWinAnim(name: String){
        
        if name == "Protoman" {
            self.image = UIImage (named: "animProtMWinA3.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...3 {
                let img = UIImage(named: "animProtMWinA\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playWinProtMBAnim), userInfo: nil, repeats: false)
            }
        } else if name == "Megaman" {
            self.image = UIImage (named: "animMegaMWin4.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...4 {
                let img = UIImage(named: "animMegaMWin\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 0.5
                self.animationRepeatCount = 1
                self.startAnimating()
            }
        } else {
            self.image = UIImage (named: "animAirMWin1.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...6 {
                let img = UIImage(named: "animAirMWin\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 1
                self.animationRepeatCount = 0
                self.startAnimating()
            }
            
        }
    }
    
    //// Play Lose animation
    func playLoseAnim(name: String){
        
        if name == "Protoman" {
            self.image = UIImage (named: "animProtMLoseA2.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...2 {
                let img = UIImage(named: "animProtMLoseA\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 1
                self.animationRepeatCount = 1
                self.startAnimating()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5), target: self, selector: #selector(AnimImg.playLoseProtMBAnim), userInfo: nil, repeats: false)
            }
        } else if name == "Megaman" {
            self.image = UIImage (named: "animMegaMLose5.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...5 {
                let img = UIImage(named: "animMegaMLose\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 1.2
                self.animationRepeatCount = 1
                self.startAnimating()
            }
        } else {
            self.image = UIImage (named: "animAirMLose12.png")
            self.animationImages = nil
            var imgArray = [UIImage]()
            
            for x in 0...12 {
                let img = UIImage(named: "animAirMLose\(x).png")
                imgArray.append(img!)
                
                self.animationImages = imgArray
                self.animationDuration = 1.2
                self.animationRepeatCount = 1
                self.startAnimating()
            }
            
        }
    }
    
    //// Dr Light hologram animation
    
    func playDrLightHolo() {
        self.image = UIImage (named: "animDrLight0.png")
        self.animationImages = nil
        var imgArray = [UIImage]()
        
        for x in 0...11 {
            let img = UIImage(named: "animDrLight\(x).png")
            imgArray.append(img!)
            
            self.animationImages = imgArray
            self.animationDuration = 1.5
            self.animationRepeatCount = 0
            self.startAnimating()
        }
    }
    
    //// Play Protoman Second winning pose (loop)
    func playWinProtMBAnim() {
        self.image = UIImage (named: "animProtMWinB0.png")
        self.animationImages = nil
        var imgArray = [UIImage]()
        
        for x in 0...3 {
            let img = UIImage(named: "animProtMWinB\(x).png")
            imgArray.append(img!)
            
            self.animationImages = imgArray
            self.animationDuration = 0.5
            self.animationRepeatCount = 0
            self.startAnimating()
        }
    }
    
    //// Play Protoman Second losing pose (loop)
    func playLoseProtMBAnim() {
        self.image = UIImage (named: "animProtMLoseB0.png")
        self.animationImages = nil
        var imgArray = [UIImage]()
        
        for x in 0...3 {
            let img = UIImage(named: "animProtMLoseB\(x).png")
            imgArray.append(img!)
            
            self.animationImages = imgArray
            self.animationDuration = 0.5
            self.animationRepeatCount = 0
            self.startAnimating()
        }
    }
    
    //// Must be added to be called by the selector of each NSTimer. The delay equals to the duration of the animation preceding the NSTimer function.
    func playProtMIdle(){
        playIdleAnim("Protoman")
    }
    
    func playMegaMIdle(){
        playIdleAnim("Megaman")
    }
    
    func playAirMIdle(){
        playIdleAnim("Airman")
    }
}