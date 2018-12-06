//
//  User.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 21/10/18.
//  Copyright © 2018 outect. All rights reserved.
//

import Foundation

class User{
    
    private var activeUser = 0
    private init(){
        print("Active User : \(activeUser + 1)")
        
    }
    private static var sharedInstance : User?
    
    static func shared() -> User{
        guard let share = sharedInstance else{
            sharedInstance = User()
            return sharedInstance!
        }
        return share
    }
    
    static func destroy(){
        FirebaseManager.shared.databaseRef.child("Categories").child(User.shared().userId).removeAllObservers()
        sharedInstance = nil
    }
    
    deinit{
        print("Deinit method called")
    }
    
    private var _name : String?
    private var _userId : String?
    private var _currentSalary : Double?
    private var _emailId : String?
    private var _profileImage : String?
    private var _deviceToken : String?
    private var _notificationToken : String?
    private var _timestamp : String?
    private var _categories : [Category]?
    private var _phoneNumber : String?
    
    var phoneNumber : String{
        set{
            _phoneNumber = newValue
        }
        get{
            if _phoneNumber == nil{
                _phoneNumber = emptyString
            }
            return _phoneNumber!
        }
    }
    
    var categories : [Category]{
        set{
            _categories = newValue
        }
        get{
            if _categories == nil{
                _categories = [Category]()
            }
            return _categories!
        }
    }
    
    var timestamp : String{
        set{
            _timestamp = newValue
        }
        get{
            if _timestamp == nil{
                _timestamp = emptyString
            }
            return _timestamp!
        }
    }
    
    var notificationToken : String{
        set{
            _notificationToken = newValue
        }
        get{
            if _notificationToken == nil{
                _notificationToken = emptyString
            }
            return _notificationToken!
        }
    }
    
    var deviceToken : String{
        set{
            _deviceToken = newValue
        }
        get{
            if _deviceToken == nil{
                _deviceToken = emptyString
            }
            return _deviceToken!
        }
    }
    
    var profileImage : String{
        set{
            _profileImage = newValue
        }
        get{
            if _profileImage == nil{
                _profileImage = emptyString
            }
            return _profileImage!
        }
    }
    
    var emailId : String{
        set{
            _emailId = newValue
        }
        get{
            if _emailId == nil{
                _emailId = emptyString
            }
            return _emailId!
        }
    }
    
    var currentSalary : Double{
        set{
            _currentSalary = newValue
        }
        get{
            if _currentSalary == nil{
                _currentSalary = 0.0
            }
            return _currentSalary!
        }
    }
    
    var name : String{
        set{
            _name = newValue
        }
        get{
            if _name == nil{
                _name = emptyString
            }
            return _name!
        }
    }
    
    var userId : String{
        set{
            _userId = newValue
            updateCategories()
        }
        get{
            if _userId == nil{
                _userId = emptyString
            }
            return _userId!
        }
    }
    
    private func updateCategories (){
        FirebaseManager.shared.categoriesObservers(user: self) { (status, updatedCategories) in
            if status {
                self._categories = updatedCategories
            }
        }
    }
    
}
