//
//  WYEAnimationVC.swift
//  WuyineiOSDemo
//
//  Created by wuyine on 2019/8/7.
//  Copyright © 2019 wuyine. All rights reserved.
//


class WYEAnimationVC: WYEBaseViewController,CAAnimationDelegate {
    //MARK:- 属性
    var currentIndex = 0;
    lazy var redLabel : UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
        label.backgroundColor = UIColor.red
        return label
    }()
    
    lazy var greenLabel : UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 20, y: 100, width: 100, height: 50)
        label.backgroundColor = UIColor.green
        return label
    }()
    
    lazy var blueLabel : UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 20, y: 200, width: 100, height: 50)
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    lazy var imageView : UIImageView = {
        var imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 20, y: 300, width: 200, height: 200)
        imageView.image = UIImage(named: "0.jpg")
        return imageView
    }()
    
    lazy var button : UIButton = {
        var button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 20, y: 520, width: 200, height: 50)
        button.backgroundColor = UIColor.yellow
        button.setTitle("点击播放涟漪动画", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(showRipple), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var wyeView : WYECustomView = {
        var view = WYECustomView(frame: CGRect(x: 20, y: 600, width: 100, height: 50))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:基础动画+组合动画
        self.view.addSubview(redLabel)
        let caBasic = CABasicAnimation(keyPath: "position")
        caBasic.duration = 2
        caBasic.fromValue = redLabel.layer.position
        caBasic.toValue = CGPoint(x: 50, y: 200)
        caBasic.isRemovedOnCompletion = false
        caBasic.delegate = self
        caBasic.fillMode = CAMediaTimingFillMode.forwards
        
        let caBasic1 = CABasicAnimation(keyPath: "transform.scale")
        caBasic1.duration = 2
        caBasic1.toValue = CATransform3DMakeScale(2, 1.5, 1)
        caBasic1.isRemovedOnCompletion = false
        caBasic1.delegate = self
        
        let aniGroup = CAAnimationGroup();
        aniGroup.duration = 2
        aniGroup.animations = [caBasic,caBasic1];
        
        redLabel.layer.add(aniGroup, forKey: "redLabel1")
        
        //MARK: KeyframeAnimation动画
        self.view.addSubview(greenLabel)
        let key = CAKeyframeAnimation(keyPath: "position")
        key.duration = 3
        key.repeatCount = HUGE //无线循环
        key.calculationMode = CAAnimationCalculationMode.paced
        key.values = [greenLabel.frame.origin, CGPoint(x: 180, y: 70), CGPoint(x: 180, y: 200), greenLabel.frame.origin]
        key.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.6), NSNumber(value: 0.7), NSNumber(value: 0.8)]
        greenLabel.layer.add(key, forKey: "key")
        
        //MARK: CASpringAnimation动画
        self.view.addSubview(blueLabel)
        let spring = CASpringAnimation(keyPath: "position.y")
        spring.mass = 5
        spring.stiffness = 100
        spring.damping = 5
        spring.initialVelocity = 2
        spring.fromValue = blueLabel.layer.position.y
        spring.toValue = blueLabel.layer.position.y + 250
        spring.duration = spring.settlingDuration
        blueLabel.layer.add(spring, forKey: "spring")
        
        
        //MARK: CATransition动画
        //0.初始化ImageView
        self.view.addSubview(imageView)
        
        //1. 添加滑动手势
        let left = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(gesture:)))
        left.direction = .left
        imageView.addGestureRecognizer(left)
        let right = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(gesture:)))
        right.direction = .right
        imageView.addGestureRecognizer(right)
        
        self.view.addSubview(button)
        self.view.addSubview(wyeView)
    }
    
    //MARK:- 手势相关方法
    //左滑
    @objc fileprivate func leftSwipe(gesture: UIGestureRecognizer) {
        print("左滑动")
        transitionAnimation(isNext: true)
    }
    //右滑
    @objc fileprivate func rightSwipe(gesture: UIGestureRecognizer) {
        print("右滑动")
        transitionAnimation(isNext: false)
    }
    
    //设置转场动画
    fileprivate func transitionAnimation(isNext: Bool){
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.subtype = isNext ? CATransitionSubtype.fromRight : CATransitionSubtype.fromLeft
        transition.duration = 1
        imageView.image = getImage(isNext)
        imageView.layer.add(transition, forKey: "transition")
    }
    
    //获取下/上一张图片
    fileprivate func getImage(_ isNext: Bool) -> UIImage {
        currentIndex = isNext ? currentIndex + 1 : currentIndex - 1
        currentIndex = currentIndex < 0 ? 3 : currentIndex
        currentIndex = currentIndex > 3 ? 0 : currentIndex
        return UIImage(named: "\(currentIndex)" + ".jpg")!
    }
    
    //MARK:- button点击相关方法
    @objc func showRipple() -> (){
        
        let view = UIView.init(frame: CGRect(x: 130, y: 400, width: 200, height: 200))
        self.view.addSubview(view)
        
        let pulseLayer = CAShapeLayer.init()
        pulseLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        pulseLayer.borderColor = UIColor.red.cgColor
        pulseLayer.borderWidth = 1
        pulseLayer.opacity = 0
        
        let boundsAnima = CABasicAnimation.init(keyPath: "bounds")
        boundsAnima.fromValue = NSValue.init(cgRect: CGRect(x: 0, y: 0, width: 100, height: 100))
        boundsAnima.toValue = NSValue.init(cgRect: CGRect(x: 0, y: 0, width: 500, height: 500))
        
        let cornerRadiusAnima = CABasicAnimation.init(keyPath: "cornerRadius")
        cornerRadiusAnima.fromValue = NSNumber.init(value: 50.0)
        cornerRadiusAnima.toValue = NSNumber.init(value: 250.0)
        
        let opacityAnima = CABasicAnimation.init(keyPath: "opacity")
        opacityAnima.fromValue = NSNumber.init(value: 0.5)
        opacityAnima.toValue = NSNumber.init(value: 0.1)
        
        let animaGroup = CAAnimationGroup.init()
        animaGroup.animations = [cornerRadiusAnima,boundsAnima,opacityAnima];
        animaGroup.duration = 3;
        animaGroup.isRemovedOnCompletion = false;
        animaGroup.autoreverses = false;
        animaGroup.repeatCount = HUGE;
        
        let replicatorLayer = CAReplicatorLayer.init()
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100);
        replicatorLayer.instanceCount = 3;
        replicatorLayer.instanceDelay = 1;
        replicatorLayer.addSublayer(pulseLayer)

        pulseLayer.add(animaGroup, forKey: "group")
        view.layer.addSublayer(replicatorLayer)
    }
    
    //MARK:- 动画代理相关方法
    //开始执行
    func animationDidStart(_ anim: CAAnimation) {
        print("开始动画--layer:", redLabel.layer.position)
    }
    //结束之行
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("结束动画--layer:", redLabel.layer.position)
    }
}
