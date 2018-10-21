//
//  Item.swift
//  d06
//
//  Created by Ivan SELETSKYI on 10/9/18.
//  Copyright © 2018 Ivan SELETSKYI. All rights reserved.
//

import UIKit


class Item: UIView {

    var len: CGFloat = 0
    
    var centerV: CGPoint?
    var cLen: CGFloat = 0
    
    let elasticity : UIDynamicItemBehavior = {
        let did = UIDynamicItemBehavior()
        did.allowsRotation = true
        did.elasticity = 0.4
        return did
    }()

    let gravity = UIGravityBehavior()
    let collider : UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
    
    lazy var animator : UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
    var animation : Bool = false{
        didSet{
            if animation{
                animator.addBehavior(gravity)
                animator.addBehavior(collider)
                animator.addBehavior(elasticity)
            }
            else{
                animator.removeBehavior(gravity)
                animator.removeBehavior(collider)
                animator.removeBehavior(elasticity)
            }
        }
    }
    
    func getRandomColor() -> UIColor
    {
        switch arc4random() % 6 {
        case 0:
            return UIColor.red
        case 1:
            return UIColor.blue
        case 2:
            return UIColor.green
        case 3:
            return UIColor.yellow
        case 4:
            return UIColor.cyan
        case 5:
            return UIColor.purple
        default:
            return UIColor.black
        }
    }
    
    func createCircle(x: CGFloat, y: CGFloat) {

        let radius: CGFloat = 50

        let frame = CGRect(origin:CGPoint(x: x - CGFloat(100 / 2), y: y - CGFloat(100 / 2)), size: CGSize(width: 100, height: 100))
        let item = UIView(frame: frame)
        item.backgroundColor = getRandomColor()
        item.layer.cornerRadius = radius
        item.clipsToBounds = true
        addSubview(item)
        gravity.addItem(item)
        elasticity.addItem(item)
        collider.addItem(item)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(Item.panGesture))
        item.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(Item.pinchGesture))
        item.addGestureRecognizer(pinchGesture)
    }

    func createSquare(x: CGFloat, y: CGFloat) {

        let frame = CGRect(origin:CGPoint(x: x - CGFloat(100 / 2), y: y - CGFloat(100 / 2)), size: CGSize(width: 100, height: 100))
        let item = UIView(frame: frame)
        item.backgroundColor = getRandomColor()
        item.layer.cornerRadius = 0
        item.clipsToBounds = true
        addSubview(item)
        gravity.addItem(item)
        elasticity.addItem(item)
        collider.addItem(item)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(Item.panGesture))
        item.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(Item.pinchGesture))
        item.addGestureRecognizer(pinchGesture)
    }

    // Pan Recognizer
    
    @objc func panGesture(sender: UIPanGestureRecognizer) {
        let spoint = sender.location(in: inputView)
        self.gravity.removeItem(sender.view!)
        self.elasticity.removeItem(sender.view!)
        self.collider.removeItem(sender.view!)
        sender.view?.center = spoint
        self.gravity.addItem(sender.view!)
        self.elasticity.addItem(sender.view!)
        self.collider.addItem(sender.view!)
    }
    
    @objc func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        if (sender.state.rawValue == 1){
            len = (sender.view?.frame.size.height)!
            centerV = sender.view?.center
        }
        cLen = sender.scale
        print(sender.scale)
        self.gravity.removeItem(sender.view!)
        self.elasticity.removeItem(sender.view!)
        self.collider.removeItem(sender.view!)
        sender.view?.frame.size.height = len * cLen
        sender.view?.frame.size.width = len * cLen
        if (sender.view?.layer.cornerRadius != 0) {
            sender.view?.layer.cornerRadius = (sender.view?.frame.size.height)! / 2
        }
        self.gravity.addItem(sender.view!)
        self.elasticity.addItem(sender.view!)
        self.collider.addItem(sender.view!)
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

