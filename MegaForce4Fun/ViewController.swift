//
//  ViewController.swift
//  MegaForce4Fun
//
//  Created by Stéphane DEPOILLY on 11/04/2016.
//  Copyright © 2016 Stéphane DEPOILLY. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
// IBOUTLETS // CHARACTER SELECTION
    
    
    @IBOutlet weak var viewPlayerSelScreen: UIView!
    
    @IBOutlet weak var imgPlayerBg: UIImageView!
    
    
// IBOUTLETS // ENEMY INTRODUCTION SCREEN
    

// IBOUTLETS // FIGHT SCREEN
    
 
    @IBOutlet weak var btnItemTop: UIButton!
    
    @IBOutlet weak var btnItemCenter: UIButton!
    
    @IBOutlet weak var btnItemBottom: UIButton!
    
    @IBOutlet weak var viewFightScreen: UIView!
    
    @IBOutlet weak var imgBattleBg: UIImageView!
    
    @IBOutlet weak var imgEnemyHpBar: UIImageView!
    
    @IBOutlet weak var imgBattleGround: UIImageView!
    
    @IBOutlet weak var animDrLightHolo: AnimImg!
    
    @IBOutlet weak var animPlayerSpr: AnimImg!
    
    @IBOutlet weak var animEnemySpr: AnimImg!
    
    @IBOutlet weak var imgNeedItem: UIImageView!
    
    @IBOutlet weak var imgHpBar: UIImageView!

    @IBOutlet weak var imgShieldBar: UIImageView!
    
    @IBOutlet weak var itemInfo: UIImageView!
    

// IBOUTLETS // RESTART SCREEN
    
    @IBOutlet weak var animEndingSpr: AnimImg!
    
    @IBOutlet weak var viewRestartScreen: UIView!
    
    @IBOutlet weak var btnNewChar: UIButton!
    
    @IBOutlet weak var btnGameRestart: UIButton!

    
    
// VARIABLES
    
    
    var player: Character = Character()
    var enemy: Airman = Airman()
    var enemyHp: Int = 4
    
    var itemArray: [Int] = [1, 2, 3]
    var playerNeedArray: [Int] = [1, 2, 3]
    let MAX_HP: Int = 4
    let MAX_SHIELD = 4
    var playerIsActive: Bool = false
    var playerIsAlive: Bool = true
    var enemyIsAlive: Bool = true
    var timer: NSTimer!
    let OPAQUE: CGFloat = 1
    let TRANSPARENT: CGFloat = 0
    
    //// Images
    var energyItem: UIImage = UIImage (named: "attackItem.png")!
    var healthItem: UIImage = UIImage (named: "lifeItem.png")!
    var shieldItem: UIImage = UIImage (named: "shieldItem.png")!
    var energyNeededItem: UIImage = UIImage (named: "itemNeededAttack.png")!
    var healthNeededItem: UIImage = UIImage (named: "itemNeededHeart.png")!
    var shieldNeededItem: UIImage = UIImage (named: "itemNeededShield.png")!
    
    //// Audio BGM
    var bgmCharSel: AVAudioPlayer!
    var bgmEnemyIntro: AVAudioPlayer!
    var bgmFight: AVAudioPlayer!
    var bgmRestart: AVAudioPlayer!
    
    /// Audio SFX
    var sfxMenuBtnPressed: AVAudioPlayer!
    var sfxLifeUp: AVAudioPlayer!
    var sfxShieldUp: AVAudioPlayer!
    var sfxShieldBlock: AVAudioPlayer!
    
    var sfxMegaMShoot: AVAudioPlayer!
    var sfxMegaMHurt: AVAudioPlayer!
    var sfxMegaMWin: AVAudioPlayer!
    
    var sfxProtMShoot: AVAudioPlayer!
    var sfxProtMHurt: AVAudioPlayer!
    var sfxProtMWin: AVAudioPlayer!
    
    var sfxAirMShoot: AVAudioPlayer!
    var sfxAirMHurt: AVAudioPlayer!
    var sfxAirMWin: AVAudioPlayer!
    var sfxAirMLose: AVAudioPlayer!
    
    
