//
//  Laser.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/4/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Laser : GKEntity {
    init(team : Team, entityManager : EntityManager, damage : CGFloat){
        let texture : SKTexture
        if team == .team1 {
            texture = SKTexture(imageNamed: "laser1")
        } else {
            texture = SKTexture(imageNamed: "laser2")
        }
        let spriteComponent = SpriteComponent(texture, entityManager : entityManager)
        super.init()
        addComponent(spriteComponent)
        let meleeComponent = MeleeComponent(damage: damage, damageRate: 1.0, destroySelf: true, aoe: false, entityManager: entityManager)
        addComponent(meleeComponent)
        addComponent(TeamComponent(team: team))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
