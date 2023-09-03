//
//  RecordsScene.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 27.08.23.
//

import UIKit
import SpriteKit

class RecordsScene: SKScene {
    
    var starfield: SKEmitterNode!
    let recordsLabel = SKLabelNode(fontNamed: "Chalkduster")
    let backToMenuLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    var records = [Record]()
    
    var recordsTableView = RecordsTableView()
    let recordsTableViewSize = CGSize(width: 350, height: 400)
    let cell = UITableViewCell()
    
    override func didMove(to view: SKView) {
        
        starfieldSetup()
        recordsLabelSetup()
        backToMenuLabelSetup()
        recordsTableViewSetup()
        registerNibs()
        
    }
    
    func starfieldSetup() {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.zPosition = -1
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
    }
    
    func recordsLabelSetup() {
        recordsLabel.text = "Records"
        recordsLabel.fontColor = SKColor.white
        recordsLabel.fontSize = 40
        recordsLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85)
        recordsLabel.zPosition = 1
        addChild(recordsLabel)
    }
    
    func backToMenuLabelSetup() {
        backToMenuLabel.text = "Back to Menu"
        backToMenuLabel.fontColor = SKColor.white
        backToMenuLabel.fontSize = 30
        backToMenuLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        backToMenuLabel.zPosition = 1
        addChild(backToMenuLabel)
    }
    
    func recordsTableViewSetup() {
        self.recordsTableView.backgroundColor = .clear
        self.recordsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.recordsTableView.frame = CGRect(x: self.frame.width * 0.085,
                                     y: self.frame.height * 0.3,
                                     width: self.recordsTableViewSize.width,
                                     height: self.recordsTableViewSize.height)
        self.scene?.view?.addSubview(recordsTableView)
        self.recordsTableView.reloadData()
    }
    
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width))
        headerView.backgroundColor = .clear
        
        let scoreLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.recordsTableViewSize.width / 2, height: headerView.frame.size.height/5))
        let nameLabel = UILabel(frame: CGRect(x: 10 + scoreLabel.frame.width, y: 0, width: self.recordsTableViewSize.width / 2, height: headerView.frame.size.height/5))
        
        scoreLabel.text = "Score"
        scoreLabel.font = UIFont(name: "Quadaptor", size: 30)
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        
        nameLabel.text = "Name"
        nameLabel.font = UIFont(name: "Quadaptor", size: 30)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        
        headerView.addSubview(scoreLabel)
        headerView.addSubview(nameLabel)
        
        return headerView
    }
    
    private func registerNibs() {
        let recordCell = UINib(nibName: "RecordTableViewCell", bundle: nil)
        recordsTableView.register(recordCell, forCellReuseIdentifier: "RecordTableViewCell")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let pointOfTouch = touch.location(in: self)
            
            if backToMenuLabel.contains(pointOfTouch) {
                recordsTableView.removeFromSuperview()
                let menuScene = MenuScene(size: UIScreen.main.bounds.size)
                let sceneTransition = SKTransition.fade(withDuration: 1)
                self.view?.presentScene(menuScene, transition: sceneTransition)
            }
        }
    }

}
