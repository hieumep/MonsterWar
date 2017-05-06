//
//  HealthComponent.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/4/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class HealthComponent : GKComponent {
    var fullHealth : CGFloat
    var health : CGFloat
    var healthBarFullWidth : CGFloat
    var healthBar : SKShapeNode
    var entityManager : EntityManager
    
    init(parentNode : SKNode, barWidth : CGFloat, health : CGFloat, barOffSet : CGFloat, entityManager : EntityManager){
        fullHealth = health
        self.health = health
        healthBarFullWidth = barWidth
        healthBar = SKShapeNode(rectOf: CGSize(width : healthBarFullWidth, height : 5), cornerRadius: 1)
        healthBar.fillColor = .green
        healthBar.strokeColor = .yellow
        healthBar.position = CGPoint(x: 0, y: barOffSet)
        parentNode.addChild(healthBar)
        self.entityManager = entityManager
        super.init()
        healthBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult func takeDamage(_ damage: CGFloat) -> Bool {
        health = max(health - damage , 0)
        
        healthBar.isHidden = false
        
        let healthScale = health/fullHealth
        let healthAction = SKAction.scaleX(to: healthScale, duration: 0.5)
        healthBar.run(healthAction)
        
        if health == 0 {
            if let entity = entity {
                let casteComponent = entity.component(ofType: CastleComponent.self)
                if casteComponent == nil {
                    entityManager.remove(entity: entity)
                }
            }
        }
        return health == 0
    }
}