// IBACTIONS // CHARACTER SELECTION
    
    
    @IBAction func chooseMegaman(sender: AnyObject) {
        imgPlayerBg.image = UIImage (named:"megamanPlayerBg")
        player = Megaman()
        sfxMenuBtnPressed.play()
        animPlayerSpr.playIdleAnim(player.name)
        animEnemySpr.playIdleAnim(enemy.name)
        enemy = Airman()
        displayFightScreen()
    }
    
    @IBAction func chooseProtoman(sender: AnyObject) {
        imgPlayerBg.image = UIImage (named:"protomanPlayerBg")
        player = Protoman()
        sfxMenuBtnPressed.play()
        animPlayerSpr.playIdleAnim(player.name)
        animEnemySpr.playIdleAnim(enemy.name)
        enemy = Airman()
        displayFightScreen()
    }
    
    
// IBACTIONS // FIGHT SCREEN
    
    
    @IBAction func playerBtnTop(sender: AnyObject) {
        playerIsActive = true
        updatePlayerState(btnItemTop)
        newRound()
    }
    
    @IBAction func playerBtnCenter(sender: AnyObject) {
        playerIsActive = true
        updatePlayerState(btnItemCenter)
        newRound()
    }
    
    @IBAction func playerBtnBottom(sender: AnyObject) {
        playerIsActive = true
        updatePlayerState(btnItemBottom)
        newRound()
    }
    
    @IBAction func endTimer(sender: AnyObject) {
        playerIsActive = false
        checkIfActive()
        newRound()
    }
    
    
// IBACTIONS // RESTART SCREEN
    
    
    //// Return to the character selection screen
    @IBAction func ChooseCharacter(sender: AnyObject) {
        displaySelectionScreen()
        sfxMenuBtnPressed.play()
        
    }
    
    //// Restart Game
    @IBAction func gameRestart(sender: AnyObject) {
        resetFight()
        displayFightScreen()
        sfxMenuBtnPressed.play()
    }
    

    
// VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //// Audio declaration
        
        do {
            //// BGM
            try bgmCharSel = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgmCharSel", ofType: "mp3")!))
            bgmCharSel.prepareToPlay()
            
            try bgmEnemyIntro = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgmEnemyIntro", ofType: "mp3")!))
            bgmEnemyIntro.prepareToPlay()
            
            try bgmFight = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgmFight", ofType: "mp3")!))
            bgmFight.prepareToPlay()
            
            try bgmRestart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgmRestart", ofType: "mp3")!))
            bgmRestart.prepareToPlay()
            
            //// Menu & UI
            
            try sfxMenuBtnPressed = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxMenuBtnPressed", ofType: "wav")!))
                sfxMenuBtnPressed.prepareToPlay()
            
            try sfxShieldUp = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxShieldUp", ofType: "wav")!))
                sfxShieldUp.prepareToPlay()
            
            try sfxShieldBlock = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxShieldBlock", ofType: "wav")!))
                sfxShieldBlock.prepareToPlay()
            
            try sfxLifeUp = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxLifeUp", ofType: "wav")!))
                sfxLifeUp.prepareToPlay()
            
            //// Characters // Megaman
            
            try sfxMegaMShoot = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxMegaMShoot", ofType: "wav")!))
                sfxMegaMShoot.prepareToPlay()
            
            try sfxMegaMHurt = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxMegaMHurt", ofType: "wav")!))
                sfxMegaMHurt.prepareToPlay()
            
            try sfxMegaMWin = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxMegaMWin", ofType: "wav")!))
                sfxMegaMWin.prepareToPlay()
            
            //// Characters // Protoman
            
            try sfxProtMShoot = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxProtMShoot", ofType: "wav")!))
                sfxProtMShoot.prepareToPlay()
            
            try sfxProtMHurt = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxProtMHurt", ofType: "wav")!))
                sfxProtMHurt.prepareToPlay()
            
            try sfxProtMWin = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxProtMWin", ofType: "wav")!))
                sfxProtMWin.prepareToPlay()
            
            //// Characters // Airman
            
            try sfxAirMShoot = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxAirMShoot", ofType: "wav")!))
            sfxAirMShoot.prepareToPlay()
        
            try sfxAirMHurt = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxAirMHurt", ofType: "wav")!))
            sfxAirMHurt.prepareToPlay()
            
            try sfxAirMWin = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxAirMWin", ofType: "wav")!))
            sfxAirMWin.prepareToPlay()
            
            try sfxAirMLose = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxAirMLose", ofType: "wav")!))
            sfxAirMLose.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        displaySelectionScreen()
        //        startTimer()
    }

    
    
