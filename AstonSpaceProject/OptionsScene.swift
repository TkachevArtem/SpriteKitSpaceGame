//
//  OptionsScene.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 23.08.23.
//

import UIKit
import SpriteKit

class OptionsScene: SKScene {
    
    var starfield: SKEmitterNode!
    
    let optionsLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    let easyLabel = SKLabelNode(fontNamed: "Chalkduster")
    let mediumLabel = SKLabelNode(fontNamed: "Chalkduster")

    let backToMenuLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    let playerNameField = UITextField()
    let playerNameFieldSize = CGSize(width: 300, height: 50)
    
    let blueRocket = SKSpriteNode(imageNamed: "blueRocket")
    let orangeRocket = SKSpriteNode(imageNamed: "orangeRocket")
    
    let easy = 3.0
    
    let medium = 1.5
    
    private var options = Options(playerName: nil, rocketColor: nil, difficulty: nil)
    

    override func didMove(to view: SKView) {
        
        starfieldSetup()
        currentOptionsSetup()
        optionsLabelSetup()
        playerNameFieldSetup()
        blueRocketSetup()
        greenRocketSetup()
        easyLabelSetup()
        mediumLabelSetup()
        backToMenuLabelSetup()
        
    }
    
    func starfieldSetup() {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.zPosition = -1
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
    }
    
