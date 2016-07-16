//
//  SliderLabelContainer.swift
//  HotGirls
//
//  Created by 臧其龙 on 15/5/18.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

import UIKit

enum SliderLabelContainerType{
    case SingleDigitType
    case TensDigitType
}

class SliderLabelContainer: UIView {
    
    var singleDigitsScroll:UIScrollView!
    
    var dates: [NSDateComponents] = [] {
        didSet {
            addSubviews()
        }
    }

    func addSubviews() {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        singleDigitsScroll = UIScrollView(frame: self.bounds)
        singleDigitsScroll.userInteractionEnabled = false
        singleDigitsScroll.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)*10)
        for i in 0..<dates.count{
            let label:UILabel = UILabel(frame: CGRectMake(0, CGRectGetHeight(self.bounds) * CGFloat(i), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)))

            let dateComponent = dates[i]
            let monthStr = dateComponent.month < 10 ? "0\(dateComponent.month)" : "\(dateComponent.month)"
            let title = "\(dateComponent.year)年\(monthStr)月"
            label.text = title
            label.font = UIFont.boldSystemFontOfSize(15)
            label.textAlignment = NSTextAlignment.Center
            singleDigitsScroll.addSubview(label)
        }
        singleDigitsScroll.setContentOffset(CGPointMake(0, CGRectGetHeight(self.bounds)), animated: false)
        
        self.addSubview(singleDigitsScroll)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func scrollToNum(num:Int, callback: (() -> Void)? = nil ){
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.singleDigitsScroll.contentOffset = CGPointMake(0, CGRectGetHeight(self.bounds) * CGFloat(num))
            }) { _ in
                if callback != nil {
                    callback!()
                }
        }
    }
}
