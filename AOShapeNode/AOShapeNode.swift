//
//  AOShapeNode.swift
//  TestGame
//                                                         \|/
//                                                         @ @
//  +--------------------------------------------------oOO-(_)-OOo---+
//  Created by Alessandro Ornano on 24/06/16.
//  Copyright © 2016 Alessandro Ornano. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class AOShapeNode: SKNode {
    var currentScene: SKScene!
    var canvas = SKShapeNode()
    var segment = SKShapeNode()
    var pool:[SKShapeNode]!
    var poolSize: Int = 50 // big number to improve performance
    var segmentLineWidth: CGFloat = 3
    
    init(currentScene scene:SKScene,nodeSize size: CGSize) {
        
        super.init()
        print("---");
        print("∙ \(self.dynamicType)")
        print("---")
        self.userInteractionEnabled = true
        self.currentScene = scene
        self.addChild(canvas)
        pool = [SKShapeNode]()
        for _ in 0..<poolSize
        {
            let segment = SKShapeNode()
            segment.strokeColor = UIColor.blackColor()
            segment.glowWidth = 1
            segment.lineCap = CGLineCap(rawValue: 1)!
            pool.append(segment)
        }
    }
    
    func getShapeNode() -> SKShapeNode {
        if(pool.count == 0)
        {
            self.cacheSegments()
        }
        let segment = pool.first
        pool.removeFirst()
        return segment!
    }
    
    func drawSegmentFromPoint(fromPoint:CGPoint, toPoint:CGPoint)->CGPoint {
        let curSegment = self.getShapeNode()
        let path = CGPathCreateMutable()
        curSegment.lineWidth = segmentLineWidth
        curSegment.strokeColor = SKColor.blackColor()
        curSegment.glowWidth = 1
        curSegment.lineCap = CGLineCap(rawValue: 1)!
        curSegment.name = "segment"
        CGPathMoveToPoint(path, nil, fromPoint.x, fromPoint.y)
        CGPathAddLineToPoint(path, nil, toPoint.x, toPoint.y)
        curSegment.path = path
        canvas.addChild(curSegment)
        return toPoint
    }
    
    func cacheSegments() {
        if let cacheTexture = self.currentScene.view?.textureFromNode(self) {
            let resizeAction = SKAction.setTexture(cacheTexture, resize: true)
            canvas.runAction(resizeAction)
        }
        canvas.enumerateChildNodesWithName("segment", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            self.pool.append(node as! SKShapeNode)
            node.removeFromParent()
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}