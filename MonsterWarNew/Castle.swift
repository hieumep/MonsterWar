//
//  Castle.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Castle : GKEntity {
    init(imageName : String, team : Team, entityManager : EntityManager){
        super.init()
        let textture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(textture, entityManager : entityManager)
        let moveComponent = MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(spriteComponent.node.size.width/2), entityManager: entityManager)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(CastleComponent())
        addComponent(moveComponent)
        let healthComponent = HealthComponent(parentNode: spriteComponent.node, barWidth: spriteComponent.node.size.width, health: 500, barOffSet: spriteComponent.node.size.height / 2 , entityManager: entityManager)
        addComponent(healthComponent)
        let firingComponent = FiringComponent(damage: 5, damageRate: 2.0, range: 200, entityManager: entityManager)
        addComponent(firingComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
