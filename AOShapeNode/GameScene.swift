//
//  GameScene.swift
//  AOShapeNode
//                                                         \|/
//                                                         @ @
//  +--------------------------------------------------oOO-(_)-OOo---+
//  Created by Alessandro Ornano on 25/06/16.
//  Copyright (c) 2016 Alessandro Ornano. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var line : AOShapeNode!
    var lastPoint :CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        line = AOShapeNode.init(currentScene: self, nodeSize: self.size)
        self.addChild(line)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        line.cacheSegments()
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            lastPoint = location
            lastPoint = line.drawSegmentFromPoint(lastPoint, toPoint: location)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch moved */
        for touch in touches {
            let location = touch.locationInNode(self)
            lastPoint = line.drawSegmentFromPoint(lastPoint, toPoint: location)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