// METHODS // CHARACTER SELECTION
    
    
    //// Display selection screen
    func displaySelectionScreen() {
        stopBgm(bgmFight)
        stopBgm(bgmRestart)
        playBgm(bgmCharSel)
        viewRestartScreen.hidden = true
        viewPlayerSelScreen.hidden = false
    }
    
    //// Display fight screen
    func displayFightScreen() {
        stopBgm(bgmCharSel)
        stopBgm(bgmRestart)
        playBgm(bgmFight)
        imgBattleBg.image = player.charBattleBg
        imgBattleGround.image = player.charBattleGround
        animEnemySpr.transform = CGAffineTransformMakeScale(-1, 1)
        animDrLightHolo.playDrLightHolo()
        viewPlayerSelScreen.hidden = true
        viewFightScreen.hidden = false
        newRound()
    }
    
    
// METHODS // FIGHT SCREEN

    
    //// Display Restart screen
    func displayRestartScreen() {
        stopBgm(bgmFight)
        playBgm(bgmRestart)
        animEndingSpr.playRestartBg()
        viewFightScreen.hidden = true
        viewRestartScreen.hidden = false
    }
    
    
    //// Start a new round
    func newRound() {
        
        // Display randomly an item which the player needs to pick.
        let randPlayerNeed = Int(arc4random_uniform(UInt32(playerNeedArray.count))) + 1
        imgNeedItem.tag = randPlayerNeed
        updateItemNeed()
        
        // Randomize all buttons images
        itemArray.shuffleInPlace()
        btnItemTop.tag = itemArray[0]
        btnItemCenter.tag = itemArray[1]
        btnItemBottom.tag = itemArray[2]
        updateHpBar()
        updateShieldBar()
        updateEnemyHp()
        updateImgBtn(btnItemTop)
        updateImgBtn(btnItemCenter)
        updateImgBtn(btnItemBottom)
        itemDropActivate()
    }
    
    //// Reset the fight if "Restart button" is pressed
    func resetFight() {
        player.hp = 4
        player.shieldCount = 0
        enemy.hp = 4
        itemDropActivate()
        animPlayerSpr.playIdleAnim(player.name)
        animEnemySpr.playIdleAnim(enemy.name)
        viewFightScreen.hidden = false
        viewRestartScreen.hidden = true
        playerIsAlive = false
        newRound()
    }
    
    //// Start the timer
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.timeIsOver), userInfo: nil, repeats: true)
        
    }

    //// When the timer is over, check if an item has been dropped on the player sprite
    func timeIsOver() {
        playerIsActive = false
        checkIfActive()
        newRound()
    }
    
    func itemDropActivate() {
        if  player.hp <= 0 || enemy.hp <= 0 {
            imgNeedItem.hidden = true
            btnItemTop.hidden = true
            btnItemCenter.hidden = true
            btnItemBottom.hidden = true
        } else {
            imgNeedItem.hidden = false
            btnItemTop.hidden = false
            btnItemCenter.hidden = false
            btnItemBottom.hidden = false
        }

    }
    
    
    //// Update the image to show to the player what item needs to be dropped on the character.
    func updateItemNeed() {
        if imgNeedItem.tag == 1 {
            imgNeedItem.image = energyNeededItem
        } else if imgNeedItem.tag == 2 {
            imgNeedItem.image = healthNeededItem
        } else {
            imgNeedItem.image = shieldNeededItem
        }
    }
    
    //// Update the button image according to its current tag
    func updateImgBtn(sender: UIButton) {
        if sender.tag == 1 {
            sender.setImage(energyItem, forState: .Normal)
        } else if sender.tag == 2 {
            sender.setImage(healthItem, forState: .Normal)
        } else {
            sender.setImage(shieldItem, forState: .Normal)
        }
    }
    
    //// Update the player state according to what has been dropped on the player.
    func updatePlayerState(button: UIButton) {
        playerIsActive = true
        
        if button.tag == imgNeedItem.tag {
            if imgNeedItem.tag == 1 {
                enemyIsAttacked()
            } else if imgNeedItem.tag == 2 {
                addExtraLife()
            } else {
                addExtraShield()
            }
        } else {
            playerIsAttacked()
        }
    }

    func addExtraLife() {
        if player.hp >= MAX_HP {
            itemInfo.image = UIImage (named:"itemMaxHp.png")
            fadeInOut(itemInfo)
        } else {
            player.hp += 1
            sfxLifeUp.play()
            updateHpBar()
            itemInfo.image = UIImage (named:"itemPlusHp.png")
            fadeInOut(itemInfo)
        }
    }
    
    func addExtraShield() {
        if player.shieldCount >= MAX_SHIELD {
            itemInfo.image = UIImage (named:"itemMaxShield.png")
            fadeInOut(itemInfo)
        } else {
            player.shieldCount += 1
            sfxShieldUp.play()
            itemInfo.image = UIImage (named:"itemPlusShield.png")
            fadeInOut(itemInfo)
            updateShieldBar()
        }
    }
    
    func playerIsAttacked() {
        if player.shieldCount >= 1 {
            player.shieldCount -= 1
            updateShieldBar()
            sfxShieldBlock.play()
            animPlayerSpr.playIdleAnim(player.name)
            animEnemySpr.playAttackAnim(enemy.name)
            itemInfo.image = UIImage (named:"itemBlocked.png")
            fadeInOut(itemInfo)
            
        } else {
            player.hp -= 1
            if player.hp <= 0 {
                updateHpBar()
                playerIsAlive = false
                playSfxWin(enemy.name)
                animEnemySpr.playWinAnim(enemy.name)
                animPlayerSpr.playLoseAnim(player.name)
                itemDropActivate()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: #selector(ViewController.displayRestartScreen), userInfo: nil, repeats: false)
            } else {
            updateHpBar()
            playSfxHurt(player.name)
            playSfxShoot(enemy.name)
            animPlayerSpr.playHurtAnim(player.name)
            animEnemySpr.playAttackAnim(enemy.name)
            itemInfo.image = UIImage (named:"itemMinusHp.png")
            fadeInOut(itemInfo)
            }
        }
    }
    
    func enemyIsAttacked() {
            enemy.hp -= 1
            if enemy.hp <= 0 {
                updateEnemyHp()
                enemyIsAlive = false
                playSfxWin(player.name)
                playSfxLose(enemy.name)
                animPlayerSpr.playWinAnim(player.name)
                animEnemySpr.playLoseAnim(enemy.name)
                itemDropActivate()
                NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: #selector(ViewController.displayRestartScreen), userInfo: nil, repeats: false)
            } else {
            playSfxHurt(enemy.name)
            playSfxShoot(player.name)
            animEnemySpr.playHurtAnim(enemy.name)
            animPlayerSpr.playAttackAnim(player.name)
            updateEnemyHp()
            }
    }

    
    
    // NSTimer
    func checkIfActive() {
        if playerIsActive == false {
            playerIsAttacked()
        }
    }
    
    //// Udpate player HP bar
    func updateHpBar() {
        if player.hp == 4 {
            imgHpBar.image = UIImage(named:"barHp4-4.png")
        } else if player.hp == 3 {
            imgHpBar.image = UIImage(named:"barHp3-4.png")
        } else if player.hp == 2 {
            imgHpBar.image = UIImage(named:"barHp2-4.png")
        } else if player.hp == 1 {
            imgHpBar.image = UIImage(named:"barHp1-4.png")
        } else {
            imgHpBar.image = UIImage(named:"barHp0-4.png")
        }
    }
    
    //// Udpate player shield bar
    func updateShieldBar() {
        
        if player.shieldCount == 4 {
            imgShieldBar.image = UIImage(named:"barShield4-4.png")
        } else if player.shieldCount == 3 {
            imgShieldBar.image = UIImage(named:"barShield3-4.png")
        } else if player.shieldCount == 2 {
            imgShieldBar.image = UIImage(named:"barShield2-4.png")
        } else if player.shieldCount == 1 {
            imgShieldBar.image = UIImage(named:"barShield1-4.png")
        } else {
            imgShieldBar.image = UIImage(named:"barShield0-4.png")
        }
    }
    
    //// Udpate enemy shield bar
    func updateEnemyHp() {
        if enemy.hp == 4 {
            imgEnemyHpBar.image = UIImage (named:"barHpEnemy4-4.png")
        }else if enemy.hp == 3 {
            imgEnemyHpBar.image = UIImage (named:"barHpEnemy3-4.png")
        }else if enemy.hp == 2 {
            imgEnemyHpBar.image = UIImage (named:"barHpEnemy2-4.png")
        }else if enemy.hp == 1 {
            imgEnemyHpBar.image = UIImage (named:"barHpEnemy1-4.png")
        }else {
            imgEnemyHpBar.image = UIImage (named:"barHpEnemy0-4.png")
        }
    }
    
    //// Animation effect
    func fadeInOut(imageName:UIImageView){
        imageName.alpha = self.TRANSPARENT
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            imageName.alpha = self.OPAQUE
            imageName.center.y += self.view.bounds.height
            }, completion:{finished in
                if (finished) {
                    UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: {
                        imageName.alpha = self.TRANSPARENT
                        }, completion: nil)
                }
        })
        imageName.center.y -= self.view.bounds.height
    }
    
    //// Play BGM audio with settings
    func playBgm(audioName: AVAudioPlayer) {
            audioName.numberOfLoops = -1
            audioName.currentTime = 0
            audioName.volume = 0.2
            audioName.play()
    }
    
    func stopBgm(audioName: AVAudioPlayer) {
        audioName.currentTime = 0
        audioName.stop()
    }
    
    // Sound played when getting hurt depending on the character
    func playSfxHurt(name:String) {
        if name == "Megaman" {
            sfxMegaMHurt.play()
        } else if name == "Protoman" {
            sfxProtMHurt.play()
        } else {
            sfxAirMHurt.play()
        }
    }
    
    func playSfxShoot(name:String) {
        if name == "Megaman" {
            sfxMegaMShoot.play()
        } else if name == "Protoman" {
            sfxProtMShoot.play()
        } else {
            sfxAirMShoot.play()
        }
    }
 
    func playSfxWin(name:String) {
        if name == "Megaman" {
            sfxMegaMWin.play()
        } else if name == "Protoman" {
            sfxProtMWin.play()
        } else {
            sfxAirMWin.play()
        }
    }
    
    func playSfxLose(name:String) {
        if name == "Megaman" {
            
        } else if name == "Protoman" {
            
        } else {
            sfxAirMLose.play()
        }
    }
    
}