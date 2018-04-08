//
//  TitlePage.swift
//  Leocha-Scenes
//
//  Created by Marion FANJAUD on 08/04/2018.
//  Copyright © 2018 Marion FANJAUD. All rights reserved.
//

import SpriteKit

class TitlePage: GameScene {

    var readButton: SKSpriteNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        readButton = childNode(withName: "readButton") as! SKSpriteNode
        
        btnNext.isHidden = true
        btnPrevious.isHidden = true
    }
    
    override func touchDown(at point: CGPoint) {
        if readButton.contains(point) {
            goToScene(scene: getNextScene()!)
        }
    }
    
    override func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "Scene01") as! Scene01
    }
    
}
