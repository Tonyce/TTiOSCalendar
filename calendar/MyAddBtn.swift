//
//  MyAddBtn.swift
//  superman
//
//  Created by D_ttang on 15/7/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

@IBDesignable
class MyAddButton: UIButton {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.redColor().setFill()
        path.fill()
        
        let plusHeight:CGFloat = 2.0
        let plusWidth:CGFloat  = min(bounds.width, bounds.height) * 0.4
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = plusHeight
        
        plusPath.moveToPoint(CGPoint(x: bounds.width / 2 - plusWidth / 2 + 0.5 , y: bounds.height / 2 + 0.5))
        plusPath.addLineToPoint(CGPoint(x: bounds.width / 2 + plusWidth / 2 + 0.5 , y: bounds.height / 2 + 0.5))
        
        plusPath.moveToPoint(CGPoint(x: bounds.width / 2 + 0.5, y: bounds.height / 2 - plusWidth / 2 + 0.5))
        plusPath.addLineToPoint(CGPoint(x: bounds.width / 2 + 0.5, y: bounds.height / 2 + plusWidth / 2 + 0.5))
        
        
        UIColor.whiteColor().setStroke()
        plusPath.stroke()
        layer.shadowOpacity = 0.7
        layer.shadowOffset  = CGSize(width: 1, height: 1)
        layer.shadowColor   = UIColor.grayColor().CGColor
    }
    
}