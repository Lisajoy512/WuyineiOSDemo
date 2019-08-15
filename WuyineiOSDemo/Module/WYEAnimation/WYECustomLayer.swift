//
//  WYECustomLayer.swift
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/8/14.
//  Copyright © 2019 wuyine. All rights reserved.
//

import UIKit

class WYECustomLayer: CALayer {
    
    override init() {
        print("layer init")
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("layer init coder")
        fatalError("init(coder:) has not been implemented")
    }
    
    override  var frame: CGRect {
        didSet {
            print("layer set frame invoke")
            super.frame = frame
        }
    }
    
    override var position: CGPoint {
        didSet {
            print("layer set position invoke")
            super.position = position
        }
    }
    
    override var bounds: CGRect {
        didSet {
            print("layer set bounds invoke")
            super.bounds = bounds
        }
    }
    
    override func display() {
        print("layer display")
        super.display()
    }
}
