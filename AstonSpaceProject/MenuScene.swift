//
//  MenuScene.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 18.08.23.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var starfield: SKEmitterNode!
    var startGameLabel = SKLabelNode(fontNamed: "Chalkduster")
    var optionsLabel = SKLabelNode(fontNamed: "Chalkduster")
    var recordsLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    
    override func didMove(to view: SKView) {
        
        starfieldSetup()
        startGameLabelSetup()
        optionsLabelSetup()
        recordsLabelSetup()
    }
    
    func starfieldSetup() {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.zPosition = -1
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
    }
    
    func startGameLabelSetup() {
        startGameLabel.text = "Start"
        startGameLabel.fontColor = SKColor.white
        startGameLabel.fontSize = 40
        startGameLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        startGameLabel.zPosition = 1
        self.addChild(startGameLabel)
    }
    
    func optionsLabelSetup() {
        optionsLabel.text = "Options"
        optionsLabel.fontColor = .white
        optionsLabel.fontSize = 40
        optionsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
        optionsLabel.zPosition = 1
        self.addChild(optionsLabel)
    }
    
    func recordsLabelSetup() {
        recordsLabel.text = "Records"
        recordsLabel.fontColor = .white
        recordsLabel.fontSize = 40
        recordsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.3)
        recordsLabel.zPosition = 1
        self.addChild(recordsLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let pointOfTouch = touch.location(in: self)
            
            if startGameLabel.contains(pointOfTouch) {
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(gameScene, transition: sceneTransition)
            }
            
            if optionsLabel.contains(pointOfTouch) {
                let optionsScene = OptionsScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(optionsScene, transition: sceneTransition)
            }
            
            if recordsLabel.contains(pointOfTouch) {
                let recodsScene = RecordsScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(recodsScene, transition: sceneTransition)
            }
        }
    }
}
