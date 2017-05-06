//
//  GameScene.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let margin : CGFloat = 30.0
    var entityManager : EntityManager!
    var lastUpdateTimeInterval = TimeInterval(0)
    let humanCoinLabel = CoinLabel(text: "10", aligment : .left)
    let aiCoinLabel = CoinLabel(text: "10", aligment : .right)
    var humanHealth : CGFloat = 0
    var aiHealth : CGFloat = 0
    var gameOver = false
    
    override func didMove(to view: SKView) {
        entityManager = EntityManager.init(scene: self)
        // add background Node
        let backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundNode.zPosition = -1
        addChild(backgroundNode)
        
        //add Coin
        let humanCoin = SKSpriteNode(imageNamed: "coin")
        humanCoin.position = CGPoint(x: margin + humanCoin.size.width/2, y: size.height - margin - humanCoin.size.height/2)
        humanCoin.zPosition = 1
        addChild(humanCoin)
        
        // add label show how many human Coin
        humanCoinLabel.position = CGPoint(x: humanCoin.position.x + margin, y: humanCoin.position.y)
        addChild(humanCoinLabel)
        
        //add AiCoin (right screen)
        let aiCoin = SKSpriteNode(imageNamed: "coin")
        aiCoin.position = CGPoint(x: size.width - margin - aiCoin.size.width/2, y: size.height - margin - aiCoin.size.height/2)
        addChild(aiCoin)
        
        //add label show how many AI Coin
        
        aiCoinLabel.position = CGPoint(x: aiCoin.position.x - margin, y: aiCoin.position.y)
        addChild(aiCoinLabel)
        
        // add button quirk
        let quirkButton = MonsterButton(monster: Monster(.quirk), buttonPress: spawnQuirk)
        quirkButton.position = CGPoint(x: size.width * 0.25, y: quirkButton.size.height / 2 + margin)
        addChild(quirkButton)
        
        //add button zap
        let zapButton = MonsterButton(monster: Monster(.zap), buttonPress: spawnZap)
        zapButton.position = CGPoint(x: size.width * 0.5, y: zapButton.size.height/2 + margin)
        addChild(zapButton)
        
        //add button munch
        let munchButton = MonsterButton(monster: Monster(.munch), buttonPress: spawnMunch)
        munchButton.position = CGPoint(x: size.width * 0.75, y: munchButton.size.height/2 + margin)
        addChild(munchButton)
        
        //add HumanCastle
        let humanCastle = Castle(imageName: "castle1_atk",team : .team1, entityManager : entityManager)
        if let spriteComponent = humanCastle.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager.add(entity: humanCastle)
        
        //add AI Castle
        let aiCastle = Castle(imageName: "castle2_atk", team : .team2, entityManager : entityManager)
        if let spriteComponent = aiCastle.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: size.width - spriteComponent.node.size.width / 2, y: size.height/2)
        }
        let aiComponent = AIComponent.init(entityManager: entityManager)
        aiCastle.addComponent(aiComponent)
        entityManager.add(entity: aiCastle)
    }
    
    func spawnQuirk() {
        entityManager.spawnMonster(team: .team1, monsterKind: .quirk)
    }
    
    func spawnZap() {
        entityManager.spawnMonster(team: .team1, monsterKind: .zap)
        
    }
    
    func spawnMunch(){
       entityManager.spawnMonster(team: .team1, monsterKind: .munch)
    }
    
    //ham tu dong goi khi update frame
    override func update(_ currentTime: TimeInterval) {
        //check game over chua
        if gameOver {
            return
        }
        // tinh khoang thoi gian hien tai va lan update cuoi cung
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        entityManager.update(deltaTime)
        
        // chung ta lay thong tin castleComponent from caste team de update coin
        if let human = entityManager.caste(for: .team1), let humanCastle = human.component(ofType : CastleComponent.self), let humanCasteHealth = human.component(ofType : HealthComponent.self){
            humanCoinLabel.text = "\(humanCastle.coin)"
            self.humanHealth = humanCasteHealth.health
        }
        if let ai = entityManager.caste(for: .team2), let aiCastle = ai.component(ofType : CastleComponent.self), let aiCastleHealth = ai.component(ofType: HealthComponent.self){
            aiCoinLabel.text = "\(aiCastle.coin)"
            self.aiHealth = aiCastleHealth.health
        }
        
        if humanHealth == 0 {
            showRestartMenu(false)
        }
        if aiHealth == 0{
            showRestartMenu(true)
        }
        
    }
    
    func showRestartMenu(_ won: Bool) {
        
        if gameOver {
            return;
        }
        gameOver = true
        
        let message = won ? "You win" : "You lose"
        
        let label = SKLabelNode(fontNamed: "Courier-Bold")
        label.fontSize = 100
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        label.zPosition = 1
        label.verticalAlignmentMode = .center
        label.text = message
        label.setScale(0)
        addChild(label)
        
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        scaleAction.timingMode = SKActionTimingMode.easeInEaseOut
        label.run(scaleAction)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        print("\(touchLocation)")
        
        if gameOver {
            let newScene = GameScene(size: size)
            newScene.scaleMode = scaleMode
            view?.presentScene(newScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            return
        }
    }

    
}
