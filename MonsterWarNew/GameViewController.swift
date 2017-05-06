//
//  GameViewController.swift
//  MonsterWarNew
//
//  Created by Hieu Vo on 5/2/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let aspectRatio = view.bounds.size.width / view.bounds.size.height
        
        let scene = GameScene(size:CGSize(width: 640 * aspectRatio, height: 640))
        let skView = view as! SKView!
        skView?.showsFPS = false
        skView?.ignoresSiblingOrder = true
        skView?.presentScene(scene)
        
        }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
