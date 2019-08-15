//
//  WYECustomView.swift
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/8/14.
//  Copyright © 2019 wuyine. All rights reserved.
//

import UIKit

class WYECustomView: UIView {
        
    override init(frame: CGRect) {
        print("view init")
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("view init coder")
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        get {
            print("view get layerClass invoke")
            return WYECustomLayer.self
        }
    }
    
    override var frame: CGRect {
        didSet {
            print("view set frame invoke")
            super.frame = frame
        }
    }
    
    override var center: CGPoint {
        didSet {
            print("view set center invoke")
            super.center = center
        }
    }
    
    override var bounds: CGRect {
        didSet {
            print("view set bounds invoke")
            super.bounds = bounds
        }
    }
    
    override func draw(_ rect: CGRect) {
        print("view draw")
        super.draw(rect)
    }
}
