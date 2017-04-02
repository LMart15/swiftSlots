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
    
    //let textureAtlas = SKTextureAtlas(named:"slotImages")
    var spriteArray = Array<SKTexture>();
    
    var wheel1_sprite = SKSpriteNode()
    var wheel2_sprite = SKSpriteNode()
    var wheel3_sprite = SKSpriteNode()
    
    var spinButton = UIButton()
    
   
    override func didMove(to view: SKView) {
        
        
        spriteArray.append(SKTexture(imageNamed:"banana"));
        spriteArray.append(SKTexture(imageNamed:"bar"));
        spriteArray.append(SKTexture(imageNamed:"bell"));
        spriteArray.append(SKTexture(imageNamed:"cherry"));
        spriteArray.append(SKTexture(imageNamed:"grapes"));
        spriteArray.append(SKTexture(imageNamed:"orange"));
        spriteArray.append(SKTexture(imageNamed:"seven"));
        
        self.wheel1_sprite = SKSpriteNode(texture:scrambleArray(array: spriteArray)[0]);
        self.wheel1_sprite.position = CGPoint(x:self.frame.minX + wheel1_sprite.size.width, y:self.frame.midY)
        self.addChild(wheel1_sprite)
        
        self.wheel2_sprite = SKSpriteNode(texture:scrambleArray(array: spriteArray)[0])
        self.wheel2_sprite.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        self.addChild(wheel2_sprite)
        
        self.wheel3_sprite = SKSpriteNode(texture:scrambleArray(array: spriteArray)[0])
        self.wheel3_sprite.position = CGPoint(x: self.frame.maxX - wheel3_sprite.size.width, y: self.frame.midY)
        self.addChild(wheel3_sprite)
        
    }
    
    func spinWheels(){
        
        let spinAction1 = SKAction.animate(with: scrambleArray(array: spriteArray), timePerFrame: 0.05)
        let spinAction2 = SKAction.animate(with: scrambleArray(array: spriteArray), timePerFrame: 0.05)
        let spinAction3 = SKAction.animate(with: scrambleArray(array: spriteArray), timePerFrame: 0.05)
        let spinSlot1 = SKAction.repeat(spinAction1, count: 10)
        let spinSlot2 = SKAction.repeat(spinAction2, count: 13)
        let spinSlot3 = SKAction.repeat(spinAction3, count: 16)
        
        self.wheel1_sprite.run(spinSlot1)
        self.wheel2_sprite.run(spinSlot2)
        self.wheel3_sprite.run(spinSlot3)
        
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
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
