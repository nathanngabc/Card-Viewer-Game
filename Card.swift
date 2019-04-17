/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit


class Card : SKSpriteNode {
    var frontTexture :SKTexture
    var backTexture :SKTexture
    
    
    var faceUp = true
    var savedPosition = CGPoint.zero
    var enlarged = false
    
    let largeTextureFilename :String
    var largeTexture :SKTexture?
    
    var pos1 = 0;
    var pos2 = 0;
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(fr: String, bk: String) {
        frontTexture = SKTexture(imageNamed: fr)
        
        backTexture = SKTexture (imageNamed: bk)
        
        largeTextureFilename = fr;
        largeTexture = SKTexture (imageNamed: largeTextureFilename)
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
    }
    
    
    func flip(fast: Bool) {
        var firstHalfFlip: SKAction;
        var secondHalfFlip: SKAction;
        if (!fast) {
            firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.09)
            secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.09)
        }
        else {
            firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.0)
            secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.0)
        }
        
        
        setScale(1.0)
        
        if faceUp {
            run(firstHalfFlip, completion: {
                self.texture = self.backTexture
                
                self.run(secondHalfFlip)
            })
        } else {
            run(firstHalfFlip, completion: {
                self.texture = self.largeTexture
                
                self.run(secondHalfFlip)
            })
        }
        faceUp = !faceUp
    }
    
    func enlarge() {
        faceUp = true
        savedPosition = position
        
        if largeTexture != nil {
            texture = largeTexture
        } else {
            largeTexture = SKTexture(imageNamed: largeTextureFilename)
            texture = largeTexture
        }
        
        zPosition = CardLevel.enlarged.rawValue
        
        if let parent = parent {
            removeAllActions()
            zRotation = 0
            let newPosition = CGPoint(x: parent.frame.midX, y: parent.frame.midY)
            let slide = SKAction.move(to: newPosition, duration:0)
            // let scaleUp = SKAction.scale(to: 4.5, duration:0)
            run(SKAction.group([slide]))
        }
        
    }
    
    func swipeUp () {
        faceUp = true
        if let parent = parent {
            let newPosition = CGPoint (x: parent.frame.midX, y: parent.frame.height*2);
            let slide = SKAction.move(to:newPosition, duration: 0.4);
            run(SKAction.group([slide]));
        }
    }
    func swipeRight () {
        if let parent = parent {
            let slide = SKAction.moveBy (x: parent.frame.width/2 + frame.width, y: 0, duration: 0.3)
            run(SKAction.group([slide]));
        }
    }
    
    func swipeLeft (first: Bool) {
        
        if let parent = parent {
            if first {
                let newPosition = CGPoint(x: parent.frame.midX, y: parent.frame.midY)
                let slide = SKAction.move(to: newPosition, duration:0.3)
                run(SKAction.group([slide]));
            }
            else {
                let newPosition = CGPoint(x: -frame.width, y: parent.frame.midY)
                let slide = SKAction.move(to: newPosition, duration:0.3)
                run(SKAction.group([slide]))
            }
        }
        
    }
    
    func positionLeft(faceUp1: Bool) {
        if let parent = parent {
            
            let newPosition = CGPoint(x: -frame.width, y: parent.frame.midY)
            let slide = SKAction.move(to: newPosition, duration:0)
            //let scaleUp = SKAction.scale(to: 5.0, duration:0)
            if (faceUp) {
                faceUp = !faceUp
                self.texture = self.backTexture
            }
            if (faceUp1) {
                faceUp = true
                self.texture = self.largeTexture
            }
            run(SKAction.group([slide]))
        }
    }
    
    func positionRight(faceUp1: Bool) {
        if let parent = parent {
            
            let newPosition = CGPoint(x: parent.frame.width + self.frame.width, y: parent.frame.midY)
            let slide = SKAction.move(to: newPosition, duration:0)
            if (faceUp) {
                faceUp = !faceUp
                self.texture = self.backTexture
            }
            if (faceUp1) {
                faceUp = true
                self.texture = self.largeTexture
            }
            run(SKAction.group([slide]))
        }
    }
    
}
