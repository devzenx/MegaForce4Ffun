//
//  GameStates.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 12/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation
import UIKit

class GameStates: NSObject {

    
// PROPERTIES
    
    var vc: ViewController!
    

    
// INITIALIZER
    
    init(vc: ViewController) {
        super.init()
        self.vc = vc
        
        //// We create a listener/observer for any notifications from DragItem.swift
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameStates.itemDroppedOnPlayer), name: "onTargetDropped", object: nil)
        
        //// the droptarget is not at the right place, it is shifted to the right. I had to cheat and simulate a hit area. I think it's related to Auto-Layout.
        vc.imgItemTop.dropTarget = vc.viewHitZone
        vc.imgItemCenter.dropTarget = vc.viewHitZone
        vc.imgItemBottom.dropTarget = vc.viewHitZone
        
    }
    
   
    
// METHODS
    
    // ** GLOBAL
    
    //// Display the Character selection screen.
    func displaySelectionScreen() {
        vc.viewRestartScreen.hidden = true // The Restart screen is hidden.
        vc.viewPlayerSelScreen.hidden = false // The Player Selection screen is displayed.
        vc.imgPlayerBg.playPlayerSelectBg() // The animated background of Megaman in black is played.
        vc.imgChoiceBg.hidden = true // The player background (Megaman or Protoman) is hidden unless a button is pressed.
        vc.imgRdyBtnBg.hidden = false // background for the text "choose your player" is diplayed.
        vc.imgRdyBtnBg.image = vc.emptyRdyBtn // Default image (black) for for the imgRdyBtnBg.
        vc.lblChoiceMessage.hidden = false // Text "choose your player" is displayed.
        vc.btnReady.hidden = true // The button "tap when ready" is hidden unless a player chooses a character.
        vc.stopBgm(vc.bgmRestart) // The music coming from the Restart screen is stopped.
        vc.playCustomBgm(vc.bgmCharSel) // The character selection music with custom settings is played.
    }
    
    //// Display the Enemy introduction screen.
    func displayEnemyIntroScreen() {
        vc.viewPlayerSelScreen.hidden = true // The Player Selection screen is hidden.
        vc.viewEnemyIntro.hidden = false // The Enemy introduction screen is displayed.
        vc.stopBgm(vc.bgmCharSel) // The music coming from the Character selection screen is stopped.
        vc.bgmEnemyIntro.play() // The enemy introduction music with custom settings is played.
        vc.imgEnemyIntroBg.playEnemyIntro() // The animated background (starfield with blue bar) is played.
        
        // Airman entrance
        vc.imgAirmanIntro.alpha = self.vc.TRANSPARENT
        vc.imgAirmanIntro.center.y -= vc.view.bounds.height
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            self.vc.imgAirmanIntro.alpha = self.vc.OPAQUE
            self.vc.imgAirmanIntro.center.y += self.vc.view.bounds.height
            }, completion:nil)
            vc.imgAirmanIntro.playWinAnim(vc.enemy.name)
        
        // Airman name fade in
        vc.lblEnemyName.alpha = self.vc.TRANSPARENT
        UIView.animateWithDuration(1, delay: 0.2, options: [], animations: {
            self.vc.lblEnemyName.alpha = self.vc.OPAQUE
            }, completion:nil)
        
        // Display the fight screen at the end of the BGM duration
        let bgmDuration = vc.bgmEnemyIntro.duration / 2 //Somehow, Xcode doubled the duration of this track. I'm cheating.
        NSTimer.scheduledTimerWithTimeInterval(bgmDuration, target:self, selector: #selector(GameStates.displayFightScreen), userInfo: nil, repeats: false)
    }
    
    //// Display the Fight screen.
    func displayFightScreen() {
        vc.viewEnemyIntro.hidden = true // The Enemy introduction screen is hidden
        vc.viewFightScreen.hidden = false // The Fight screen is displayed.
        vc.imgBattleBg.image = vc.player.charBattleBg // The background color is based on the chosen character.
        vc.imgBattleGround.image = vc.player.charBattleGround // The ground color is based on the chose character.
        vc.animEnemySpr.transform = CGAffineTransformMakeScale(-1, 1) // The enemy sprites is horizontally mirrored.
        vc.animDrLightHolo.playDrLightHolo() // The Dr light showing the needed item is animated in the background.
        vc.stopBgm(vc.bgmRestart) // The music coming from the Restart screen is stopped.
        vc.playCustomBgm(vc.bgmFight) // The Fight screen music is played.
        newRound() // A new round is started as soon the Fight screen is displayed.
    }
    
    //// Display the Restart screen.
    func displayRestartScreen() {
        vc.viewFightScreen.hidden = true // The Fight screen is hidden.
        vc.viewRestartScreen.hidden = false // The Restart screen is displayed.
        vc.stopBgm(vc.bgmFight) // The music coming from the Fight screen is stopped.
        vc.playCustomBgm(vc.bgmRestart) // The Restart screen music is played.
        vc.animEndingSpr.playRestartBg() // The ending movie of Megaman 2 is played.
    }
    
    
    // ** FIGHT SCREEN
    
    //// Start a new round.
    func newRound() {
        startTimer() // The timer is re-initialized to its default value.
        vc.playerIsActive = false // Unless an item is dropped at the character, the player is considered inactive.
        updateImgNeededItem() // The item needed to be dragged on the player is randomized.
        updateDragItems() // The items and their associated images are randomized.
        updatePlayersInfo() // Player & enemy health and shield status are updated.
        SwitchUserInteraction() // Dragable items and Dr Light needed item disappear
    }
    
    //// Restart the fight.
    func restartFight() {
        vc.player.hp = 4
        vc.player.shieldCount = 0
        vc.enemy.hp = 4
        SwitchUserInteraction() //
        vc.animPlayerSpr.playIdleAnim(vc.player.name)
        vc.animEnemySpr.playIdleAnim(vc.enemy.name)
        vc.viewFightScreen.hidden = false
        vc.viewRestartScreen.hidden = true
        vc.playerIsAlive = false
        newRound()
    }
    
    //// Start the timer.
    func startTimer() {
        vc.lblTimerCount.text = String(vc.timeLeft) // 3 is displayed instead of 0 when you restart the fight
        
        if vc.roundTimer != nil {
            vc.roundTimer.invalidate()
            vc.timeLeft = vc.DEF_TIMER
        }
        vc.roundTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameStates.updatetimer), userInfo: nil, repeats: true)
    }
    
    //// If no items have been dragged to the player's character, player gets hurt.
    func checkIfActive() {
        if !vc.playerIsActive {
            playerIsAttacked()
        }
    }
    
    //// Update the timer label and when it reaches 0, executes a condition.
    func updatetimer() {
        vc.timeLeft = vc.timeLeft - 1
        vc.lblTimerCount.text = String(vc.timeLeft)
        
        if vc.timeLeft == 3 {
        vc.lblTimerCount.textColor = UIColor.greenColor()
        } else if vc.timeLeft == 2 {
            vc.lblTimerCount.textColor = UIColor.yellowColor()
        } else if vc.timeLeft == 1 {
            vc.lblTimerCount.textColor = UIColor.orangeColor()
        } else {
            vc.lblTimerCount.textColor = UIColor.whiteColor()
            vc.roundTimer.invalidate()
            checkIfActive()
        }
    }
    
    /// Consequences of dropping items on the player's character.
    func itemDroppedOnPlayer() {
        vc.playerIsActive = true
        
        if vc.viewHitZone.tag == vc.imgNeedItem.tag {
            if vc.viewHitZone.tag == 1 {
                enemyIsAttacked()
            } else if vc.viewHitZone.tag == 2 {
                addExtraLife()
                newRound()
            } else {
                addExtraShield()
                newRound()
            }
        } else {
            playerIsAttacked()
        }
    }
    
    //// Generate a random needed item and update its image.
    func updateImgNeededItem() {
        let randPlayerNeed = Int(arc4random_uniform(UInt32(vc.playerNeedArray.count))) + 1
        vc.imgNeedItem.tag = randPlayerNeed
        if vc.imgNeedItem.tag == 1 {
            vc.imgNeedItem.image = vc.energyNeededItem
        } else if vc.imgNeedItem.tag == 2 {
            vc.imgNeedItem.image = vc.healthNeededItem
        } else {
            vc.imgNeedItem.image = vc.shieldNeededItem
        }
    }
    
    //// Update the image of draggable items according to their tag.
    func updateDragItems() {
        vc.itemArray.shuffleInPlace()
        vc.imgItemTop.tag = vc.itemArray[0]
        vc.imgItemCenter.tag = vc.itemArray[1]
        vc.imgItemBottom.tag = vc.itemArray[2]
        
        func updateImgDragItems(dragItem: UIImageView){
            if dragItem.tag == 1 {
                dragItem.image = vc.energyItem
            } else if dragItem.tag == 2 {
                dragItem.image = vc.healthItem
            } else {
                dragItem.image = vc.shieldItem
            }
        }
        // Update images of draggable items according to the function above.
        updateImgDragItems(vc.imgItemTop)
        updateImgDragItems(vc.imgItemCenter)
        updateImgDragItems(vc.imgItemBottom)
    }
    
    //// Player gets an extra life.
    func addExtraLife() {
        if vc.player.hp >= vc.MAX_HP {
            vc.itemInfo.image = UIImage (named:"itemMaxHp.png")
            fadeInOut(vc.itemInfo)
        } else {
            vc.player.hp += 1
            vc.sfxLifeUp.play()
            updatePlayersInfo()
            vc.itemInfo.image = UIImage (named:"itemPlusHp.png")
            fadeInOut(vc.itemInfo)
        }
    }
    
    //// Player gets an extra shield.
    func addExtraShield() {
        if vc.player.shieldCount >= vc.MAX_SHIELD {
            vc.itemInfo.image = UIImage (named:"itemMaxShield.png")
            fadeInOut(vc.itemInfo)
        } else {
            vc.player.shieldCount += 1
            vc.sfxShieldUp.play()
            vc.itemInfo.image = UIImage (named:"itemPlusShield.png")
            fadeInOut(vc.itemInfo)
            updatePlayersInfo()
        }
    }
    
    //// Events when the player's character is hurt or dies.
    func playerIsAttacked() {
        if vc.player.shieldCount >= 1 {
            vc.player.shieldCount -= 1
            updatePlayersInfo()
            vc.sfxShieldBlock.play()
            vc.animPlayerSpr.playIdleAnim(vc.player.name)
            vc.animEnemySpr.playAttackAnim(vc.enemy.name)
            vc.itemInfo.image = UIImage (named:"itemBlocked.png")
            fadeInOut(vc.itemInfo)
            
        } else {
            vc.player.hp -= 1
            
            if vc.player.hp <= 0 {
                updatePlayersInfo()
                vc.roundTimer.invalidate()
                vc.playSfxLose(vc.player.name)
                vc.playSfxWin(vc.enemy.name)
                vc.animEnemySpr.playWinAnim(vc.enemy.name)
                vc.animPlayerSpr.playLoseAnim(vc.player.name)
                SwitchUserInteraction()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: #selector(GameStates.displayRestartScreen), userInfo: nil, repeats: false)
            } else {
                updatePlayersInfo()
                vc.playSfxHurt(vc.player.name)
                vc.playSfxShoot(vc.enemy.name)
                vc.animPlayerSpr.playHurtAnim(vc.player.name)
                vc.animEnemySpr.playAttackAnim(vc.enemy.name)
                vc.itemInfo.image = UIImage (named:"itemMinusHp.png")
                fadeInOut(vc.itemInfo)
                updatePlayersInfo()
                newRound()
            }
        }
    }
    
    //// Events when the enemy is hurt or dies.
    func enemyIsAttacked() {
        vc.enemy.hp -= 1
        if vc.enemy.hp <= 0 {
            vc.gs.updatePlayersInfo()
            vc.roundTimer.invalidate()
            vc.playSfxWin(vc.player.name)
            vc.playSfxLose(vc.enemy.name)
            vc.animPlayerSpr.playWinAnim(vc.player.name)
            vc.animEnemySpr.playLoseAnim(vc.enemy.name)
            SwitchUserInteraction()
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: #selector(GameStates.displayRestartScreen), userInfo: nil, repeats: false)
        } else {
            vc.playSfxHurt(vc.enemy.name)
            vc.playSfxShoot(vc.player.name)
            vc.animEnemySpr.playHurtAnim(vc.enemy.name)
            vc.animPlayerSpr.playAttackAnim(vc.player.name)
            updatePlayersInfo()
            newRound()
        }
    }

    //// Update player & enemy health and shield status.
    func updatePlayersInfo() {
        
        // Player health points update.
        if vc.player.hp == 4 {
            vc.imgHpBar.image = UIImage(named:"barHp4-4.png")
        } else if vc.player.hp == 3 {
            vc.imgHpBar.image = UIImage(named:"barHp3-4.png")
        } else if vc.player.hp == 2 {
            vc.imgHpBar.image = UIImage(named:"barHp2-4.png")
        } else if vc.player.hp == 1 {
            vc.imgHpBar.image = UIImage(named:"barHp1-4.png")
        } else {
            vc.imgHpBar.image = UIImage(named:"barHp0-4.png")
        }
        
        // Player shield update.
        if vc.player.shieldCount == 4 {
            vc.imgShieldBar.image = UIImage(named:"barShield4-4.png")
        } else if vc.player.shieldCount == 3 {
            vc.imgShieldBar.image = UIImage(named:"barShield3-4.png")
        } else if vc.player.shieldCount == 2 {
            vc.imgShieldBar.image = UIImage(named:"barShield2-4.png")
        } else if vc.player.shieldCount == 1 {
            vc.imgShieldBar.image = UIImage(named:"barShield1-4.png")
        } else {
            vc.imgShieldBar.image = UIImage(named:"barShield0-4.png")
        }
        
        // Enemy health points update.
        if vc.enemy.hp == 4 {
            vc.imgEnemyHpBar.image = UIImage (named:"barHpEnemy4-4.png")
        }else if vc.enemy.hp == 3 {
            vc.imgEnemyHpBar.image = UIImage (named:"barHpEnemy3-4.png")
        }else if vc.enemy.hp == 2 {
            vc.imgEnemyHpBar.image = UIImage (named:"barHpEnemy2-4.png")
        }else if vc.enemy.hp == 1 {
            vc.imgEnemyHpBar.image = UIImage (named:"barHpEnemy1-4.png")
        }else {
            vc.imgEnemyHpBar.image = UIImage (named:"barHpEnemy0-4.png")
        }
    }
    
    //// Deactivate interaction with items when the game is over.
    func SwitchUserInteraction() {
        if  vc.player.hp <= 0 || vc.enemy.hp <= 0 {
            vc.imgNeedItem.hidden = true
            vc.imgItemTop.hidden = true
            vc.imgItemCenter.hidden = true
            vc.imgItemBottom.hidden = true
        } else {
            vc.imgNeedItem.hidden = false
            vc.imgItemTop.hidden = false
            vc.imgItemCenter.hidden = false
            vc.imgItemBottom.hidden = false
        }
        
    }
    
    
    // ** ANIMATIONS
    
    //// Vertical slide in from the top + fade in/out for item effects.
    func fadeInOut(imageName:UIImageView){
        imageName.alpha = self.vc.TRANSPARENT
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            imageName.alpha = self.vc.OPAQUE
            imageName.center.y += self.vc.view.bounds.height
            }, completion:{finished in
                if (finished) {
                    UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: {
                        imageName.alpha = self.vc.TRANSPARENT
                        }, completion: nil)
                }
        })
        imageName.center.y -= self.vc.view.bounds.height
    }
    
    
    //// Sliding wall animation in the Character selection screen.
    func sliderInOut(){
        self.vc.btnMegaM.userInteractionEnabled = false
        self.vc.btnProtM.userInteractionEnabled = false
        self.vc.btnReady.hidden = true
        self.vc.lblChoiceMessage.hidden = true
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            self.vc.imgSlidingWall.center.x += self.vc.view.bounds.width
            
            }, completion:{finished in
                if (finished) {
                    
                    UIView.animateWithDuration(0.5, delay: 0.1, options: [], animations: {
                        self.vc.imgSlidingWall.center.x -= self.vc.view.bounds.width
                        self.vc.imgChoiceBg.hidden = false
                        if self.vc.setChoice == "Megaman" {
                            self.vc.imgChoiceBg.image = self.vc.megaMSelectBg
                            self.vc.imgRdyBtnBg.image = UIImage (named:"rdyBtnMegaM")
                        } else {
                            self.vc.imgChoiceBg.image = self.vc.protMSelectBg
                            self.vc.imgRdyBtnBg.image = UIImage (named:"rdyBtnProtM")
                        }
                        self.delay(0.5, closure: {
                            self.vc.btnMegaM.userInteractionEnabled = true
                            self.vc.btnProtM.userInteractionEnabled = true
                            
                            self.vc.btnReady.titleLabel!.textAlignment = .Center
                            self.vc.btnReady.titleLabel!.numberOfLines = 2
                            self.vc.btnReady.hidden = false
                            self.vc.btnReady.userInteractionEnabled = true
                            self.vc.btnReady.setTitle("TAP WHEN\nREADY!", forState: .Normal)
                        })
                        }, completion: nil)
                }
        })
        
    }

    
    // ** EXTRA FUNCTIONS
    
    //// Delay function
    //// http://stackoverflow.com/questions/34256584/how-do-i-disable-the-button-before-finished-animating
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}