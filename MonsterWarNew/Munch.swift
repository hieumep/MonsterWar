//
//  Munch.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/4/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Munch : GKEntity {
    init(team : Team, entityManager : EntityManager) {
        var texture : SKTexture
        let monster = Monster(.munch)
        if team == .team1 {
            texture = monster.textureHome
        }else {
            texture = monster.textureAway
        }
        super.init()
        let spriteComponent = SpriteComponent(texture, entityManager : entityManager)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        let heathComponent = HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, health: 75, barOffSet: texture.size().width / 2 , entityManager: entityManager)
        addComponent(heathComponent)
        let meleeComponent = MeleeComponent(damage: 15, damageRate: 2.5, destroySelf: false, aoe: true, entityManager: entityManager)
        addComponent(meleeComponent)
        let moveComponent = MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(spriteComponent.node.size.width * 0.3), entityManager: entityManager)
        addComponent(moveComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
