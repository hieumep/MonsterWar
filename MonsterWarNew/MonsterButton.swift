//
//  MonsterButton.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit

class MonsterButton : SKSpriteNode {
    let buttonPress : () -> ()
    
    init(monster : Monster, buttonPress : @escaping () -> ()) {
        //initial new button
        let texture = SKTexture(imageNamed: "button")
        self.buttonPress = buttonPress
        super.init(texture: texture, color: .white, size: texture.size())
        
        // add monster photo
        let monsterTexture = monster.textureHome
        let monsterNode = SKSpriteNode(texture: monsterTexture)
        monsterNode.position = CGPoint(x: -size.width * 0.25, y: 0)
        monsterNode.zPosition = 1
        addChild(monsterNode)
        
        // add label 
        let coin : String = String(monster.coin)
        let label = CoinLabel(text: coin, aligment: .right)
        label.position = CGPoint(x: size.width * 0.25, y: 0)
        label.zPosition = 1
        addChild(label)
        
        self.zPosition = 1
        self.isUserInteractionEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonPress()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