    func optionsLabelSetup() {
        optionsLabel.text = "Options"
        optionsLabel.fontColor = SKColor.white
        optionsLabel.fontSize = 40
        optionsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85)
        optionsLabel.zPosition = 1
        addChild(optionsLabel)
    }
    
    func playerNameFieldSetup() {
        playerNameField.borderStyle = UITextField.BorderStyle.roundedRect
        playerNameField.textColor = SKColor.black
        playerNameField.font = UIFont(name: "Quadaptor", size: 25)
        playerNameField.placeholder = "Enter your name"
        playerNameField.clearButtonMode = .unlessEditing
        playerNameField.frame = CGRect(x: self.frame.width * 0.15,
                                       y: self.frame.height * 0.25,
                                       width: playerNameFieldSize.width,
                                       height: playerNameFieldSize.height)
        self.view?.addSubview(playerNameField)
    }
    
    func blueRocketSetup() {
        blueRocket.position = CGPoint(x: self.size.width * 0.3, y: self.frame.height * 0.55)
        blueRocket.zPosition = 1
        blueRocket.size = CGSize(width: 100, height: 100)
        addChild(blueRocket)
    }
    
    func greenRocketSetup() {
        orangeRocket.position = CGPoint(x: self.size.width * 0.7, y: self.frame.height * 0.55)
        orangeRocket.zPosition = 1
        orangeRocket.size = CGSize(width: 100, height: 100)
        addChild(orangeRocket)
    }
    
    func easyLabelSetup() {
        easyLabel.text = "Easy"
        easyLabel.fontColor = SKColor.white
        easyLabel.fontSize = 25
        easyLabel.position = CGPoint(x: self.size.width * 0.3, y: self.frame.height * 0.35)
        easyLabel.zPosition = 1
        addChild(easyLabel)
    }
    
    func mediumLabelSetup() {
        mediumLabel.text = "Medium"
        mediumLabel.fontColor = SKColor.white
        mediumLabel.fontSize = 25
        mediumLabel.position = CGPoint(x: self.size.width * 0.7, y: self.frame.height * 0.35)
        mediumLabel.zPosition = 1
        addChild(mediumLabel)
    }
    
    func backToMenuLabelSetup() {
        backToMenuLabel.text = "Back to Menu"
        backToMenuLabel.fontColor = SKColor.white
        backToMenuLabel.fontSize = 30
        backToMenuLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        backToMenuLabel.zPosition = 1
        addChild(backToMenuLabel)
    }
    
    func currentOptionsSetup() {
        
        options = OptionsManager.shared.loadOptions()
        
        if let name = options.playerName {
            playerNameField.text = name
        }
        
        if let ship = options.rocketColor {
            switch ship {
            case "blueRocket":
                let scaleUpBlueRocket = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownBlueRocret = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleRocketBlueSequance = SKAction.sequence([scaleUpBlueRocket, scaleDownBlueRocret])
                blueRocket.run(scaleRocketBlueSequance)
                let scaleDownGreenRocketTo1 = SKAction.scale(to: 1, duration: 0.2)
                orangeRocket.run(scaleDownGreenRocketTo1)
            case "orangeRocket":
                let scaleUpOrangeRocket = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownOrangeRocket = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleRocketOrangeSequance = SKAction.sequence([scaleUpOrangeRocket, scaleDownOrangeRocket])
                orangeRocket.run(scaleRocketOrangeSequance)
                let scaleDownBlueRocketTo1 = SKAction.scale(to: 1, duration: 0.2)
                blueRocket.run(scaleDownBlueRocketTo1)
            default:
                break
            }
        }
        
        if let difficulty = options.difficulty {
            switch difficulty {
            case easy:
                let scaleUpEasy = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownEasy = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleEasySequance = SKAction.sequence([scaleUpEasy, scaleDownEasy])
                easyLabel.run(scaleEasySequance)
                let scaleDownMediumTo1 = SKAction.scale(to: 1, duration: 0.2)
                mediumLabel.run(scaleDownMediumTo1)
            case medium:
                let scaleUpMedium = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownMedium = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleMediumSequance = SKAction.sequence([scaleUpMedium, scaleDownMedium])
                mediumLabel.run(scaleMediumSequance)
                let scaleDownEasyTo1 = SKAction.scale(to: 1, duration: 0.2)
                easyLabel.run(scaleDownEasyTo1)
            default:
                break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)

            if backToMenuLabel.contains(pointOfTouch) {
                
                options.playerName = playerNameField.text
                OptionsManager.shared.saveOptions(options)
                
                self.playerNameField.removeFromSuperview()
                let menuScene = MenuScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(menuScene, transition: sceneTransition)
            }
            
            if blueRocket.contains(pointOfTouch) {
                let scaleUpBlueRocket = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownBlueRocket = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleRocketBlueSequance = SKAction.sequence([scaleUpBlueRocket, scaleDownBlueRocket])
                blueRocket.run(scaleRocketBlueSequance)
                let scaleDownGreenRocketTo1 = SKAction.scale(to: 1, duration: 0.2)
                orangeRocket.run(scaleDownGreenRocketTo1)
                
                options.rocketColor = "blueRocket"

            } else if orangeRocket.contains(pointOfTouch) {
                let scaleUpGreenRocket = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownGreenRocket = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleRocketGreenSequance = SKAction.sequence([scaleUpGreenRocket, scaleDownGreenRocket])
                orangeRocket.run(scaleRocketGreenSequance)
                let scaleDownBlueRocketTo1 = SKAction.scale(to: 1, duration: 0.2)
                blueRocket.run(scaleDownBlueRocketTo1)
                
                options.rocketColor = "orangeRocket"
            }
            
            if easyLabel.contains(pointOfTouch) {
                let scaleUpEasy = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownEasy = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleEasySequance = SKAction.sequence([scaleUpEasy, scaleDownEasy])
                easyLabel.run(scaleEasySequance)
                let scaleDownMediumTo1 = SKAction.scale(to: 1, duration: 0.2)
                mediumLabel.run(scaleDownMediumTo1)
                
                options.difficulty = easy
                
            } else if mediumLabel.contains(pointOfTouch) {
                let scaleUpMedium = SKAction.scale(to: 2, duration: 0.2)
                let scaleDownMedium = SKAction.scale(to: 1.5, duration: 0.2)
                let scaleMediumSequance = SKAction.sequence([scaleUpMedium, scaleDownMedium])
                mediumLabel.run(scaleMediumSequance)
                let scaleDownEasyTo1 = SKAction.scale(to: 1, duration: 0.2)
                easyLabel.run(scaleDownEasyTo1)
                
                options.difficulty = medium
            }
        }
    }
}
