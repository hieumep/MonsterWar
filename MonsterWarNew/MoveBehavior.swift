//
//  MoveBehavior.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/3/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MoveBehavior : GKBehavior {
    init(targetSpeed : Float, seek : GKAgent, avoid : [GKAgent]){
        super.init()
        // if entity move , we set the goal
        if targetSpeed > 0{
            
            setWeight(0.1, for: GKGoal(toReachTargetSpeed: targetSpeed))
            // tim den doi tuong gan nhat
            setWeight(0.5, for: GKGoal(toSeekAgent: seek))
            // tranh cac doi tuong dong minh
            setWeight(1.0, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
        }
    }
}
