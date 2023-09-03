//
//  GameViewController.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 6.08.23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .resizeFill
                scene.size = UIScreen.main.bounds.size
                // Present the scene
                //view.presentScene(scene)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                view.presentScene(scene, transition: sceneTransition)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
