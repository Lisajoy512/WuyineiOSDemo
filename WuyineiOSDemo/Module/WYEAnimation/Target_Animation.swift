//
//  Target_Animation.swift
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/8/8.
//  Copyright © 2019 wuyine. All rights reserved.
//

import UIKit

@objc(Target_Animation)
class Target_Animation: NSObject {
    @objc func Action_nativeFetchWYEAnimationVC() -> WYEAnimationVC {
        let vc = WYEAnimationVC.init()
        return vc
    }
}
