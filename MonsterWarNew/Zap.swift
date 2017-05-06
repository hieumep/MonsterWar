//
//  Zap.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/4/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Zap : GKEntity {
    
    init(team : Team, entityManager : EntityManager){
        let texture : SKTexture
        let monster = Monster(.zap)
        if team == .team1 {
            texture = monster.textureHome
        }else {
            texture = monster.textureAway
        }
        super.init()
        let spriteComponent = SpriteComponent(texture, entityManager : entityManager)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        let heathComponent = HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, health: 10, barOffSet: texture.size().width / 2 , entityManager: entityManager)
        addComponent(heathComponent)
        let moveComponent = MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(spriteComponent.node.size.width/2), entityManager: entityManager)
        addComponent(moveComponent)
        let firingComponent = FiringComponent(damage: 5, damageRate: 1.5, range: 300, entityManager: entityManager)
        addComponent(firingComponent)
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
