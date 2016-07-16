//
//  ViewController.swift
//  scrollLoop
//
//  Created by D_ttang on 15/12/1.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todayBtn: UIButton!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sliderMonthView: SliderLabelContainer!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    var height: CGFloat = 0
    var pageOne: CalendarCell!
    var pageTwo: CalendarCell!
    var pageThree: CalendarCell!
    
    var nowDate = NSDate()
    var currentDate: NSDate?
    
    var nowDateComponents = NSDateComponents()
    var currentDateComponents = NSDateComponents()
    var frontDateComponents = NSDateComponents()
    var nextDateComponents = NSDateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        sliderMonthView.backgroundColor = UIColor.whiteColor()
        todayBtn.setTitle(MyIcoMoon.e8df, forState: UIControlState.Normal)
        
        let unitFlags: NSCalendarUnit = [.Hour, .Day, .Month, .Year]
        nowDateComponents = NSCalendar.currentCalendar().components(unitFlags, fromDate: nowDate)
        currentDateComponents = NSCalendar.currentCalendar().components(unitFlags, fromDate: nowDate)
        
        countDateComponents(currentDateComponents)
        self.sliderMonthView.dates = [self.frontDateComponents, self.currentDateComponents, self.nextDateComponents]
        
        scrollView.delegate = self
        contentScrollView.delegate = self
        
        let scrollViewHidenPan = UIPanGestureRecognizer(target: self, action: "scrollViewHiden:")
        view.addGestureRecognizer(scrollViewHidenPan)
        let scrollViewShowPan = UIPanGestureRecognizer(target: self, action: "scrollViewShow:")
        headerView.addGestureRecognizer(scrollViewShowPan)
        
        
        contentScrollView.scrollEnabled = false
        
        headerView.layer.shadowOpacity = 0.7
        headerView.layer.shadowOffset  = CGSize(width: 1, height: 1)
        headerView.layer.shadowColor   = UIColor.grayColor().CGColor
        
        let y: CGFloat = 0
        scrollView.contentSize.width = self.view.frame.width * 3
        contentScrollView.contentSize.height = self.view.frame.height * 3

        pageOne = CalendarCell(frame: CGRect(x: 0, y: y, width: self.view.frame.width, height: self.scrollView.frame.height))
        pageTwo = CalendarCell(frame: CGRect(x: self.view.frame.width, y: y, width: self.view.frame.width, height: self.scrollView.frame.height))
        pageThree = CalendarCell(frame: CGRect(x: self.view.frame.width * 2, y: y, width: self.view.frame.width, height: self.scrollView.frame.height))
        
        pageTwo.TapDayCell = {(year:Int,month:Int,day:Int ) in
            print(year)
            print(month)
            print(day)
//            print(Datecalculate.LunarForSolarYear(year, wCurMonth: month, wCurDay: day))
//            self.scrollViewHiden()
            
        }
        pageOne.TapDayCell = {(year:Int,month:Int,day:Int ) in
            print(year)
            print(month)
            print(day)
//            self.scrollViewHiden()
        }
        pageThree.TapDayCell = {(year:Int,month:Int,day:Int ) in
            print(year)
            print(month)
            print(day)
//            self.scrollViewHiden()
        }
        
        setDateComponentsToSubViews()
        scrollView.addSubview(pageOne)
        scrollView.addSubview(pageTwo)
        scrollView.addSubview(pageThree)
        
        self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width, 0), animated: false)
        self.contentScrollView.setContentOffset(CGPointMake(0, self.view.frame.height ), animated: false)
        
        updateScrollViewHeight()
    }
    
    // MARK: - backToday
    @IBAction func backToday(sender: AnyObject) {
        
        if currentDateComponents.year > nowDateComponents.year {
            scrollLeft()
            return
        }
        if currentDateComponents.year == nowDateComponents.year {
            if currentDateComponents.month == nowDateComponents.month {
                return
            }
            if currentDateComponents.month > nowDateComponents.month {
                    scrollLeft()
                return
            }
            if currentDateComponents.month < nowDateComponents.month {
                scrollRight()
                return
            }
        }
        if currentDateComponents.year < nowDateComponents.year {
            scrollRight()
        }
    }
    func scrollLeft() {
        pageOne.dateComponents = nowDateComponents
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset = CGPointMake(0, 0)
            self.sliderMonthView.scrollToNum(Int(-1)) {
                _ in
                self.countDateComponents(self.nowDateComponents)
                self.setDateComponentsToSubViews()
                self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width, 0), animated: false)
                self.updateScrollViewHeight()
                self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
                self.sliderMonthView.dates = [self.frontDateComponents, self.currentDateComponents, self.nextDateComponents]
            }
            }, completion: {
                _ in
        })
    }
    func scrollRight() {

        pageThree.dateComponents = nowDateComponents
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset = CGPointMake(self.view.frame.width * 2, 0)
            self.sliderMonthView.scrollToNum(Int(3)) {
                _ in
                self.countDateComponents(self.nowDateComponents)
                self.setDateComponentsToSubViews()
                
                self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width, 0), animated: false)
                self.updateScrollViewHeight()
                self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
                
                self.sliderMonthView.dates = [self.frontDateComponents, self.currentDateComponents, self.nextDateComponents]
            }
            }, completion: {
                _ in               
        })
    }
    
    
    // MARK: -setComponents
    func countDateComponents (currentDateComponents: NSDateComponents) {
        let year = currentDateComponents.year
        let month = currentDateComponents.month
        
        self.currentDateComponents.year = year
        self.currentDateComponents.month = month

        let pageOneYear = month == 1 ? year - 1 : year
        let pageOneMonth = month == 1 ? 12 : month - 1
        frontDateComponents.month = pageOneMonth
        frontDateComponents.year = pageOneYear

        let pageThreeYear = month == 12 ? year + 1 : year
        let pageThreeMonth = month == 12 ? 1 : month + 1
        
        nextDateComponents.month = pageThreeMonth
        nextDateComponents.year = pageThreeYear
    }
    
    func setDateComponentsToSubViews() {
        pageOne.dateComponents = frontDateComponents
        pageTwo.dateComponents = currentDateComponents
        pageThree.dateComponents = nextDateComponents
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if scrollView == self.contentScrollView {
//            print(scrollView.contentOffset.y)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.contentScrollView {
            print(scrollView.contentOffset.y)
//            if scrollView.contentOffset.y <= height && scrollView.contentOffset.y >= 0{
//                scrollViewHeight.constant = height - scrollView.contentOffset.y
//            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if self.scrollView == scrollView {
            let pageWidth = scrollView.frame.size.width
            let currentPage = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            if (currentPage == 0) {
                let tmpView = self.pageThree
                let tmpDateComponents = nextDateComponents
                self.pageThree = self.pageTwo
                nextDateComponents = currentDateComponents
                self.pageTwo = self.pageOne
                currentDateComponents = frontDateComponents
                self.pageOne = tmpView
                frontDateComponents = tmpDateComponents
            }
            
            if (currentPage == 2){
                let tmpView = self.pageOne
                let tmpDateComponents = frontDateComponents
                self.pageOne = self.pageTwo
                frontDateComponents = currentDateComponents
                self.pageTwo = self.pageThree
                currentDateComponents = nextDateComponents
                self.pageThree = tmpView
                nextDateComponents = tmpDateComponents
            }
            
            countDateComponents(currentDateComponents)
            setDateComponentsToSubViews()
            self.pageOne.frame.origin.x = 0
            self.pageTwo.frame.origin.x = self.view.frame.width
            self.pageThree.frame.origin.x = self.view.frame.width * 2
            self.scrollView.setContentOffset(CGPointMake(self.view.frame.size.width, 0), animated: false)
            updateScrollViewHeight()
            sliderMonthView.scrollToNum(Int(currentPage)) { () -> Void in
                self.sliderMonthView.dates = [self.frontDateComponents, self.currentDateComponents, self.nextDateComponents]
            }
        }
    }
    
    func updateScrollViewHeight() {
        scrollViewHeight.constant = pageTwo.frame.height
        height = pageTwo.frame.height
        UIView.animateWithDuration(0.5) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }

    func scrollViewShow(gestureRecognizer: UIPanGestureRecognizer) {
        let transitionY = gestureRecognizer.translationInView(self.view).y
        var resultHeight: CGFloat = 0.0
        if scrollViewHeight.constant == height {
            self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
            return
        }
        if transitionY > 0 {
            resultHeight = transitionY > height ? height : transitionY
            scrollViewHeight.constant = resultHeight
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if resultHeight > height / 2 {
                scrollViewHeight.constant = height
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.view.layoutIfNeeded()
                    }, completion: {
                        _ in
                            self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
                    })
            }else {
                scrollViewHeight.constant = 0
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: {
                        _ in
                        self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
                })
            }
        }
        
        
    }
    func scrollViewHiden(gestureRecognizer: UIPanGestureRecognizer) {
        let transitionY = gestureRecognizer.translationInView(self.view).y
        
        if scrollViewHeight.constant == 0 {
            self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
            return
        }
        if transitionY < 0 {
            scrollViewHeight.constant = height + transitionY > 0 ?  height + transitionY : 0
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if height + transitionY < height / 2 {
                scrollViewHeight.constant = 0
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: {
                        _ in
                        self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
                })
            }else {
                scrollViewHeight.constant = height
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: {
                        _ in
                        self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
                })
            }
        }
    }
    
    func scrollViewHiden() {
        self.scrollViewHeight.constant = 0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }, completion: {
                _ in
                self.contentScrollView.scrollEnabled = self.scrollViewHeight.constant <= 0 ? true : false
        })
    }
}

