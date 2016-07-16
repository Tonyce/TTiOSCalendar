//
//  Color.swift
//  Swift616
//
//  Created by SunSet on 14-6-17.
//  Copyright (c) 2014年 SunSet. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
   class func colorWithHexString(stringToConvert:String)->UIColor{
        NSCharacterSet.whitespaceAndNewlineCharacterSet()
        var cString:NSString = stringToConvert.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.length < 6){
            return UIColor.clearColor();
        }
        if cString.hasPrefix("0X"){
            cString = cString.substringFromIndex(2)
        }
        if cString.hasPrefix("#"){
            cString = cString.substringFromIndex(1)
        }
        if (cString.length != 6){
            return UIColor.clearColor();
        }
        var range:NSRange = NSMakeRange(0, 2);
        let rString:String = cString.substringWithRange(range)
        range.location = 2;
        
        let gString:String = cString.substringWithRange(range)
        range.location = 4;
        let bString:String = cString.substringWithRange(range)
        var r:CUnsignedInt=0
        var g:CUnsignedInt=0
        var b:CUnsignedInt=0
    
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
}