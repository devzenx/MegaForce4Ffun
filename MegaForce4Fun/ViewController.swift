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
    
    
// IBOUTLETS
    
    // ** CHARACTER SELECTION
    
    @IBOutlet weak var viewPlayerSelScreen: UIView!
    
    @IBOutlet weak var imgPlayerBg: AnimImg!
    
    @IBOutlet weak var imgChoiceBg: UIImageView!
    
    @IBOutlet weak var imgSlidingWall: UIImageView!
    
    @IBOutlet weak var btnMegaM: UIButton!
    
    @IBOutlet weak var btnProtM: UIButton!
    
    @IBOutlet weak var lblChoiceMessage: UIStackView!
    
    @IBOutlet weak var imgRdyBtnBg: UIImageView!
    
    @IBOutlet weak var btnReady: UIButton!
    
    
    // ** ENEMY INTRODUCTION
    
    @IBOutlet weak var viewEnemyIntro: UIView!
    
    @IBOutlet weak var imgEnemyIntroBg: AnimImg!
    
    @IBOutlet weak var imgAirmanIntro: AnimImg!
    
    @IBOutlet weak var lblEnemyName: UIImageView!
    
    
    // ** FIGHT SCREEN
    
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
    
    @IBOutlet weak var lblTimerCount: UILabel!
    
    @IBOutlet weak var imgItemTop: DragItem!
    
    @IBOutlet weak var imgItemCenter: DragItem!
    
    @IBOutlet weak var imgItemBottom: DragItem!

    @IBOutlet weak var viewHitZone: UIView!
    
    // ** RESTART SCREEN
    
    @IBOutlet weak var animEndingSpr: AnimImg!
    
    @IBOutlet weak var viewRestartScreen: UIView!
    
    @IBOutlet weak var btnNewChar: UIButton!
    
    @IBOutlet weak var btnGameRestart: UIButton!
    
    
    
// VARIABLES
    
    var gs: GameStates!
    
    let MAX_HP: Int = 4
    let MAX_SHIELD = 4
    let OPAQUE: CGFloat = 1
    let TRANSPARENT: CGFloat = 0
    let DEF_TIMER: Int = 3
    
    var setChoice: String = "Megaman"
    var player: Character = Character()
    var enemy: Airman = Airman()
    var enemyHp: Int = 4
    var itemArray: [Int] = [1, 2, 3]
    var playerNeedArray: [Int] = [1, 2, 3]
    var playerIsActive: Bool = false
    var playerIsAlive: Bool = true
    var enemyIsAlive: Bool = true
    var roundTimer: NSTimer!
    var myTimer: NSTimer!
    var timeLeft: Int = 3
    
    //// Images
    var megaMSelectBg: UIImage = UIImage (named:"megaMPlayerBg.jpg")!
    var protMSelectBg: UIImage = UIImage (named:"protMPlayerBg.jpg")!
    var emptyRdyBtn: UIImage = UIImage (named:"rdyBtn.png")!
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
    var sfxMegaMLose: AVAudioPlayer!
    
    var sfxProtMShoot: AVAudioPlayer!
    var sfxProtMHurt: AVAudioPlayer!
    var sfxProtMWin: AVAudioPlayer!
    var sfxProtMLose: AVAudioPlayer!
    
    var sfxAirMShoot: AVAudioPlayer!
    var sfxAirMHurt: AVAudioPlayer!
    var sfxAirMWin: AVAudioPlayer!
    var sfxAirMLose: AVAudioPlayer!
    
    
    
// IBACTIONS
    
    
    // ** CHARACTER SELECTION SCREEN
    
    
    @IBAction func chooseMegaman(sender: AnyObject) {
        setChoice = "Megaman"
        sfxMenuBtnPressed.play()
        gs.sliderInOut()
    }
    
    
    @IBAction func chooseProtoman(sender: AnyObject) {
        setChoice = "Protoman"
        sfxMenuBtnPressed.play()
        gs.sliderInOut()
    }

    @IBAction func playerIsReady(sender: AnyObject) {
        sfxMenuBtnPressed.play()
        if setChoice == "Megaman" {
                    imgPlayerBg.image = UIImage (named:"megamanPlayerBg")
                    player = Megaman()
                    animPlayerSpr.playIdleAnim(player.name)
                    animEnemySpr.playIdleAnim(enemy.name)
                    enemy = Airman()
                    gs.displayEnemyIntroScreen()
        } else {
                    imgPlayerBg.image = UIImage (named:"protomanPlayerBg")
                    player = Protoman()
                    animPlayerSpr.playIdleAnim(player.name)
                    animEnemySpr.playIdleAnim(enemy.name)
                    enemy = Airman()
                    gs.displayEnemyIntroScreen()
        }
    }
    

    // ** RESTART SCREEN
    
    
    //// Return to the character selection screen
    @IBAction func ChooseCharacter(sender: AnyObject) {
        gs.displaySelectionScreen()
        sfxMenuBtnPressed.play()
        
    }
    
    //// Restart the game
    @IBAction func gameRestart(sender: AnyObject) {
        gs.restartFight()
        gs.displayFightScreen()
        sfxMenuBtnPressed.play()
    }
    

    
// INITIALIZER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gs = GameStates(vc: self)

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
            
            try sfxMegaMLose = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxMegaMLose", ofType: "wav")!))
            sfxMegaMLose.prepareToPlay()
            
            //// Characters // Protoman
            
            try sfxProtMShoot = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxProtMShoot", ofType: "wav")!))
                sfxProtMShoot.prepareToPlay()
            
            try sfxProtMHurt = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxProtMHurt", ofType: "wav")!))
                sfxProtMHurt.prepareToPlay()
            
            try sfxProtMWin = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxProtMWin", ofType: "wav")!))
                sfxProtMWin.prepareToPlay()
            
            try sfxProtMLose = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sfxProtMLose", ofType: "wav")!))
            sfxProtMLose.prepareToPlay()
            
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
        gs.displaySelectionScreen()
    }
    
    
    
// METHODS

    //// Play BGM audio with settings.
    func playCustomBgm(audioName: AVAudioPlayer) {
            audioName.numberOfLoops = -1 // Infinite loop
            audioName.currentTime = 0 // Return to the start of the track
            audioName.volume = 1 // Full volume
            audioName.play()
    }
    
    func stopBgm(audioName: AVAudioPlayer) {
        audioName.currentTime = 0
        audioName.stop()
    }
    
    //// Sound played when getting hurt depending on the character.
    func playSfxHurt(name:String) {
        if name == "Megaman" {
            sfxMegaMHurt.play()
        } else if name == "Protoman" {
            sfxProtMHurt.play()
        } else {
            sfxAirMHurt.play()
        }
    }
    
    //// Sound played when shooting at a character depending on the character.
    func playSfxShoot(name:String) {
        if name == "Megaman" {
            sfxMegaMShoot.play()
        } else if name == "Protoman" {
            sfxProtMShoot.play()
        } else {
            sfxAirMShoot.play()
        }
    }
    
    //// Sound played when winning depending on the character.
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
            sfxMegaMLose.play()
        } else if name == "Protoman" {
            sfxProtMLose.play()
        } else {
            sfxAirMLose.play()
        }
    }
    
}