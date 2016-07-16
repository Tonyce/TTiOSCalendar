//
//  DayCell.swift
//  Swift616
//
//  Created by SunSet on 14-6-16.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DayCellDelegate : NSObjectProtocol {
    optional func changeItem(year:Int,month:Int,day:Int)
}



class DayCell: UIView {
    var button:UIButton?
    var dayLabel:UILabel?
    var nongLiLabel:UILabel?
    var explainLabel:UILabel?
    var day:Int?
    var month:Int?
    var year:Int?
    var delegate:DayCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        let dayLabelWidth: CGFloat = self.window?.frame.width > 320 ? 35.0 : 33.0
        
        

        // let point = CGPoint(x: (self.bounds.width - dayLabelWidth) / 2, y: (self.bounds.height - dayLabelWidth) / 2)
        let point = CGPoint(x: (self.bounds.width - dayLabelWidth) / 2, y: (self.bounds.height - dayLabelWidth) / 2)
        dayLabel = UILabel(frame: CGRect( origin: point,   size: CGSize(width: dayLabelWidth, height: dayLabelWidth)))
        dayLabel!.layer.cornerRadius = dayLabel!.frame.height / 2
        dayLabel!.layer.masksToBounds = true
        dayLabel!.font = UIFont.systemFontOfSize(13)
        dayLabel!.textAlignment = NSTextAlignment.Center
        dayLabel!.backgroundColor = UIColor.clearColor()
        addSubview(dayLabel!)
        
        nongLiLabel = UILabel(frame: CGRect(x: 0, y: (self.bounds.height + dayLabelWidth) / 2, width: self.bounds.width, height: 10) )
        nongLiLabel!.font = UIFont.systemFontOfSize(7)
        nongLiLabel!.textAlignment = NSTextAlignment.Center
        nongLiLabel!.backgroundColor = UIColor.clearColor()
        addSubview(nongLiLabel!)
        
        
        button = UIButton(type: UIButtonType.Custom)
        button!.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        button!.backgroundColor = UIColor.clearColor()
        button!.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(self.button!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buttonAction(sender: UIButton) {
        delegate?.changeItem?(year!, month: month!, day: day!)
        dayLabel!.backgroundColor = dayLabel!.backgroundColor == UIColor.redColor() ? UIColor.redColor() : UIColor.lightGrayColor()
    }
    
    func isToday()->Bool{
        let today = NSCalendar.currentCalendar().components([NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: NSDate()) as NSDateComponents
         if today.day == self.day && today.month == self.month && today.year == self.year{
            return true
        }else{
            return false
        }
    }
    
    
    func isFuture()->Bool{
        // let today = NSCalendar.currentCalendar().components([NSCalendarUnit.NSEraCalendarUnit, NSCalendarUnit.NSYearCalendarUnit, NSCalendarUnit.NSMonthCalendarUnit, NSCalendarUnit.NSDayCalendarUnit], fromDate: NSDate()) as NSDateComponents

        let today = NSCalendar.currentCalendar().components([NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: NSDate()) as NSDateComponents
        if self.year > today.year {
            return true
        }else if (self.year == today.year && self.month>today.month){
            return true;
        }else if (self.year == today.year && self.month==today.month && self.day > today.day){
            return true;
        }
        return false;
    }
    
    
    
    func setDay(newDay:Int){
        self.day = newDay
        self.nongLiLabel?.text = Datecalculate.LunarForSolarYear((self.year!,self.month!, newDay))
        dayLabel!.text = String(newDay)
        let today = NSCalendar.currentCalendar().components([NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: NSDate()) as NSDateComponents
        if self.month != today.month {
            if newDay == today.day {
                dayLabel!.backgroundColor = UIColor.lightGrayColor()
            }
        }

        if self.isToday() == true{
            dayLabel!.textColor = UIColor.redColor()
            dayLabel!.backgroundColor = UIColor.redColor()
            dayLabel?.textColor = UIColor.whiteColor()
        }else{


            if self.isFuture(){
                dayLabel!.textColor = UIColor.blackColor()
            }else{
                dayLabel!.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
                button!.setImage(nil, forState: UIControlState.Normal)
                button!.setImage(nil, forState: UIControlState.Selected)
                dayLabel!.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            }
        }
    }
 
}





 