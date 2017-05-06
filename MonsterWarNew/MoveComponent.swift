//
//  MoveComponent.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/3/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MoveComponent : GKAgent2D, GKAgentDelegate {
    let entityManager : EntityManager
    
    init(maxSpeed : Float, maxAcceleration : Float, radius : Float, entityManager : EntityManager) {
        //khai bao cac bien can thiet : maxSpeed, max Acceleration, radius, mass. Rieng enityManager de tuong tac voi cac entity khac
        self.entityManager = entityManager
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
        print(self.mass)
        self.mass = 0.01
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        //tra ve vi tri cua node
        position = float2(spriteComponent.node.position)
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else{
            return
        }
        //cap nhap vi tri cua node
        spriteComponent.node.position = CGPoint(position)
    }
    
    func closestMoveComponent(for team : Team) -> GKAgent2D? {
        var closestMoveComponent : MoveComponent? = nil
        var ClosestDistance = CGFloat(0)
        let enemyMoveComponents = entityManager.moveComponent(for: team)
        for enemyMoveComponent in enemyMoveComponents {
            let distance = (CGPoint(enemyMoveComponent.position) - CGPoint(position)).length()
           // print("\(distance)")
            if closestMoveComponent == nil || distance < ClosestDistance {
                closestMoveComponent = enemyMoveComponent
                ClosestDistance = distance
            }
            
        }
        return closestMoveComponent
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        guard let entity = entity, let teamComponent = entity.component(ofType : TeamComponent.self) else {
            return
        }
        
        
        
        var targetMoveComponent : GKAgent2D
        
        
            guard let enemyMovement = closestMoveComponent(for: teamComponent.team.oppositeTeam()) else{
                return
            }
            
            targetMoveComponent = enemyMovement
            // override target
            if let firingComponent = entity.component(ofType: FiringComponent.self) {
                let newTarget = GKAgent2D()
                let direction = (CGPoint(self.position) - CGPoint(targetMoveComponent.position)).normalized()
                newTarget.position = float2(CGPoint(targetMoveComponent.position) + direction * firingComponent.range)
                targetMoveComponent = newTarget
            }

            let alliedMoveComponets = entityManager.moveComponent(for: teamComponent.team)
            
            behavior = MoveBehavior(targetSpeed: maxSpeed, seek: targetMoveComponent, avoid: alliedMoveComponets)
          //  print(teamComponent.team)
        }
    }
