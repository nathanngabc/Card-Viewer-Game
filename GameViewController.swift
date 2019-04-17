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

import UIKit
import SpriteKit
import AVFoundation
class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /*
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    */
    /*
    var arrayRegular :[Bool] = [Bool]()
    var arrayImages :[UIImageView] = [UIImageView]()
   */
    
  override func viewDidLoad() {

    super.viewDidLoad()

    let scene = GameScene(size: CGSize(width: 1024, height: 768))
    let skView = self.view as! SKView
    
  
    skView.ignoresSiblingOrder = false
    scene.scaleMode = .aspectFill
    skView.presentScene(scene)
    
    

  }
  
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    /*
    func swipedUp () {
        print ("here at swiped up")
        
        for i in 0..<arrayImages.count {
            if (arrayRegular[i]==true) {
                currentGame.swipeUp (cardToEnlarge: i);
                
            }
            arrayImages[i].isUserInteractionEnabled=true;
            arrayImages[i].isHidden=false;
            
            arrayRegular[i]=false;
        }
        swipeUpRec.isEnabled = false;
      
    }
    
    func swipedLeft () {
        for i in 0..<arrayRegular.count {
            if (arrayRegular[i]==true) {
                if (i != arrayRegular.count-1) {
                    currentGame.swipedLeft(cardToEnlarge: i);
                    arrayRegular[i]=false;
                    arrayRegular[i+1]=true;
                }
            }
        }
    }
    
    func swipedRight() {
        for i in 0..<arrayRegular.count {
            if (arrayRegular[i]==true) {
                if (i != 0) {
                currentGame.swipedRight (cardToEnlarge: i);
                arrayRegular[i]=false;
                arrayRegular[i-1]=true;
                }
            }
        }
    }
  
    @IBAction func handleTap (recognizer: UITapGestureRecognizer) {
        
        Test.isUserInteractionEnabled=false;
        Test.isHidden=true;
        test2.isUserInteractionEnabled=false;
        test2.isHidden=true;
        arrayRegular[0]=true;
        currentGame.enlarge(cardToEnlarge: 0)
        print ("here")
        swipeUpRec.isEnabled = true;
    }
    
   
    @IBAction func dragontaptest(_ sender: UITapGestureRecognizer) {
        test2.isUserInteractionEnabled=false;
        test2.isHidden=true;
        Test.isUserInteractionEnabled=false;
        Test.isHidden=true;
        arrayRegular[1]=true;
        currentGame.enlarge(cardToEnlarge: 1)
        print ("here")
        swipeUpRec.isEnabled = true;
    }
    
    @IBAction func testChange(_ sender: UIButton) {
        Test.image = #imageLiteral(resourceName: "card_creature_wolf_large")
    }
    */
}
