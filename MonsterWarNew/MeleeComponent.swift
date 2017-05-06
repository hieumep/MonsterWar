//
//  MeleeComponent.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/4/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MeleeComponent : GKComponent{
    var damage : CGFloat
    var entityManager : EntityManager
    var damageRate : CGFloat
    var destroySelf : Bool
    var aoe : Bool
    var lastDamageTime : TimeInterval
    
    init(damage : CGFloat, damageRate : CGFloat, destroySelf : Bool, aoe : Bool, entityManager : EntityManager){
        self.damage = damage
        self.damageRate = damageRate
        self.destroySelf = destroySelf
        self.aoe = aoe
        self.entityManager = entityManager
        lastDamageTime = 0
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self), let teamComponent = entity?.component(ofType: TeamComponent.self) else {
            return
        }
        
        var aoeDamageCause = false
        let enemyEntities = entityManager.entities(for: teamComponent.team.oppositeTeam())
        for enemyEntity in enemyEntities {
            guard let enemySpriteComponent = enemyEntity.component(ofType: SpriteComponent.self), let enemyHealthComponent = enemyEntity.component(ofType: HealthComponent.self) else {
            continue
        }
        
        // check intersect between 2 entity
            if spriteComponent.node.calculateAccumulatedFrame().intersects(enemySpriteComponent.node.calculateAccumulatedFrame()) {
                if (CGFloat(CACurrentMediaTime() - lastDamageTime) > damageRate) {
                    // kiem tra co danh nheiu doi tuong
                    if aoe {
                        aoeDamageCause = true
                    } else {
                        lastDamageTime = CACurrentMediaTime()
                    }
                }
                // giam mau
                enemyHealthComponent.takeDamage(damage)
                // nhu dan tuong tac se huy diet
                if destroySelf {
                    entityManager.remove(entity: entity!)
                }
            }
        }
        // neu danh lan thi sau khi danh het doi tuong thi moi cap nhap thoi gian
        if aoeDamageCause {
            lastDamageTime = CACurrentMediaTime()
        }
    }
    
}
