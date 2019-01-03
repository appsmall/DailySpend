//
//  Utility.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 19/10/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class Utility{
    
    static func currentDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDateString = formatter.string(from: Date())
        print(currentDateString)
        return currentDateString
    }
    
    static func currentMonth() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM_yyyy"
        let currentMonthString = formatter.string(from: Date())
        print(currentMonthString)
        return currentMonthString
    }
    
    static func monthForDate(date : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if let finalDate = dateFormatter.date(from: date){
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM_yyyy"
            let month = monthFormatter.string(from: finalDate)
            print(month)
            return month
        }else{
            return "Error"
        }
        
    }
    
    // MARK:- ALERT CONTROLLER
    static func alert(on: UIViewController, title: String, message: String, withActions:[UIAlertAction], style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in withActions {
            alert.addAction(action)
        }
        on.present(alert, animated: true, completion: nil)
    }
    
}
