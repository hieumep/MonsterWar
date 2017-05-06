//
//  Monster.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit

enum MonsterKind : String {
    case quirk = "quirk"
    case zap = "zap"
    case munch = "munch"
    
    static let allMonsters = [quirk, zap, munch]
}

struct Monster {
    var textureHome : SKTexture
    var textureAway : SKTexture
    var text : String
    var coin : Int
    init(_ monster : MonsterKind) {
        switch monster {
        case .quirk:
            textureHome = SKTexture(image: #imageLiteral(resourceName: "quirk1"))
            textureAway = SKTexture(image: #imageLiteral(resourceName: "quirk2"))
            text = monster.rawValue
            coin = 10
        case .zap :
            textureHome = SKTexture(image: #imageLiteral(resourceName: "zap1"))
            textureAway = SKTexture(image: #imageLiteral(resourceName: "zap2"))
            text = monster.rawValue
            coin = 25
        case .munch :
            textureHome = SKTexture(image: #imageLiteral(resourceName: "munch1"))
            textureAway = SKTexture(image: #imageLiteral(resourceName: "munch2"))
            text = monster.rawValue
            coin = 50
        }
    }
}
