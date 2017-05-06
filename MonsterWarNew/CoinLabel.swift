//
//  CoinLabel.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import Foundation
import SpriteKit

class CoinLabel : SKLabelNode{
    
    init(text : String, aligment : SKLabelHorizontalAlignmentMode) {
        super.init()
        self.fontName = "Courier-Bold"
        self.text = text
        self.fontSize = 50
        self.fontColor = SKColor.black
        self.zPosition = 1
        self.horizontalAlignmentMode = aligment
        self.verticalAlignmentMode = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
