//
//  WYEMediator+Animation.swift
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/8/8.
//  Copyright © 2019 wuyine. All rights reserved.
//

extension WYEMediator {
   @objc func WYEMediator_detailAnimationVC() -> UIViewController {
        let vc = self.performTarget("Animation", action: "nativeFetchWYEAnimationVC", params: [:])
        if ((vc as? UIViewController) != nil) {
                return vc as! UIViewController
            }else {
                return UIViewController.init()
            }
        }
}
