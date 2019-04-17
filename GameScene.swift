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
import AVFoundation


enum CardLevel :CGFloat {
    case board = 10
    case moving = 100
    case enlarged = 200
}
enum MyError: Error {
    case FoundNil(String)
}

class GameScene: SKScene {
    /// Scroll view
    
    public var arrayEnlarged :[Card] = [Card]()
    
    public var arrayRegular :[Card] = [Card]()
    
    public var first = false;
    public var menuScalingFont: CGFloat = 0
    
    //eg. this is what it looks like with a second page size added
    public var pageSizes: [CGSize] = [CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350), CGSize(width: 200, height: 350)]
    
    
    
    //card initialization
    
    var cardPage1 :[cardStorage] = [cardStorage(f: "wv", b: "1b"), cardStorage(f: "wv", b: "2b"), cardStorage(f: "wv", b: "3b"), cardStorage(f: "wv", b: "4b"), cardStorage(f: "wv", b: "5b"), cardStorage(f: "wv", b: "6b"), cardStorage(f: "wv", b: "7b"), cardStorage(f: "wv", b: "8b"), cardStorage(f: "wv", b: "9b"), cardStorage(f: "10f", b: "10b"), cardStorage(f: "11f", b: "11b"), cardStorage(f: "12f", b: "12b"), cardStorage(f: "13f", b: "13b"), cardStorage(f: "14f", b: "14b"), cardStorage(f: "15f", b: "15b"), cardStorage(f: "16f", b: "16b"), cardStorage(f: "16f", b: "16b"), cardStorage(f: "16f", b: "16b"), cardStorage(f: "wv", b: "16b")]
    
    var cardPage2 :[cardStorage] = [cardStorage(f: "wv", b: "1b")]
    var cardPage3 :[cardStorage] = [cardStorage(f: "wv", b: "1b")]
    var cardPage4 :[cardStorage] = [cardStorage(f: "wv", b: "1b")]
    var cardPage5 :[cardStorage] = [cardStorage(f: "wv", b: "1b")]
    var cardPage6 :[cardStorage] = [cardStorage(f: "13f", b: "1b")]
    var cardPage7 :[cardStorage] = [cardStorage(f: "wv", b: "1b")]
    var cardPage8 :[cardStorage] = [cardStorage(f: "wv", b: "1b")]
    var cardPage9 :[cardStorage] = [cardStorage(f: "wv", b: "1b")]
    var cardPage10 :[cardStorage] = [cardStorage(f: "12f", b: "1b")]
    
    
    public var pagesCollection: [[cardStorage]] = [];
    
    
    public var backGrounds: [String] = ["bg_blank", "bg_blank", "bg_blank", "bg_blank", "bg_blank", "bg_blank", "bg_blank", "bg_blank", "bg_blank", "bg_blank"]
    
    public var menu_icon = SKSpriteNode (imageNamed:"menu_icon")
    
    
    
    public var audioPlayer: AVAudioPlayer!
    public var audioQueue: AVQueuePlayer!;
    
    public var menuScreen = SKSpriteNode(imageNamed: "menu")
    public var cardWidth: CGFloat = 0
    public var cardHeight: CGFloat = 0;
    
    public var button_Height = 0;
    
    public var thumbnails: [String] = ["Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test", "wv", "Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test", "Thumbnail test"]
    public var thumbnailSprites: [SKSpriteNode] = [];
    
    public var bg: SKSpriteNode!
    public var menuPageNo = 0;
    
    public var currentMenuPage = 0;
    
    public var currentEnlargedCard = 0
    
    
    let tapRec = UITapGestureRecognizer()
    let longPress = UILongPressGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    
    
    let button_back = SKSpriteNode (imageNamed: "button_back")
    let button_foward = SKSpriteNode (imageNamed: "button_forward")
    
    var currentOutlinePage = 0;
    var menuTappedOn = 0;
    
    var currentPage = 1
    var lastpage = false;
    
    var onCreditsScene = false;
    
    
    public var showUpTo = 0;
    
    var useHeightToScale: [Bool] = [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    override func didMove(to view: SKView) {
        
        scene?.size = (self.view?.frame.size)!
        
        bg = SKSpriteNode()
        bg.size.width = self.size.width
        bg.size.height = self.size.height
        bg.texture = SKTexture(imageNamed: backGrounds[0])
        bg.anchorPoint = CGPoint.zero
        bg.position = CGPoint.zero
        addChild(bg)
        
        let session = AVAudioSession.sharedInstance()
        try!  session.setCategory(AVAudioSessionCategorySoloAmbient)
        
        addButtons();
        //initial initliaztion
        for i in 0..<9 {
            let tempCard = Card (fr: cardPage1[i].front, bk: cardPage1[i].back)
            arrayRegular.append (tempCard)
            addChild (arrayRegular[i])
            /*
            arrayRegular[i].size = pageSizes[0]
            arrayRegular[i].size.height = arrayRegular[i].size.height * (self.size.width / arrayRegular[i].size.width)/3 * 23/25;
            arrayRegular[i].size.width = arrayRegular[i].size.width * (self.size.width / arrayRegular[i].size.width)/3 * 23/25;
            
            
            cardWidth = CGFloat (arrayRegular[i].size.width);
            cardHeight = CGFloat (arrayRegular[i].size.height);
            arrayRegular[i].anchorPoint = CGPoint (x:0, y:1)
            arrayRegular[i].position = self.convertPoint(fromView: returnLocation (cardLoc: i))
            
 */
        }
        
        
        
        setCollection();
        print ("hi")
        setSwipes ();
        setSprites();
        
        let tempCardEnlarged = Card (fr: pagesCollection[currentOutlinePage][0].front, bk: pagesCollection[currentOutlinePage][0].back)
        arrayEnlarged.append (tempCardEnlarged)
        arrayEnlarged[0].position = CGPoint (x: 10000, y: 50000)
        arrayEnlarged[0].backTexture=SKTexture(imageNamed: pagesCollection[currentOutlinePage][1].back)
        arrayEnlarged[0].largeTexture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][1].front)
        arrayEnlarged[0].size = pageSizes[currentOutlinePage]
        var constantMultiple = self.size.width / arrayEnlarged[0].size.width * 97/100;
        arrayEnlarged[0].size.width = arrayEnlarged[0].size.width * constantMultiple
        arrayEnlarged[0].size.height = arrayEnlarged[0].size.height * constantMultiple;
        addChild (tempCardEnlarged)
        
        let tempCardEnlarged2 = Card (fr: pagesCollection[currentOutlinePage][0].front, bk: pagesCollection[currentOutlinePage][0].back)
        arrayEnlarged.append (tempCardEnlarged2)
        arrayEnlarged[1].position = CGPoint (x: 10000, y: 50000)
        arrayEnlarged[1].backTexture=SKTexture(imageNamed: pagesCollection[currentOutlinePage][1].back)
        arrayEnlarged[1].largeTexture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][1].front)
        arrayEnlarged[1].size = pageSizes[currentOutlinePage]
        constantMultiple = self.size.width / arrayEnlarged[1].size.width * 97/100;
        arrayEnlarged[1].size.width = arrayEnlarged[1].size.width * constantMultiple
        arrayEnlarged[1].size.height = arrayEnlarged[1].size.height * constantMultiple;
        addChild (tempCardEnlarged2)
        
        menuScreen.anchorPoint = CGPoint (x: 0, y: 1)
        menuScreen.position = self.convertPoint(fromView: CGPoint (x: 0, y: -5))
        menuScreen.isHidden = true;
        menuScreen.size.width = (self.size.width);
        menuScreen.size.height = self.size.height + 5;
        
        addChild(menuScreen);
        setMenuLabels();
        popUpMenu();
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(string: "hi")!)
            
        }
        catch let error as NSError { print(error.debugDescription)
            
        }
        button_foward.setScale(1)
        let scaleFowardButton = self.frame.height / 10 / button_foward.frame.height
        button_foward.setScale(scaleFowardButton)
    }
    
    
    func setCollection () {
        pagesCollection = [cardPage1, cardPage2, cardPage3, cardPage4, cardPage5, cardPage6, cardPage7, cardPage8, cardPage9, cardPage10];
    }
    
    func setMenuLabels () {
        for i in 0..<7 {
            
            let thumbnailSprite = SKSpriteNode();
            thumbnailSprite.size.width = self.frame.width
            thumbnailSprite.size.height = self.frame.height / 7
            if (i > 0 && i < 6) {
                thumbnailSprite.texture = SKTexture(imageNamed: thumbnails[i-1])
            }
            else if (i == 0) {
                thumbnailSprite.texture = SKTexture(imageNamed: "main_title")
            }
            else if (i == 6) {
                let down_arrow = SKSpriteNode(imageNamed: "down_arrow")
                let up_arrow = SKSpriteNode(imageNamed: "up_arrow")
                

            
                
                //down_arrow.size.width = self.frame.width / 4
                //down_arrow.size.height = self.frame.height / 7
                
              
               // up_arrow.size.width = self.frame.width / 4
                //up_arrow.size.height = self.frame.height / 7
                
                down_arrow.texture = SKTexture (imageNamed: "down_arrow")
                up_arrow.texture = SKTexture (imageNamed: "up_arrow")
                
                let scalingFactorUp =  self.frame.height / 10 / up_arrow.frame.height
                let scalingFactorDown = self.frame.height / 10 /  down_arrow.frame.height
                down_arrow.setScale(scalingFactorDown)
                up_arrow.setScale(scalingFactorUp)
                
                var y = self.frame.height - CGFloat(i*Int(self.frame.height)/7)
                y = y - ((self.frame.height/7 - down_arrow.frame.height)/2)
                
                var y0 = self.frame.height - CGFloat(0*Int(self.frame.height)/7)
                y0 = y0 - ((self.frame.height/7 - up_arrow.frame.height)/2)

                down_arrow.anchorPoint = CGPoint(x: 0.5, y: 1)
                down_arrow.position = CGPoint(x: self.frame.width * 1 / 2, y: y)
                
                up_arrow.anchorPoint = CGPoint(x: 0.5, y: 1)
                up_arrow.position = CGPoint (x: self.frame.width * 1 / 2, y: y0)
                
                
                addChild(up_arrow)
                addChild(down_arrow)
                thumbnailSprites.append(up_arrow)
                thumbnailSprites.append(down_arrow)
                up_arrow.isHidden = true
                
                if (thumbnails.count <= 5) {
                    down_arrow.isHidden = true;
                }
            }
            thumbnailSprite.anchorPoint = CGPoint (x: 0.5, y: 1)
            
            
            var y = self.frame.height - CGFloat(i*Int(self.frame.height)/7)
            y = y - ((self.frame.height/7 - thumbnailSprite.frame.height)/2)
            thumbnailSprite.position = CGPoint(x: self.frame.width / 2, y: y)
            thumbnailSprite.isHidden = false;
            
            if (i != 6) {
                addChild(thumbnailSprite)
                thumbnailSprites.append((thumbnailSprite))
            }
            
        }
    }
    
    func addButtons () {
        button_foward.anchorPoint = CGPoint (x:1, y:0.5);
        button_foward.position = self.convertPoint(fromView: CGPoint(x:  (self.view?.bounds.size.width)! * 23 / 25, y: (self.view?.bounds.size.height)! - (self.view?.bounds.size.height)! / 10 * 2 / 3))
        let scaleFowardButton = self.frame.height / 14 / button_foward.frame.height
        button_foward.setScale(scaleFowardButton)
        addChild (button_foward)
        button_back.anchorPoint = CGPoint (x:0, y:0.5);
        let scaleBackButton = self.frame.height / 10 / button_back.frame.height
        button_back.setScale(scaleBackButton);
        button_back.position =  CGPoint(x: 2 / 25 * (self.view?.bounds.size.width)!, y: button_foward.position.y)
        addChild(button_back)
        button_back.isHidden = true;
        let scaleMenuButton = self.frame.height / 10 / menu_icon.frame.height
        menu_icon.anchorPoint = CGPoint (x:0.5, y:0.5)
        menu_icon.setScale(scaleMenuButton)
        menu_icon.position = CGPoint(x: self.frame.width/2, y: button_foward.position.y)
        
        addChild (menu_icon)
    }
    
    
    func setSprites () {
        //arrayEnlarged.removeAll();
        
        for i in 0..<pagesCollection[currentOutlinePage].count {
            
            if (i<9) {
                arrayRegular[i].texture = SKTexture(imageNamed: pagesCollection[currentOutlinePage][i].front)
                arrayRegular[i].backTexture=SKTexture(imageNamed: pagesCollection[currentOutlinePage][i].back)
                arrayRegular[i].size = pageSizes[currentOutlinePage]
                var constantScale = (self.size.width / arrayRegular[i].size.width)/3 * 23/25;
                print(constantScale)
                if (useHeightToScale[currentOutlinePage] == true) {
                    constantScale = (self.size.height / arrayRegular[i].size.height/3) * 18/25;
                    print(constantScale)
                }
                arrayRegular[i].size.height = arrayRegular[i].size.height * constantScale
                arrayRegular[i].size.width = arrayRegular[i].size.width * constantScale
                
                cardWidth = CGFloat (arrayRegular[i].size.width);
                cardHeight = CGFloat (arrayRegular[i].size.height);
                arrayRegular[i].anchorPoint = CGPoint (x:0, y:1)
                arrayRegular[i].position = self.convertPoint(fromView: returnLocation (cardLoc: i))
                
                arrayRegular[i].isHidden = false;
            }
            
          
            
            
            if (pagesCollection[currentOutlinePage].count < 9) {
                lastpage = true;
            }
            else {
                lastpage = false;
            }
        }
        
       

        
        
        if (pagesCollection[currentOutlinePage].count<9) {
            for i in pagesCollection[currentOutlinePage].count..<9 {
                arrayRegular[i].isHidden = true;
            }
        }
    }
    
    func returnLocation (cardLoc: Int) -> CGPoint{
        var locationToReturn: CGPoint = CGPoint (x: 0, y: 0);
        
        var x = CGFloat (cardLoc%3) * self.frame.width/3;
        x = x + (self.size.width/3-cardWidth)/2
        var y = CGFloat (cardLoc/3) * (self.frame.height - button_foward.frame.height * 2)/3
        y = y + (self.size.height/3 - cardHeight)/2;
        locationToReturn = CGPoint (x: x, y: y);
        
        return locationToReturn;
    }
    
    func setSwipes () {
        //set up swipes
        
        swipeUpRec.addTarget(self, action: #selector(swipeUp))
        swipeUpRec.direction = .up
        self.view?.addGestureRecognizer(swipeUpRec)
        swipeUpRec.isEnabled = true;
        
        swipeDownRec.addTarget(self, action: #selector(swipeDown))
        swipeDownRec.direction = .down
        self.view?.addGestureRecognizer(swipeDownRec)
        swipeDownRec.isEnabled = true;
        
        swipeRightRec.addTarget(self, action: #selector(swipedRight))
        swipeRightRec.direction = .right
        self.view?.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(swipedLeft))
        swipeLeftRec.direction = .left
        self.view?.addGestureRecognizer(swipeLeftRec)
        
        tapRec.addTarget(self, action:#selector(tappedView(sender:)))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view?.addGestureRecognizer(tapRec)
        
        longPress.addTarget(self, action:#selector(heldView(sender:)))
        longPress.numberOfTouchesRequired = 1
        longPress.minimumPressDuration = 50
        longPress.allowableMovement = 0.0
        self.view?.addGestureRecognizer(longPress)
    }
    
    func createPicEnlarged (currentCard: Int) {
        arrayEnlarged [currentCard].position = CGPoint (x: 1000, y: 1000);
        addChild (arrayEnlarged[currentCard])
        return;
    }
    
    
    @objc func swipeUp() {
        print ("swiping up")
        if (onCreditsScene == false) {
            print ("swipingUp")
            var enlarged = false;
            for i in 0..<arrayEnlarged.count {
                if (arrayEnlarged[i].enlarged) {
                    arrayEnlarged[i].swipeUp()
                    arrayEnlarged[i].enlarged=false;
                    
                    audioQueue?.removeAllItems();
                    playSound(e: "cardClose.wav")
                    
                    self.removeAllActions()
                    showAll();
                    enlarged = true;
                }
            }
            
            if (menuScreen.isHidden == false && onCreditsScene == false) {
                if (thumbnails.count > (menuPageNo+1) * 5) {
                    menuPageNo = menuPageNo + 1;
                    playSound(e: "pageSwipe.wav")
                    currentMenuPage = currentMenuPage + 1;
                    
                    popUpMenu();
                }
            }
            else if (enlarged == false && onCreditsScene == false) {
                playSound(e: "pageOpenClose.wav")
                currentPage = 1;
                currentMenuPage = 0;
                currentMenuPage = currentOutlinePage / 5
                menuPageNo = currentOutlinePage / 5
                popUpMenu();
            }
            
        }
        if (onCreditsScene == true){
            popUpMenu();
            showAll()
            
            menuScreen.isHidden = false;
            
            bg.texture = SKTexture(imageNamed: backGrounds[currentOutlinePage])
            onCreditsScene = false;
            currentPage = 1;
            playSound(e: "menuTitlePageClose.wav")
        }
    }
    
    @objc func swipeDown() {
        print ("swipingDown")
        if (menuScreen.isHidden == false && onCreditsScene == false) {
            if (menuPageNo != 0) {
                menuPageNo = menuPageNo - 1;
                
                currentMenuPage = currentMenuPage - 1;
                playSound(e: "pageSwipe.wav")
                popUpMenu();
            }
        }
    }
    
    func nextPage () {
        if (menuScreen.isHidden == true && onCreditsScene == false) {
            var enlargedRN = false;
            for i in 0..<arrayEnlarged.count {
                if (arrayEnlarged[i].enlarged) {
                    enlargedRN = true;
                }
            }
            for i in currentPage*9..<currentPage*9+9 {
                
                if (i >= pagesCollection[currentOutlinePage].count) {
                    if (lastpage == false) {
                        showUpTo = i - currentPage * 9
                    }
                    arrayRegular[i%9].isHidden = true;
                    arrayRegular[i%9].isUserInteractionEnabled = false;
                    lastpage = true
                    button_foward.isHidden = true;
                    
                    
                    
                }
                else {
                    button_back.isHidden = false;
                    button_foward.isHidden = false;
                    arrayRegular[i%9].texture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][i].front)
                    arrayRegular[i%9].backTexture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][i].back)
                    arrayRegular[i%9].largeTexture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][i].front)
                    arrayRegular[i%9].size = pageSizes[currentOutlinePage]
                    var constantScale = (self.size.width / arrayRegular[i%9].size.width)/3 * 23/25;
                    if (useHeightToScale[currentOutlinePage] == true) {
                        constantScale = (self.size.height / arrayRegular[i%9].size.height)/3 * 18/25;
                    }
                    arrayRegular[i%9].size.height = arrayRegular[i%9].size.height * constantScale
                    arrayRegular[i%9].size.width = arrayRegular[i%9].size.width * constantScale
                }
            }
            if (enlargedRN) {
                button_back.isHidden = true;
                button_foward.isHidden = true;
            }
            else if (enlargedRN == false && lastpage == true) {
                button_back.isHidden = false;
                button_foward.isHidden = true;
            }
            else if (enlargedRN == false && lastpage == false) {
                button_back.isHidden = false;
                button_foward.isHidden = false;
            }
            currentPage=currentPage + 1;
        }
    }
    
    func previousPage () {
        if (menuScreen.isHidden == true) {
            for i in (currentPage-1) * 9 - 9 ..< (currentPage-1) * 9 {
                showUpTo = 9;
                arrayRegular[i%9].texture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][i].front)
                var enlarged = false;
                for j in 0..<arrayEnlarged.count {
                    if (arrayEnlarged[j].enlarged) {
                        enlarged = true
                    }
                }
                if (enlarged == false) {
                    arrayRegular[i%9].isHidden = false;
                }
                arrayRegular[i%9].isUserInteractionEnabled = true;
                arrayRegular[i%9].largeTexture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][i].front)
                arrayRegular[i%9].backTexture = SKTexture (imageNamed: pagesCollection[currentOutlinePage][i].back)
                arrayRegular[i%9].size = pageSizes[currentOutlinePage]
                var constantScale = (self.size.width / arrayRegular[i%9].size.width)/3 * 23/25;
                if (useHeightToScale[currentOutlinePage] == true) {
                    constantScale = (self.size.height / arrayRegular[i%9].size.height)/3 * 18/25;
                }
                arrayRegular[i%9].size.height = arrayRegular[i%9].size.height * constantScale
                arrayRegular[i%9].size.width = arrayRegular[i%9].size.width * constantScale
                lastpage = false;
                
            }
            currentPage=currentPage-1;
            var enlargedRN = false;
            for i in 0..<arrayEnlarged.count {
                if (arrayEnlarged[i].enlarged) {
                    enlargedRN = true;
                }
            }
            if (currentPage == 1 && enlargedRN == false) {
                button_back.isHidden = true;
                button_foward.isHidden = false;
            }
            else if (enlargedRN == false) {
                button_back.isHidden = false;
                button_foward.isHidden = false;
            }
            else if (enlargedRN == true) {
                button_back.isHidden = true;
                button_foward.isHidden = true;
            }
        }
        
    }
    
    @objc func heldView (sender: UITapGestureRecognizer) {
        var point: CGPoint = sender.location(in: self.view)
        point = self.convertPoint(fromView: point)
        if sender.state == UIGestureRecognizerState.began {
            if ((currentPage != 0 && menuScreen.isHidden == true) || onCreditsScene == true) {
                if (button_foward.frame.contains (point) && !lastpage) {
                    button_foward.size.width = button_foward.size.width * 19 / 20
                    button_foward.size.height = button_foward.size.height * 19 / 20
                }
                else if (button_back.frame.contains (point) && currentPage != 1) {
                    button_back.size.width = button_back.size.width * 19 / 20
                    button_back.size.height = button_back.size.height * 19 / 20
                    
                }
                else if (menu_icon.frame.contains(point) && onCreditsScene == false) {
                    menu_icon.size.width = menu_icon.size.width * 19 / 20
                    menu_icon.size.height = menu_icon.size.height * 19 / 20
                    print ("here")
                }
            }
            else {
                point = self.convertPoint(fromView: point)
                menuTappedOn = Int(point.y / (self.size.height/7)) + currentMenuPage * 7
                menuTappedOn = menuTappedOn % 7;
                thumbnailSprites[menuTappedOn].size.width = thumbnailSprites[menuTappedOn].size.width * 19 / 20
                thumbnailSprites[menuTappedOn].size.height = thumbnailSprites[menuTappedOn].size.height * 19 / 20
                
            }
        }
        else if sender.state == UIGestureRecognizerState.ended {
            if (button_foward.frame.contains (point) && !lastpage) {
                button_foward.size.width = button_foward.size.width * 20 / 19
                button_foward.size.height = button_foward.size.height * 20 / 19
                print (currentPage)
                nextPage()
                print (currentPage)
                showUpTo = pagesCollection[currentOutlinePage].count - currentPage * 9;
                playSound(e: "pageSwipe.wav")
            }
            else if (button_back.frame.contains (point) && currentPage != 1) {
                button_back.size.width = button_back.size.width * 20 / 19
                button_back.size.height = button_back.size.height * 20 / 19
                if (onCreditsScene == false) {
                    previousPage();
                    playSound(e: "pageSwipe.wav")
                }

            }
            else if (menu_icon.frame.contains(point)) {
                menu_icon.size.width = menu_icon.size.width * 20 / 19
                menu_icon.size.height = menu_icon.size.height * 20 / 19
                if (onCreditsScene == false) {
                    playSound(e: "pageOpenClose.wav")
                    currentPage = 1;
                    currentMenuPage = currentOutlinePage / 5
                    menuPageNo = currentOutlinePage / 5
                    popUpMenu();
                }
                else if (onCreditsScene == true){
                    popUpMenu();
                    showAll()
                    
                    menuScreen.isHidden = false;
                    
                    bg.texture = SKTexture(imageNamed: backGrounds[currentOutlinePage])
                    onCreditsScene = false;
                    currentPage = 1;
                    playSound(e: "menuTitlePageClose.wav")
                }
            }
            else if (menuScreen.isHidden == false && onCreditsScene == false) {
                thumbnailSprites[menuTappedOn].size.width = thumbnailSprites[menuTappedOn].size.width * 20 / 19
                thumbnailSprites[menuTappedOn].size.height = thumbnailSprites[menuTappedOn].size.height * 20 / 19
                point = self.convertPoint(fromView: point)
                menuTappedOn = Int(point.y / (self.size.height/7)) + currentMenuPage * 7
                if (menuTappedOn % 7 != 0 && menuTappedOn % 7 != 6) {
                    menuTappedOn = menuTappedOn - (currentMenuPage * 2 + 1)
                    
                    
                    if (menuTappedOn > pagesCollection.count - 1) {
                        return;
                    }
                    playSound(e: "pageOpenClose.wav")
                    menuPageNo = 0;
                    currentOutlinePage = menuTappedOn;
                    bg.texture = SKTexture(imageNamed: backGrounds[currentOutlinePage])
                    setSprites();
                    currentPage=1
                    menuScreen.isHidden = true;
                    for i in 0..<thumbnailSprites.count {
                        thumbnailSprites[i].isHidden = true;
                        button_back.isHidden = true;
                        button_foward.isHidden = false;
                    }
                }
                else if (menuTappedOn % 7 == 0) {
                    if (thumbnailSprites[0].isUserInteractionEnabled == true) {
                        hideAll()
                        for i in 0..<thumbnailSprites.count {
                            thumbnailSprites[i].isHidden = true;

                        }
                        button_back.isHidden = true;
                        button_foward.isHidden = true;
                        menu_icon.isHidden = false;

                        menuScreen.isHidden = true;
                        bg.texture = SKTexture(imageNamed: "credits_screen")
                        onCreditsScene = true;
                        currentPage = 2;
                        playSound(e: "menuTitlePageOpen.wav")
                    }
                    else {
                        swipeDown();
                    }
                }
                else if (menuTappedOn % 7 == 6) {
                    swipeUp()
                }
                
            }
            
        }
    }
    
    @objc func tappedView (sender: UITapGestureRecognizer) {
        var point: CGPoint = sender.location(in: self.view)
        point = self.convertPoint(fromView: point)
        if ((currentPage != 0 && menuScreen.isHidden == true) || onCreditsScene == true) {
            var shouldEnlarge = true;
            for i in 0..<arrayEnlarged.count {
                if (arrayEnlarged[i].enlarged) {
                    shouldEnlarge = false;
                }
            }
            
            if (shouldEnlarge) {
                for i in 0..<arrayRegular.count {
                    if i<arrayRegular.count && (!arrayEnlarged[0].enlarged || !arrayEnlarged[1].enlarged) && arrayRegular[i].frame.contains(point) && !arrayRegular[i].isHidden {
                        hideAll();
                        
                        playEffectQueue(soundName: "cardOpen.wav", i: i + (currentPage-1)*9)
                        print (pagesCollection[currentOutlinePage][i + (currentPage-1) * 9].front, " " , i + (currentPage-1) * 9)
                        arrayEnlarged[0].texture = arrayRegular[i].texture
                        arrayEnlarged[0].largeTexture = arrayRegular[i].texture
                        
                        currentEnlargedCard = i + (currentPage-1) * 9
                        
                        arrayEnlarged[0].backTexture = arrayRegular[i].backTexture
                        arrayEnlarged[0].enlarged = true;
                        
                        arrayEnlarged[0].size = SKSpriteNode(imageNamed: pagesCollection[currentOutlinePage][currentEnlargedCard].front).size
                        var constantMultiple = self.size.width / arrayEnlarged[0].size.width * 97/100;
                        arrayEnlarged[0].size.width = arrayEnlarged[0].size.width * constantMultiple
                        arrayEnlarged[0].size.height = arrayEnlarged[0].size.height * constantMultiple;
                        
                        arrayEnlarged[0].enlarge();
                        
                        return;
                    }
                }
            }
            for i in 0..<arrayEnlarged.count {
                if (arrayEnlarged[i].enlarged) {
                    
                    arrayEnlarged[i].flip(fast: false);
                    playSound(e: "cardFlip.mp3")
                    return;
                }
            }
            if (button_foward.frame.contains (point) && !lastpage) {
                print (currentPage)
                nextPage()
                print (currentPage)
                showUpTo = pagesCollection[currentOutlinePage].count - currentPage * 9;
                playSound(e: "pageSwipe.wav")
            }
            else if (button_back.frame.contains (point) && currentPage != 1) {
                if (onCreditsScene == false && currentPage != 1) {
                    previousPage();
                    playSound(e: "pageSwipe.wav")
                }
            }
            else if (menu_icon.frame.contains(point)) {
                if (onCreditsScene == false) {
                    playSound(e: "pageOpenClose.wav")
                    currentPage = 1;
                    currentMenuPage = currentOutlinePage / 5
                    menuPageNo = currentOutlinePage / 5
                    popUpMenu();
                }
                else if (onCreditsScene == true){
                    popUpMenu();
                    showAll()
                    
                    menuScreen.isHidden = false;
                    
                    bg.texture = SKTexture(imageNamed: backGrounds[currentOutlinePage])
                    onCreditsScene = false;
                    currentPage = 1;
                    playSound(e: "menuTitlePageClose.wav")
                }
            }
        }
        else {
            point = self.convertPoint(fromView: point)
            menuTappedOn = Int(point.y / (self.size.height/7)) + currentMenuPage * 7
            if (menuTappedOn % 7 != 0 && menuTappedOn % 7 != 6) {
                menuTappedOn = menuTappedOn - (currentMenuPage * 2 + 1)
               
                
                if (menuTappedOn > pagesCollection.count - 1) {
                    return;
                }
                playSound(e: "pageOpenClose.wav")
                menuPageNo = 0;
                currentOutlinePage = menuTappedOn;
                bg.texture = SKTexture(imageNamed: backGrounds[currentOutlinePage])
                setSprites();
                currentPage=1
                menuScreen.isHidden = true;
                for i in 0..<thumbnailSprites.count {
                    thumbnailSprites[i].isHidden = true;
                    button_back.isHidden = true;
                    button_foward.isHidden = false;
                }
            }
            else if (menuTappedOn % 7 == 0) {
                if (thumbnailSprites[0].isUserInteractionEnabled == true) {
                    hideAll()
                    for i in 0..<thumbnailSprites.count {
                        thumbnailSprites[i].isHidden = true;

                    }
                    button_back.isHidden = true;
                    button_foward.isHidden = true;
                    menu_icon.isHidden = false;
                    menuScreen.isHidden = true;
                    bg.texture = SKTexture(imageNamed: "credits_screen")
                    onCreditsScene = true;
                    currentPage = 2;
                    playSound(e: "menuTitlePageOpen.wav")
                }
                else {
                    swipeDown();
                }
            }
            else if (menuTappedOn % 7 == 6) {
                swipeUp()
            }
            
        }
        
    }
    @objc func swipedLeft() {
        if (menuScreen.isHidden == true && onCreditsScene == false) {
            var cardToEnlarge: Int = 0;
            for i in 0..<arrayEnlarged.count {
                if (arrayEnlarged[i].enlarged) {
                    
                    if (currentEnlargedCard>=currentPage*9 - 1 && !lastpage) {
                        
                        nextPage()
                        
                        
                    }
                    if (cardToEnlarge != arrayEnlarged.count-1 && (currentEnlargedCard + 1) < pagesCollection[currentOutlinePage].count ) {
                        let a = i;
                        var b = 1;
                        if (i == 1) {
                            b = 0;
                        }
                        

                        cardToEnlarge = currentEnlargedCard % 9;
                        arrayEnlarged[b].size = SKSpriteNode(imageNamed: pagesCollection[currentOutlinePage][currentEnlargedCard + 1].front).size
                        var constantMultiple = self.size.width / arrayEnlarged[b].size.width * 97/100;
                        arrayEnlarged[b].size.width = arrayEnlarged[b].size.width * constantMultiple
                        arrayEnlarged[b].size.height = arrayEnlarged[b].size.height * constantMultiple;
                        arrayEnlarged[b].enlarge()
                        arrayEnlarged[b].largeTexture = arrayRegular [(cardToEnlarge+1)%9].texture
                        arrayEnlarged[b].texture = arrayRegular [(cardToEnlarge+1)%9].texture
                        arrayEnlarged[b].backTexture = arrayRegular [(cardToEnlarge+1)%9].backTexture
                        arrayEnlarged[b].positionRight(faceUp1: arrayEnlarged[b].faceUp)
                        currentEnlargedCard = currentEnlargedCard + 1
                        if (arrayEnlarged[a].faceUp == false) {
                            arrayEnlarged[b].flip(fast: true);
                        }
                        arrayEnlarged[b].swipeLeft(first: true)
                        arrayEnlarged[a].swipeLeft(first: false);
                        arrayEnlarged[a].enlarged = false;
                        arrayEnlarged[b].enlarged = true;
                        audioPlayer?.stop()
                        
                        playSound(i: cardToEnlarge+1)
                        
                        return;
                    }
                    
                }
            }
            
            if (!lastpage) {
                nextPage();
                playSound(e: "pageSwipe.wav")
            }
            
        }
        
    }
    @objc func swipedRight () {
        if (menuScreen.isHidden == true && onCreditsScene == false) {
            var cardToEnlarge: Int;
            for i in 0..<arrayEnlarged.count {
                if (arrayEnlarged[i].enlarged) {
                    
                    cardToEnlarge = currentEnlargedCard%9;
                    if (currentEnlargedCard != 0){
                        if (currentEnlargedCard<currentPage*9-9 + 1 && currentPage != 1) {
                            previousPage();
                        }
                        let a = i;
                        var b = 1;
                        if (i == 1) {
                            b = 0;
                        }
                        
                        if (cardToEnlarge - 1 == -1) {
                            cardToEnlarge = 9
                        }
                        
                        arrayEnlarged[b].largeTexture = arrayRegular [(cardToEnlarge-1)%9].texture
                        arrayEnlarged[b].texture = arrayRegular [(cardToEnlarge-1)%9].texture
                        arrayEnlarged[b].backTexture = arrayRegular [(cardToEnlarge-1)%9].backTexture
                        print (currentEnlargedCard - 1)
                        arrayEnlarged[b].size = SKSpriteNode(imageNamed: pagesCollection[currentOutlinePage][currentEnlargedCard - 1].front).size
                        var constantMultiple = self.size.width / arrayEnlarged[b].size.width * 97/100;
                        arrayEnlarged[b].size.width = arrayEnlarged[b].size.width * constantMultiple
                        arrayEnlarged[b].size.height = arrayEnlarged[b].size.height * constantMultiple;
                        arrayEnlarged[b].enlarge()
                        arrayEnlarged[b].positionLeft(faceUp1: arrayEnlarged[b].faceUp)
                        if (arrayEnlarged[a].faceUp == false) {
                            arrayEnlarged[b].flip(fast: true);
                        }
                        audioPlayer?.stop()
                        
                        playSound(i: cardToEnlarge-1)
                        
                        arrayEnlarged[b].swipeRight()
                        arrayEnlarged[a].swipeRight();
                        arrayEnlarged[a].enlarged = false;
                        arrayEnlarged[b].enlarged = true;
                        currentEnlargedCard = currentEnlargedCard - 1;
                        return;
                    }
                    else {
                        return;
                    }
                    
                }
            }

            if (currentPage != 1 && menuScreen.isHidden == true) {
                previousPage()
                playSound(e: "pageSwipe.wav")
            }
        }
    }
    
    func popUpMenu () {
        
        menuScreen.isHidden = false;
        
        //let fontSize = menuScalingFont
        
        for i in 0..<8 {
            thumbnailSprites[i].isHidden = false
            
            if (menuPageNo * 5 + i - 1 < thumbnails.count) {
                if (i > 0 && i < 6) {
                    thumbnailSprites[i].texture = SKTexture (imageNamed: thumbnails[(i - 1) + 5 * currentMenuPage])
                }
            }
            else if (i != 6){
                print (menuPageNo * 5 + i - 1, " ", thumbnails.count)
                thumbnailSprites[i].isHidden = true
                thumbnailSprites[7].isHidden = true;
            }
            
        }
        
        
        if (menuPageNo * 5 + 5 < thumbnails.count) {
            thumbnailSprites[7].isHidden = false;
        }
        
        if (menuPageNo == 0 || currentMenuPage == 0) {
            thumbnailSprites[0].isHidden = false;
            thumbnailSprites[0].isUserInteractionEnabled = true;
            thumbnailSprites[6].isHidden = true
            thumbnailSprites[6].isUserInteractionEnabled = false;
        }
        else {
            thumbnailSprites[0].isHidden = true;
            thumbnailSprites[0].isUserInteractionEnabled = false;
            thumbnailSprites[6].isHidden = false
            thumbnailSprites[6].isUserInteractionEnabled = true;
        }
        currentPage-=1;
    }
    
    func hideAll() {
        if (!arrayRegular[8].isHidden) {
            showUpTo = 9;
        }
        else {
            for i in 0..<9 {
                
                if (arrayRegular[i].isHidden) {
                    showUpTo = i;
                    break;
                }
                
            }
        }
        for i in 0..<9 {
            arrayRegular[i].isHidden = true;
        }
        
        button_back.isHidden = true;
        button_foward.isHidden = true;
        menu_icon.isHidden = true;
    }
    
    func showAll() {
        
        for i in 0..<showUpTo {
            arrayRegular[i].isHidden = false;
        }
        for i in showUpTo..<9 {
            arrayRegular[i].isUserInteractionEnabled = false;
        }
        if (currentPage != 1) {
            button_back.isHidden = false;
        }
        if (lastpage == false) {
            button_foward.isHidden = false;
        }
        menu_icon.isHidden = false;
    }
    
    func playSound (i: Int) {
        if (pagesCollection[currentOutlinePage][i].music == "null") {
            return;
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: pagesCollection[currentOutlinePage][i].music, ofType:nil)!))
            
            
        }
        catch let error as NSError { print(error.debugDescription)
        }
        audioPlayer?.prepareToPlay();
        audioPlayer?.play();
    }
    
    func playSound (e: String) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: e, ofType:nil)!))
            
        }
        catch let error as NSError { print(error.debugDescription)
        }
        audioPlayer?.prepareToPlay();
        audioPlayer?.play();
    }
    
    func playEffectQueue(soundName: String, i:Int)  {
        let tempEffect: AVPlayerItem = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType:nil)!))
        if (pagesCollection[currentOutlinePage][i].music != "null") {
            let tempSound: AVPlayerItem = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: pagesCollection[currentOutlinePage][i].music, ofType:nil)!))
            audioQueue = AVQueuePlayer(items: [tempEffect, tempSound])
        }
        audioQueue = AVQueuePlayer(items: [tempEffect])
        audioQueue?.play();
    }
}

