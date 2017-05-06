//
//  SpriteComponent.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import GameplayKit
import SpriteKit

class SpriteComponent : GKComponent {
    let node : SKSpriteNode
    
    init(_ texture : SKTexture, entityManager : EntityManager){
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
