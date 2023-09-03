//
//  GameScene.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 6.08.23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var rocket: SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var liveLabel:SKLabelNode!
    var playerNameLabel = SKLabelNode(text: "Игрок")
    
    var scoreCounter = 0 {
        didSet {
            scoreLabel.text = "Счет: \(scoreCounter)"
        }
    }
    var liveCounter = 3 {
        didSet {
            liveLabel.text = "Жизней: \(liveCounter)"
        }
    }
    
    var gameTimer:Timer!
    var aliens = ["alien","alien2","alien3"]
    
    let alienCategory: UInt32 = 0x1 << 1
    let bulletCategory: UInt32 = 0x1 << 0
    
    private var options = Options(playerName: nil, rocketColor: nil, difficulty: nil)
    
    override func didMove(to view: SKView) {
        
        options = OptionsManager.shared.loadOptions()
        
        starfieldSetup()
        physicsWorldSetup()
        scoreLabelSetup()
        liveLabelSetup()
        playerNameLabelSetup()
        difficultySetup()
        rocketSetup()
    }
    
    func starfieldSetup() {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: self.frame.minX, y: 1472)
        starfield.zPosition = -1
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
    }
    
    func physicsWorldSetup() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func scoreLabelSetup() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel = SKLabelNode(text: "Счет: 0")
        scoreLabel.fontSize = 25
        scoreLabel.fontColor = .red
        scoreLabel.position = CGPoint(x: self.frame.minX + 50, y: self.frame.maxY - 70)
        scoreLabel.zPosition = 10
        self.addChild(scoreLabel)
    }
    
    func liveLabelSetup() {
        liveLabel = SKLabelNode(fontNamed: "Chalkduster")
        liveLabel = SKLabelNode(text: "Жизней: 3")
        liveLabel.fontSize = 25
        liveLabel.fontColor = .red
        liveLabel.position = CGPoint(x: self.frame.maxX - 70, y: self.frame.maxY - 70)
        liveLabel.zPosition = 10
        self.addChild(liveLabel)
    }
    
    func playerNameLabelSetup() {
        playerNameLabel = SKLabelNode(fontNamed: "Chalkduster")
        playerNameLabel.text = "Игрок"
        if let playerName = options.playerName {
            playerNameLabel.text = playerName
//        } else {
//            playerNameLabel.text = "Игрок"
        }
        playerNameLabel.fontSize = 25
        playerNameLabel.fontColor = .red
        playerNameLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 70)
        playerNameLabel.zPosition = 10
        self.addChild(playerNameLabel)
    }
    
    func difficultySetup() {
        if let difficulty = options.difficulty {
            gameTimer = Timer.scheduledTimer(timeInterval: difficulty, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        } else {
            gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        }
    }
    
    func rocketSetup() {
        if let rocketColor = options.rocketColor {
            rocket = SKSpriteNode(imageNamed: rocketColor)
        } else {
            rocket = SKSpriteNode(imageNamed: "orangeRocket")
        }
        rocket.position.x = frame.midX
        rocket.position.y = frame.minY + rocket.size.height * 2
        rocket.setScale(2) //увеличил размер в два раза
        self.addChild(rocket)
    }
    //проверка масок
    func didBegin(_ contact: SKPhysicsContact) {
        var alienBody: SKPhysicsBody
        var bulletBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bulletBody = contact.bodyA
            alienBody = contact.bodyB
        } else {
            bulletBody = contact.bodyB
            alienBody = contact.bodyA
        }
        
        if (alienBody.categoryBitMask & alienCategory) != 0 && (bulletBody.categoryBitMask & bulletCategory) != 0 {
            collisionElements(bulletNode: bulletBody.node as! SKSpriteNode, alienNode: alienBody.node as! SKSpriteNode)
        }
        
    }
    //при пересечении выстрела и врага
    func collisionElements(bulletNode: SKSpriteNode, alienNode: SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Vzriv")
        explosion?.position = alienNode.position
        self.addChild(explosion!)
        
        //var sound = SKAction.playSoundFileNamed("vzriv.mp3", waitForCompletion: false)
        //self.run(sound)
        
        bulletNode.removeFromParent()
        alienNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion?.removeFromParent()
        }
        
        scoreCounter += 5
    }
    
    func reduceLive() {
        if liveCounter != 0 {
            liveCounter -= 1
        }
        
        if liveCounter == 0 {
            saveRecord()
            gameOver()
        }
    }
    
    @objc func addAlien() {
        let alien = SKSpriteNode(imageNamed: aliens.shuffled()[0])
        let randomPosition = Int(scene?.frame.minX ?? 0)...Int(scene?.frame.maxX ?? 0)
        let position = CGFloat(randomPosition.randomElement() ?? 0)
        alien.position = CGPoint(x: position, y: self.size.height)
        alien.setScale(2)
        //добавляем физику обхекта
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        //добавляем каждому объекту уникальную маску
        alien.physicsBody?.categoryBitMask = alienCategory //сам объект
        alien.physicsBody?.contactTestBitMask = bulletCategory //объект с которым отслеживаем прикосновение
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        //работа с анимацией
        let animationDuration: TimeInterval = 6
        
        var actions = [SKAction]()
        actions.append(SKAction.move(to: CGPoint(x: position, y: self.frame.minY), duration: animationDuration))
        actions.append(SKAction.removeFromParent())
        let reduceLivesAction = SKAction.run(reduceLive)
        actions.append(reduceLivesAction)
        //запуск массива анимаций
        alien.run(SKAction.sequence(actions))
    }
    //действия по касанию экрана
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireBullet()
    }
    
    func fireBullet() {
        //var sound = SKAction.playSoundFileNamed("vzriv.mp3", waitForCompletion: false)
        //self.run(sound)
        
        let bullet = SKSpriteNode(imageNamed: "torpedo")
        bullet.position = CGPoint(x: rocket.position.x, y: rocket.position.y + 50)
        //bullet.position.y += 10
        bullet.setScale(2)
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
        bullet.physicsBody?.isDynamic = true
       
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask = alienCategory
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.usesPreciseCollisionDetection = true //позволяем физически соприкасаться с другим объектом
        
        self.addChild(bullet)
        
        let animationDuration: TimeInterval = 1
        
        var actions = [SKAction]()
        actions.append(SKAction.move(to: CGPoint(x: rocket.position.x, y: self.frame.maxY), duration: animationDuration))
        actions.append(SKAction.removeFromParent())
       
        bullet.run(SKAction.sequence(actions))
    }
    
    func saveRecord() {
        
        let newRecord = Record(name: options.playerName, score: scoreCounter)
            RecordManager.shared.saveRecord(newRecord)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first! as UITouch

        let pointOfTouch = touch.location(in: self)
        let previousPointOfTouch = touch.previousLocation(in: self)

        let offsetX = pointOfTouch.x - previousPointOfTouch.x

       
        self.rocket.position.x += offsetX
        

        if rocket.position.x > self.frame.maxX - rocket.size.width / 2 {
            rocket.position.x = self.frame.maxX - rocket.size.width / 2
        }

        if rocket.position.x < self.frame.minX + rocket.size.width / 2 {
            rocket.position.x = self.frame.minX + rocket.size.width / 2
        }
    }
    
    func gameOver() {
        
        let gameOverScene = GameOverScene(size: self.size)
        gameOverScene.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 1)
        self.view?.presentScene(gameOverScene, transition: sceneTransition)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
