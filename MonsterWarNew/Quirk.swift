//
//  Quirk.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/3/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Quirk : GKEntity {
    init(team : Team, entityManager : EntityManager){
        super.init()
        var texture : SKTexture
        let quirk = Monster(.quirk)
        if team == .team1 {
            texture = quirk.textureHome
        }else {
            texture = quirk.textureAway
        }
        let spriteComponent = SpriteComponent(texture, entityManager :entityManager)
        let moveComponent = MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(moveComponent)
        let heathComponent = HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, health: 15, barOffSet: texture.size().width / 2 , entityManager: entityManager)
        addComponent(heathComponent)
        let meleeComponent = MeleeComponent(damage: 2.5, damageRate: 0.5, destroySelf: false, aoe: false, entityManager: entityManager)
        addComponent(meleeComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
