//
//  GameOverScene.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 22.08.23.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var starfield: SKEmitterNode!
    let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
    var restartGameLabel = SKLabelNode(fontNamed: "Chalkduster")
    let backToMenuLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    
    override func didMove(to view: SKView) {
        
        starfieldSetup()
        gameOverLabelSetup()
        restartLabelSetup()
        backToMenuLabelSetup()
    }
    
    func starfieldSetup() {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.zPosition = -1
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
    }
    
    func gameOverLabelSetup() {
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.fontSize = 50
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)
    }
    
    func restartLabelSetup() {
        restartGameLabel.text = "Restart"
        restartGameLabel.fontColor = SKColor.white
        restartGameLabel.fontSize = 40
        restartGameLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        restartGameLabel.zPosition = 1
        self.addChild(restartGameLabel)
    }
    
    func backToMenuLabelSetup() {
        backToMenuLabel.text = "Back To Menu"
        backToMenuLabel.fontColor = SKColor.white
        backToMenuLabel.fontSize = 30
        backToMenuLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        backToMenuLabel.zPosition = 1
        addChild(backToMenuLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: UITouch in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if restartGameLabel.contains(pointOfTouch) {
                
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(gameScene, transition: sceneTransition)
                
            }
            
            if backToMenuLabel.contains(pointOfTouch) {
                let menuScene = MenuScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(menuScene, transition: sceneTransition)
            }
            
        }
    }
}
