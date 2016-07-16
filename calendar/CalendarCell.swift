//
//  DayCell.swift
//  Swift616
//
//  Created by SunSet on 14-6-16.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import Foundation
import UIKit


class CalendarCell: UIView, DayCellDelegate{
  
    
    var headView:UIView?
    var year:Int?
    var month:Int?
    
    var weekLabelArray:NSMutableArray?
    var dayLabelArray:NSMutableArray?
    
    var TapDayCell:( (year:Int,month:Int,day:Int )->Void)?
    
    let HeaderViewHeight: CGFloat = 20.0
    var dateComponents: NSDateComponents? {
        didSet {
            year = dateComponents?.year
            month = dateComponents?.month
            setup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        weekLabelArray = NSMutableArray()
        dayLabelArray = NSMutableArray()
        let weekView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: HeaderViewHeight))
        self.addSubview(weekView)
        let xOffset:CGFloat = self.frame.size.width / 7.0
        for (var i:Int = 0; i<7; i++) {
            let dayOfTheWeekLabel:UILabel = UILabel(frame: CGRectMake(xOffset*CGFloat(i), 0, xOffset, 20))
            dayOfTheWeekLabel.textColor = UIColor.blackColor()
            dayOfTheWeekLabel.textAlignment = NSTextAlignment.Center
            dayOfTheWeekLabel.backgroundColor = UIColor.clearColor()
            weekView.addSubview(dayOfTheWeekLabel)
            weekLabelArray!.addObject(dayOfTheWeekLabel)
        }
        self.updateWithDayNames(["日","一","二","三","四","五","六"])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMonthView(){
        let xOffset:CGFloat = self.frame.size.width / 7.0
        let yOffset:CGFloat = 44.0
        let monthDay:Int = Datecalculate.getDayCountOf(self.month!, year: self.year!)
        let startNumber:Int = Datecalculate.getStart(self.month!, year: self.year!)
        for (var i:Int = 0; i<monthDay; i++) {
            let numberX = (i+startNumber) % 7
            let numberY = (i+startNumber) / 7
            self.frame.size.height = CGFloat(numberY + 1) * yOffset
            
            let cell:DayCell = dayLabelArray!.objectAtIndex(i) as! DayCell
            
            cell.frame = CGRectMake(CGFloat(numberX) * xOffset, 70 + CGFloat(numberY) * yOffset, xOffset, yOffset)
            
            cell.delegate = self
            cell.month = self.month;
            cell.year = self.year;
            cell.setDay(i+1)
            if (i>=monthDay) {
                cell.hidden = true;
            }else{
                cell.hidden = false;
            }
        }
    }
    
    func createMonthView( ){

        for view in self.subviews {
            if view.dynamicType == DayCell.self {
                view.removeFromSuperview()
            }
        }
        
        
        let xOffset:CGFloat = self.frame.size.width / 7.0
        let yOffset:CGFloat = 44.0
        let monthDay:Int = Datecalculate.getDayCountOf(self.month!, year: self.year!)
        let startNumber:Int = Datecalculate.getStart(self.month!, year: self.year!)
        for (var i:Int = 0; i<monthDay; i++) {
            let numberX:Int = (i+startNumber)%7;
            let numberY:Int =  (i+startNumber)/7;
            self.frame.size.height = CGFloat(numberY + 1) * yOffset + HeaderViewHeight + 10
            let cell:DayCell = DayCell(frame: CGRectMake(CGFloat(numberX)*xOffset, HeaderViewHeight + CGFloat(numberY) * yOffset, xOffset, yOffset))
            self.addSubview(cell)
            cell.delegate = self
            cell.month = self.month
            cell.year = self.year
            cell.setDay(i+1)
            if (i>=monthDay) {
                cell.hidden = true;
            }else{
                cell.hidden = false;
            }
        }
   
    }


    func changeItem(year:Int,month:Int,day:Int){
        for view in self.subviews {
            if let view = view as? DayCell {
                if view.dayLabel?.backgroundColor != UIColor.redColor() {
                    view.dayLabel?.backgroundColor = UIColor.whiteColor()
                }
            }
        }
        TapDayCell!(year: year,month: month,day: day)
    }
    
    func setup(){
        self.createMonthView()
    }
    

    func updateWithDayNames(dayNames:NSArray){
        for (var i:Int = 0 ; i < dayNames.count; i++) {
            let label:UILabel =  weekLabelArray!.objectAtIndex(i) as! UILabel
            label.text = dayNames[i] as? String
            label.font = UIFont.systemFontOfSize(12)
            label.textColor = UIColor.grayColor()
//            if (i==0) {
//                label.textColor = UIColor.orangeColor()
//                
//            }
//            if (i == dayNames.count-1) {
//                label.textColor = UIColor.orangeColor()
//            }
        }
    }
}


