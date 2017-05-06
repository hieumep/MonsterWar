//
//  CastleComponent.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/3/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class CastleComponent : GKComponent {
    var attacking = true
    var coin = 0
    var lastCoinDrop = TimeInterval(0)
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Dung de update coin automatic during game playing - override update()
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        // thuc hien tu dong update coin
        let coinDropInterval = TimeInterval(0.5) // 0.5s se tang 10 coin
        let coinPerInterval = 10
        // Neu thoi gian hien tai tru di thoi gian lan cuoi update coin ma lon hon thoi gian update coin thi update coin va update thoi gian last time
        if (CACurrentMediaTime() - lastCoinDrop) > coinDropInterval {
            lastCoinDrop = CACurrentMediaTime()
            coin += coinPerInterval
        }
        
        if let spriteComponent = entity?.component(ofType: SpriteComponent.self),
            let teamComponent = entity?.component(ofType: TeamComponent.self) {
            if attacking {
                spriteComponent.node.texture = SKTexture(imageNamed: "castle\(teamComponent.team.rawValue)_atk")
            } else {
                spriteComponent.node.texture = SKTexture(imageNamed: "castle\(teamComponent.team.rawValue)_def")
            }
        }
    }
    
}
