//
//  Extensions.swift
//  Calendar
//
//  Created by baegteun on 2021/08/04.
//

import Foundation
import UIKit


extension Date {
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
         return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
         return Calendar.current.component(.day, from: self)
    }
    
    public var toString: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd HH-mm"
        return formmater.string(from: self)
    }
}

class Extensions {
    static func autoSizingTextView(_ textview: UITextView){
        let size = CGSize(width: textview.frame.width, height: .infinity)
        let esSize = textview.sizeThatFits(size)
        textview.constraints.forEach{ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = esSize.height
            }
        }
    }
    static func getColor(_ color: String) -> UIColor {
        switch color {
        case "red":
            return UIColor.red
        case "systemRed":
            return UIColor.systemRed
            
        case "orange":
            return UIColor.orange
        case "systemOrange":
            return UIColor.systemOrange
            
        case "yellow":
            return UIColor.yellow
        case "systemYellow":
            return UIColor.systemYellow
            
        case "green":
            return UIColor.green
        case "systemGreen":
            return UIColor.systemGreen
            
        case "blue":
            return UIColor.blue
        case "systemBlue":
            return UIColor.systemBlue
        
        default:
            return UIColor.systemBlue
        }
    }
}
