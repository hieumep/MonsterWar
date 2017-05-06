//
//  AIComponent.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/5/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import SpriteKit
import GameplayKit

class AIComponent : GKComponent {
    var entityManager : EntityManager
    var nextMonster  : MonsterKind? = nil
    
    init(entityManager : EntityManager){
        self.entityManager = entityManager
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        guard let teamComponent = entity?.component(ofType: TeamComponent.self), let castleComponent = entity?.component(ofType: CastleComponent.self) else {
            return
        }
        if nextMonster == nil {
            let random = Int(arc4random()) % (MonsterKind.allMonsters.count)
            nextMonster = MonsterKind.allMonsters[random]
        }
            
        let monster = Monster(nextMonster!)        
        if castleComponent.coin > monster.coin {
            entityManager.spawnMonster(team: teamComponent.team, monsterKind: nextMonster!)
            nextMonster = nil
        }
        
    }
}
