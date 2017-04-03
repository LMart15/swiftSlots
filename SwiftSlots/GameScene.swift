//
//  GameScene.swift
//  SwiftSlots
//
//  Created by Lawrence Martin on 2017-04-01.
//  Copyright © 2017 mapd.centennial. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var jackpot: Int = 1000000
    var currentBet: Int = 0
    var currentBalance: Int = 999
    
    //labels
    var betLabel = SKLabelNode()
    var betAmtLabel = SKLabelNode()
    var balanceLabel = SKLabelNode()
    var balanceAmtLabel = SKLabelNode()
    var jackpotLabel = SKLabelNode()
    var jackpotAmtLabel = SKLabelNode()
    
    let formatter = NumberFormatter()
    
    //slot options
    var wheel1_sprite = SKSpriteNode()
    var wheel2_sprite = SKSpriteNode()
    var wheel3_sprite = SKSpriteNode()
    var spriteArray = Array<SKTexture>();
    
    //misc
    var wheelHouse = SKSpriteNode()
    var gameTitle = SKSpriteNode()

    //buttons
    var spinButton = SKSpriteNode()
    var bet1Button = SKSpriteNode()
    var bet10Button = SKSpriteNode()
    var bet100Button = SKSpriteNode()
    var quitButton = SKSpriteNode()
    var resetButton = SKSpriteNode()
    
    var isSpinning:Bool = false
    
   
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "beach_background.jpg")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -100
        addChild(background)
        
        
        
        spriteArray.append(SKTexture(imageNamed:"banana"));
        spriteArray.append(SKTexture(imageNamed:"orange"));
        spriteArray.append(SKTexture(imageNamed:"seven"));
        spriteArray.append(SKTexture(imageNamed:"bell"));
        spriteArray.append(SKTexture(imageNamed:"bar"));
        spriteArray.append(SKTexture(imageNamed:"banana"));
        spriteArray.append(SKTexture(imageNamed:"orange"));
        spriteArray.append(SKTexture(imageNamed:"seven"));
        spriteArray.append(SKTexture(imageNamed:"cherry"));
        spriteArray.append(SKTexture(imageNamed:"grapes"));
        spriteArray.append(SKTexture(imageNamed:"orange"));
        
        self.gameTitle = SKSpriteNode(imageNamed: "SWIFT-SLOTS")
        self.gameTitle.xScale = self.wheelHouse.xScale * 1.3
        self.gameTitle.yScale = 1.3
        self.gameTitle.position = CGPoint(x:self.frame.midX, y:self.frame.height / 3)
        self.addChild(gameTitle)
        
        self.jackpotLabel.text = "CURRENT JACKPOT:"
        self.jackpotLabel.fontColor = UIColor.black
        self.jackpotLabel.fontSize = 32
        self.jackpotLabel.fontName = "Noteworthy-Bold "
        self.jackpotLabel.position = CGPoint(x:self.frame.midX, y:self.frame.height / 4)
        self.addChild(jackpotLabel)
        
        formatter.numberStyle = .currency
        var jackpotString = formatter.string(for: self.jackpot)
        self.jackpotAmtLabel.text = jackpotString!
        self.jackpotAmtLabel.fontColor = UIColor.yellow
        self.jackpotAmtLabel.fontSize = 72
        self.jackpotAmtLabel.fontName = "Noteworthy-Bold "
        self.jackpotAmtLabel.position = CGPoint(x:self.frame.midX, y:self.frame.height / 5.5)
        self.addChild(jackpotAmtLabel)
        
        self.balanceLabel.text = "BALANCE: "
        self.balanceLabel.fontColor = UIColor.blue
        self.balanceLabel.fontSize = 32
        self.balanceLabel.fontName = "Optima-ExtraBlack"
        self.balanceLabel.position = CGPoint(x:self.frame.midX - balanceLabel.frame.width, y:-300)
        self.addChild(balanceLabel)
        
        self.balanceAmtLabel.text = "\(self.currentBalance)"
        self.balanceAmtLabel.fontColor = UIColor.blue
        self.balanceAmtLabel.fontSize = 48
        self.balanceAmtLabel.fontName = "Optima-ExtraBlack"
        self.balanceAmtLabel.position = CGPoint(x:self.frame.midX, y:-300)
        self.addChild(balanceAmtLabel)
        
        self.wheelHouse = SKSpriteNode(imageNamed: "GDf8f")
        self.wheelHouse.xScale = self.wheelHouse.xScale * 1.75
        self.wheelHouse.yScale = 1.5
        self.wheelHouse.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        self.addChild(wheelHouse)
        
        self.bet1Button = SKSpriteNode(imageNamed: "bet1")
        self.bet1Button.position = CGPoint(x:self.frame.minX + bet1Button.size.width, y:-400)
        self.addChild(bet1Button)
        self.bet10Button = SKSpriteNode(imageNamed: "bet10")
        self.bet10Button.position = CGPoint(x:self.frame.midX, y:-400)
        self.addChild(bet10Button)
        self.bet100Button = SKSpriteNode(imageNamed: "bet100")
        self.bet100Button.position = CGPoint(x:self.frame.maxX - bet100Button.size.width, y:-400)
        self.addChild(bet100Button)
        
        self.spinButton = SKSpriteNode(imageNamed: "spinButton3")
        self.spinButton.position = CGPoint(x:self.frame.midX, y:-500)
        self.addChild(spinButton)
        
        self.quitButton = SKSpriteNode(imageNamed: "quit")
        self.quitButton.position = CGPoint(x:self.frame.midX - self.quitButton.size.width , y:-600)
        self.addChild(quitButton)
        
        self.resetButton = SKSpriteNode(imageNamed: "reset")
        self.resetButton.position = CGPoint(x:self.frame.midX + self.resetButton.size.width, y:-600)
        self.addChild(resetButton)
        
        self.wheel1_sprite = SKSpriteNode(texture:scrambleArray(array: spriteArray)[0]);
        self.wheel1_sprite.position = CGPoint(x:self.frame.minX + wheel1_sprite.size.width * 1.4, y:self.frame.midY)
        self.addChild(wheel1_sprite)
        
        self.wheel2_sprite = SKSpriteNode(texture:scrambleArray(array: spriteArray)[0])
        self.wheel2_sprite.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        self.addChild(wheel2_sprite)
        
        self.wheel3_sprite = SKSpriteNode(texture:scrambleArray(array: spriteArray)[0])
        self.wheel3_sprite.position = CGPoint(x: self.frame.maxX - wheel3_sprite.size.width * 1.4, y: self.frame.midY)
        self.addChild(wheel3_sprite)
        
        activateBet1()
    }
    
    func spinWheels(){
        
        if(self.currentBalance > self.currentBet){
        
        let spinAction1 = SKAction.animate(with: scrambleArray(array: spriteArray), timePerFrame: 0.05)
        let spinAction2 = SKAction.animate(with: scrambleArray(array: spriteArray), timePerFrame: 0.05)
        let spinAction3 = SKAction.animate(with: scrambleArray(array: spriteArray), timePerFrame: 0.05)
        let spinSlot1 = SKAction.repeat(spinAction1, count: 2)
        let spinSlot2 = SKAction.repeat(spinAction2, count: 3)
        let spinSlot3 = SKAction.repeat(spinAction3, count: 4)
        
        self.wheel1_sprite.run(spinSlot1)
        self.wheel2_sprite.run(spinSlot2)
        self.wheel3_sprite.run(spinSlot3, completion: {
            self.checkForWin()
        })
        }
    
    }
    
    func checkForWin(){
    
        if(self.wheel1_sprite.texture?.description == self.wheel2_sprite.texture?.description && self.wheel1_sprite.texture?.description == self.wheel3_sprite.texture?.description){
            print("You WIN!!!!!!!!!")
            if(self.wheel1_sprite.texture?.description == SKTexture(imageNamed: "orange").description){
                self.currentBalance += self.currentBet * 20
                self.balanceAmtLabel.text = "\(self.currentBalance)"
            }else if(self.wheel1_sprite.texture?.description == SKTexture(imageNamed: "banana").description){
                self.currentBalance += self.currentBet * 10
                self.balanceAmtLabel.text = "\(self.currentBalance)"
            }else if(self.wheel1_sprite.texture?.description == SKTexture(imageNamed: "cherry").description){
                self.currentBalance += self.currentBet * 100
                self.balanceAmtLabel.text = "\(self.currentBalance)"
            }
            else if(self.wheel1_sprite.texture?.description == SKTexture(imageNamed: "grapes").description){
                self.currentBalance += self.currentBet * 100
                self.balanceAmtLabel.text = "\(self.currentBalance)"
            }else if(self.wheel1_sprite.texture?.description == SKTexture(imageNamed: "bell").description){
                self.currentBalance += self.currentBet * 100
                self.balanceAmtLabel.text = "\(self.currentBalance)"
            }
            else if(self.wheel1_sprite.texture?.description == SKTexture(imageNamed: "bar").description){
                self.currentBalance += self.currentBet * 1000
                self.balanceAmtLabel.text = "\(self.currentBalance)"
            }
            else if(self.wheel1_sprite.texture?.description == SKTexture(imageNamed: "seven").description){
                self.currentBalance += self.jackpot
                self.balanceAmtLabel.text = "\(self.currentBalance)"
            }
        }else{
            print("Loser")
            if(self.currentBalance > self.currentBet)
            {
            self.currentBalance = self.currentBalance - self.currentBet
            self.balanceAmtLabel.text = "\(self.currentBalance)"
            self.jackpot += self.currentBet
            var jackpotString = formatter.string(for: self.jackpot)
            self.jackpotAmtLabel.text = jackpotString!
            }
        }
    
    }
    
    func scrambleArray(array: Array<SKTexture>) -> (Array<SKTexture>){
    
        var shuffledSpriteArray = Array<SKTexture>();
        shuffledSpriteArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array) as! Array<SKTexture>
        return shuffledSpriteArray
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
     
    }
    
    func touchUp(atPoint pos : CGPoint) {
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self))
            let touchLocation = t.location(in: self)
            
            if spinButton.contains(touchLocation) {
                print("tapped!")
                spinWheels()
            }
            
            if wheelHouse.contains(touchLocation) {
                print("tapped!")
                spinWheels()
            }
            
            if bet1Button.contains(touchLocation) {
                activateBet1()
            }
            if bet10Button.contains(touchLocation) {
                activateBet10()
            }
            if bet100Button.contains(touchLocation) {
                activateBet100()
            }
        }
    }
    
    func activateBet1(){
        bet1Button.texture = SKTexture(imageNamed: "bet1_active")
        bet10Button.texture = SKTexture(imageNamed: "bet10")
        bet100Button.texture = SKTexture(imageNamed: "bet100")
        self.currentBet = 1
    }
    
    func activateBet10(){
        bet10Button.texture = SKTexture(imageNamed: "bet10_active")
        bet1Button.texture = SKTexture(imageNamed: "bet1")
        bet100Button.texture = SKTexture(imageNamed: "bet100")
        self.currentBet = 10
    }
    
    func activateBet100(){
        bet100Button.texture = SKTexture(imageNamed: "bet100_active")
        bet1Button.texture = SKTexture(imageNamed: "bet1")
        bet10Button.texture = SKTexture(imageNamed: "bet10")
        self.currentBet = 100
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
