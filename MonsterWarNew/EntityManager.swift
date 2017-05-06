//
//  EntityManager.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    let scene : SKScene
    
    init(scene : SKScene){
        self.scene = scene
    }
    
    lazy var componentSystems : [GKComponentSystem] = {
        let castleComponent = GKComponentSystem(componentClass: CastleComponent.self)
        let moveComponent = GKComponentSystem(componentClass: MoveComponent.self)
        let meleeComponent = GKComponentSystem(componentClass: MeleeComponent.self)
        let firingComponent = GKComponentSystem(componentClass: FiringComponent.self)
        let aiComponent = GKComponentSystem(componentClass: AIComponent.self)
        return [castleComponent, moveComponent, meleeComponent, firingComponent, aiComponent]
        
    }()
    
    func add(entity : GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
    func remove(entity : GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        toRemove.insert(entity)
        entities.remove(entity)
    }
    
    func update(_ deltaTime : CFTimeInterval){
        // ham kiem tra cac componentSystem , de goi Update
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        //neu toRemove co gia tri thi se thuc hien de xoa this entity with component
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }
    //ham giup fan biet caste human or AI
    func caste(for team : Team) -> GKEntity? {
        for entity in entities {
            // lay gia tri teamComponent , neu no cung gia tri voi team thi tra ve entity do
            if let teamComponent = entity.component(ofType: TeamComponent.self), let _ = entity.component(ofType: CastleComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            
            }
        }
        return nil
    }
    
    func entities(for team : Team) -> [GKEntity]{
        return entities.flatMap {entity in
            // kiem tra xem entity nao cung thuoc team thi tra ve entity do
            if let teamComponent = entity.component(ofType: TeamComponent.self){
                if teamComponent.team ==  team {
                    return entity
                }
            }
            return nil
        }
    }
    // ham tra ve tat cac cac MoveComponent thuoc doi tuong cung 1 team
    func moveComponent(for team : Team) -> [MoveComponent] {
        let entitiesToMove = entities(for : team)
        var moveComponents = [MoveComponent]()
        for entity in entitiesToMove{
            if let moveComponent = entity.component(ofType: MoveComponent.self) {
                moveComponents.append(moveComponent)
            }
        }
        return moveComponents
    }
    
    
    //tha monster
    func spawnMonster(team : Team, monsterKind : MonsterKind){
        guard let teamEntity = caste(for: team) ,
            let teamcastleComponent = teamEntity.component(ofType : CastleComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType : SpriteComponent.self) else {
                return
        }
        let monster = Monster(monsterKind)
        
        // kiem tra enough Coin to spawn
        if teamcastleComponent.coin > monster.coin {
            teamcastleComponent.coin -= monster.coin
            //lay entity fu hop voi kind of monster
            var monsterEntity : GKEntity
            switch monsterKind {
            case .quirk :
                monsterEntity = Quirk(team: team, entityManager: self)
            case .zap :
                monsterEntity = Zap(team: team, entityManager: self)
            case .munch :
                monsterEntity = Munch(team: team, entityManager: self)
            }
            //set node of zap
            if let spriteComponent = monsterEntity.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
                spriteComponent.node.zPosition = 2
            }
            add(entity: monsterEntity)
        }
        
    }
    
    
}
