//
//  ViewController.swift
//  Test3DLayer
//
//  Created by 孟兴东 on 15/11/19.
//  Copyright © 2015年 孟兴东. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let container = CATransformLayer()
    var angle: CGFloat = 0.0
    var XPanOffset: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        container.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        self.view.layer.addSublayer(container)
        
        self.addPlane()
        self.addPlane()
        self.addPlane()
        self.addPlane()
        self.addPlane()
        
        self.animate()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "pan:")
        
        self.view.addGestureRecognizer(panGesture)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addPlane() {
        let planSize = CGSizeMake(100, 150)
        
        let layer = CAGradientLayer()
        
        layer.frame = CGRectMake(200, 200, 50, 40)
        
        layer.anchorPoint = CGPointMake(0.5, 0.5)
        
        layer.borderColor = UIColor(white: 1.0, alpha: 0.3).CGColor
        
        layer.cornerRadius = 10
        
        layer.borderWidth = 4
        
        layer.colors = [UIColor.purpleColor().CGColor, UIColor.redColor().CGColor]
        
        layer.locations = [NSNumber(float: 0.0), NSNumber(float: 1.0)]
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 20
        
        layer.doubleSided = true
        
        container.addSublayer(layer)
        
    }
    
    func animate() {
        let degForPlane: CGFloat = 360 / CGFloat(container.sublayers!.count)
        
        var degX = angle
        
        for layer in container.sublayers! {
            var t = CATransform3DIdentity
            
            t.m34 = 1.0 / -1000.0
            
            t = CATransform3DRotate(t, degToRad(degX), 0.0, 1.0, 0.0)
            t = CATransform3DTranslate(t, 0.0, 0.0, 100.0)
            
            CATransaction.setAnimationDuration(0.0)
            
            layer.transform = t
            
            degX += degForPlane
            
        }
    }
    
    func pan(gesture: UIPanGestureRecognizer) {
        let xOffset: CGFloat = gesture.translationInView(self.view).x
        
        if gesture.state == .Began {
            XPanOffset = 0.0
        }
        
        let movedBy = xOffset * 0.5 - XPanOffset
        
        XPanOffset += movedBy
        
        angle += movedBy
        
        self.animate()
    }
    
    func degToRad(deg: CGFloat) -> CGFloat {
        return deg * CGFloat(M_PI) / 180.0
    }
}



