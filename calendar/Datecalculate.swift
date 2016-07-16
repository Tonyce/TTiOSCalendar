//
//  DayCell.swift
//  Swift616
//
//  Created by SunSet on 14-6-16.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//
import Foundation

class Datecalculate: NSObject{
    class func getDayCountOf(month:Int , year:Int)->Int{
        switch (month) {
        case 1:
            return 31
        case 3:
            return 31
        case 4:
            return 30
        case 5:
            return 31
        case 6:
            return 30
        case 7:
            return 31
        case 8:
            return 31
        case 9:
            return 30
        case 10:
            return 31
        case 11:
            return 30
        case 12:
            return 31
        default:
            break
        }
        if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        {
            return 29
        }
        else {
            return 28
        }
    }
    
    class func getStart(month:Int , year:Int)->Int{
        var baseNumber:Int
        var startNumber:Int
        
        if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        {
            switch (month) {
            case 1:
                baseNumber = 0
                
            case 2:
                baseNumber = 3
                
            case 3:
                baseNumber = 4
                
            case 4:
                baseNumber = 0
                
            case 5:
                baseNumber = 2
                
            case 6:
                baseNumber = 5
                
            case 7:
                baseNumber = 0
                
            case 8:
                baseNumber = 3
                
            case 9:
                baseNumber = 6
                
            case 10:
                baseNumber = 1
                
            case 11:
                baseNumber = 4
                
            case 12:
                baseNumber = 6
                
            default:
                baseNumber = 0
            }
            startNumber = (year + year/4 + year/400 - year/100 - 2 + baseNumber + 1) % 7
        }
            
        else
        {
            switch (month) {
            case 1:
                baseNumber = 0
            case 2:
                baseNumber = 3
            case 3:
                baseNumber = 3
            case 4:
                baseNumber = 6
            case 5:
                baseNumber = 1
            case 6:
                baseNumber = 4
            case 7:
                baseNumber = 6
            case 8:
                baseNumber = 2
            case 9:
                baseNumber = 5
            case 10:
                baseNumber = 0
            case 11:
                baseNumber = 3;
                break;
            case 12:
                baseNumber = 5
            default:
                baseNumber = 0
            }
            startNumber = (year + year/4 + year/400 - year/100 - 1 + baseNumber + 1) % 7
        }
        return startNumber
    }
    
    class func getLayer(year:Int , month:Int)->Int{
        let monthDay =  self.getDayCountOf(month, year: year)
        let startNumber =  self.getStart(month, year: year)
        // var newLayer =  startNumber+monthDay
        let layer = ceilf(Float(startNumber+monthDay)/7)
        return Int(layer);
    }
  
    
    class func LunarForSolarYear (year: (Int, Int, Int)) -> String {
        
        let solarYear = LunarForSolarYear(year.0, wCurMonth: year.1, wCurDay: year.2)
     
        var showStr = solarYear.1
        
        if solarYear.1 == "初一" {
            showStr = solarYear.0 + "月"
        }
        
        if solarYear.0 == "正" && solarYear.1 == "初一" {
            showStr = "春节"
        }else if solarYear.0 == "正" && solarYear.1 == "十五" {
            showStr = "元宵节"
        }else if solarYear.0 == "二" && solarYear.1 == "初二" {
            showStr = "龙抬头"
        }else if solarYear.0 == "五" && solarYear.1 == "初五" {
            showStr = "端午节"
        }else if solarYear.0 == "七" && solarYear.1 == "初七" {
            showStr = "情人节"
        }else if solarYear.0 == "八" && solarYear.1 == "十五" {
            showStr = "中秋节"
        }else if solarYear.0 == "九" && solarYear.1 == "初九" {
            showStr = "重阳节"
        }else if solarYear.0 == "腊" && solarYear.1 == "初八" {
            showStr = "腊八节"
        }else if solarYear.0 == "腊" && solarYear.1 == "廿四" {
            showStr = "小年"
        }
        
        if (solarYear.2 + 1) % 4 == 0 {
            if solarYear.0 == "腊" && solarYear.1 == "廿九" {
                showStr = "除夕"
            }
        }else {
            if solarYear.0 == "腊" && solarYear.1 == "三十" {
                showStr = "除夕"
            }
        }

        
        return showStr
    }

    class func LunarForSolarYear(var wCurYear: Int, var wCurMonth: Int, var wCurDay: Int) -> (String, String, Int) {
        //农历日期名
        let cDayName = ["*", "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十", ""]
        //农历日期名
        //        let cDayName = ["*", "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十", nil]
        // 农历月份名
        // let cMonName =  ["*", "正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "腊", nil]
        let cMonName =  [ "*", "正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "腊", ""]
        //        //公历每月前面的天数
        let wMonthAdd = [0,31,59,90,120,151,181,212,243,273,304,334]
        //        //农历数据
        let wNongliData = [ 2635,333387,1701,1748,267701,694,2391,133423,1175,396438
                            ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
                            ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
                            ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
                            ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
                            ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
                            ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
                            ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
                            ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
                            ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877]
    
        var nBit: Int
        var n = 0
        var k = 0
        var nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38
        //
//         print("theDate \(nTheDate)")
        if ((wCurYear % 4) == 0) && (wCurMonth > 2) {
            nTheDate = nTheDate + 1
        }
//        print("theDate \(nTheDate)")
        //计算农历天干、地支、月、日
        var nIsEnd = 0
        var m = 0
        while nIsEnd != 1 {
            if(wNongliData[m] < 4095) {
                k = 11
            } else {
                k = 12
            }
            
            n = k
            while n>=0 {
                //获取wNongliData(m)的第n个二进制位的值
                nBit = wNongliData[m]
                for(var i=1; i < n+1; i++) {
                    nBit = nBit/2
                }
                
                nBit = nBit % 2
                
                if nTheDate <= (29 + nBit){
                    nIsEnd = 1
                    break
                }
                
                nTheDate = nTheDate - 29 - nBit
                n = n - 1
            }
            if nIsEnd != 0 {
                break
            }
            m = m + 1
        }
//                print("theDate \(nTheDate)")
        wCurYear = 1921 + m
        wCurMonth = k - n + 1
        wCurDay = nTheDate
        if (k == 12) {
            if (wCurMonth == wNongliData[m] / 65536 + 1) {
                wCurMonth = 1 - wCurMonth
            }else if (wCurMonth > wNongliData[m] / 65536 + 1) {
                wCurMonth = wCurMonth - 1
            }
        }
        
        
        //生成农历月
        var szNongliMonth = ""
        if wCurMonth < 1 {
            szNongliMonth = "闰\(cMonName[-1 * wCurMonth])"
        }else{
            szNongliMonth = cMonName[wCurMonth]
        }
        
        //生成农历日
        let szNongliDay = cDayName[wCurDay]
        
        //合并
        let _ = szNongliMonth + szNongliDay
//        let lunarDate = szNongliMonth + szNongliDay
        
//        return szNongliDay
        return ( szNongliMonth, szNongliDay, wCurYear)
        //        return ""
    }
}