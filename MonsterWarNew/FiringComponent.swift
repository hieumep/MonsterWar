//
//  FiringComponent.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/4/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class FiringComponent : GKComponent {
    var damage : CGFloat
    var damageRate : CGFloat
    var range : CGFloat
    var lastDamageTime : TimeInterval
    var entityManager : EntityManager
    
    init(damage : CGFloat, damageRate : CGFloat, range : CGFloat, entityManager : EntityManager){
        self.damage = damage
        self.damageRate = damageRate
        self.range = range
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
        
        let enemyEntities = entityManager.entities(for: teamComponent.team.oppositeTeam())
        for enemyEntity in enemyEntities {
            guard let enemySpriteComponent = enemyEntity.component(ofType: SpriteComponent.self) else{
                continue
            }
            
            let distance = (spriteComponent.node.position - enemySpriteComponent.node.position).length()
            let wiggleRoom = CGFloat(5)
            
            if (CGFloat(abs(distance)) <= range + wiggleRoom && CGFloat(CACurrentMediaTime() - lastDamageTime) > damageRate) {
                
                lastDamageTime = CACurrentMediaTime()
                
                let laser = Laser(team: teamComponent.team, entityManager: entityManager, damage: damage)
                guard let laserSpriteComponent = laser.component(ofType : SpriteComponent.self) else {
                    return
                }
                //set diem xuat phat cua laser
                laserSpriteComponent.node.position = spriteComponent.node.position
                let direction = (enemySpriteComponent.node.position - spriteComponent.node.position).normalized()
                let laserPointPerSecond = CGFloat(300)
                let laserDistance = CGFloat(1000)
                
                let target = direction * laserDistance
                let duration = laserDistance / laserPointPerSecond
                
                laserSpriteComponent.node.zPosition = 1
                laserSpriteComponent.node.zRotation = direction.angle
                
                let shot = SKAction.moveBy(x: target.x, y: target.y, duration: TimeInterval(duration))
                laserSpriteComponent.node.run(shot){
                    self.entityManager.remove(entity: laser)
                }
                entityManager.add(entity: laser)
            }
        }
    }
}
