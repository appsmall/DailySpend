//
//  FirebaseManager.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 14/10/18.
//  Copyright © 2018 outect. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager{
    
    private init(){}
    
    let databaseRef = Database.database().reference()
    
    static let shared = FirebaseManager()
    
    
    //MARK:- Category & Subcategory Operations
    func getCategories(userId : String, completionHandler:  @escaping (Bool, [Category]?) -> Void){
        let ref = databaseRef.child("Categories").child(userId)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                var categories = [Category]()
                if let categoriesInfo = snapshot.value as? [String : Any]{
                    for (key, value) in categoriesInfo{
                        let categoryName = key
                        var categoryImage = ""
                        var subCategory = [String]()
                        if let subCategoryDict = value as? [String : Any]{
                            let dictKeys = Array(subCategoryDict.keys)
                            if let image = subCategoryDict["image"] as? String{
                                categoryImage = image
                            }
                            let subCategories = dictKeys.filter{ $0 != "image"}
                            subCategory = subCategories
                        }
                        let categoryInfo = Category.init(name: categoryName, subcategory: subCategory, icon: categoryImage)
                        categories.append(categoryInfo)
                    }
                    completionHandler(true, categories)
                }
            }else{
                completionHandler(false, nil)
            }
        }
    }
    
    func addNewCategoryWithSubCategory(userId : String, category: Category){
        let ref = databaseRef.child("Categories").child(userId).child(category.name)
        var updateCategory: [String: Any] = ["image" : category.name]
        if let subCategories = category.subcategory{
            if !subCategories.isEmpty{
                for (index,value) in subCategories.enumerated(){
                    updateCategory[value] = index
                }
            }
        }
        ref.updateChildValues(updateCategory) { (error, ref) in
            if let err = error{
                print(err.localizedDescription)
                return
            }
            print("Successfully Updated")
        }
    }
    
    
    func deleteCategory(userId : String, category: Category){
        let ref = databaseRef.child("Categories").child(userId).child(category.name)
        if let subcategories = category.subcategory{
            
            if !subcategories.isEmpty{
                for subcategory in subcategories{
                    ref.child(subcategory).removeValue()
                }
                return
            }
        }
        ref.removeValue { (error, ref) in
            if let err = error{
                print(err.localizedDescription)
                return
            }
            
        }
    }
    
    //MARK:- Update Daily Spend
    /*
     Method : This method will update the daily spend in different subcategory of categories
     */
    func updateDailySpend(userId : String, date : String, totalDailySpend : [CategorySpend]){
        let dateRef = databaseRef.child("DailySpend").child(userId).child(date)
        if !totalDailySpend.isEmpty{
            for categorySpend in totalDailySpend{
                let ref = dateRef.child(categorySpend.name!)
                let newCategorySpend = categorySpend.price!
                var updatedValue = [String: Any]()
                if let subCategoryPrice = categorySpend.subCategory{
                    updatedValue[subCategoryPrice] = newCategorySpend
                }
                ref.updateChildValues(updatedValue) { (error, ref) in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    //Successfully Updated.
                    self.updateMonthlyDataSpend(userId : userId, date: date, category : categorySpend)
                }
            }
        }
    }
    
    /*
     Method : This method will update the total spend in the month as well as update the date wise spend in the month.
     */
    private func updateMonthlyDataSpend(userId : String, date : String, category : CategorySpend){
        let month = Utility.monthForDate(date: date)
        calculateDailySpend(userId: userId, date: date) { (totalDailySpend, totalDailyCategorySpend) in
            let ref = self.databaseRef.child("MonthlySpend").child(userId).child(month)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                var oldMonthlySpend = 0.0
                if snapshot.exists(){
                    //Monthly node already created
                    if let monthlyspendDict = snapshot.value as? [String : Any]{
                        if let amountAlreadySpend = monthlyspendDict["spend"] as? Double{
                            oldMonthlySpend += amountAlreadySpend
                        }
                    }
                }
                oldMonthlySpend += category.price!
                var updateMonthlySpend = [String : Any]()
                updateMonthlySpend["spend"] = oldMonthlySpend
                ref.updateChildValues(updateMonthlySpend, withCompletionBlock: { (error, ref) in
                    let income : Double!
                    income = 20000
                    if let currentIncome = income{
                        let saving = currentIncome - oldMonthlySpend
                        ref.updateChildValues(["savings" : saving])
                    }
                })
            
            })
            
            let spendDataRef = ref.child("spendPerDay")
            let dailyTotalSpend = [date : totalDailySpend]
            spendDataRef.updateChildValues(dailyTotalSpend)
            
            let refForCategory = ref.child("spendPerCategory")
            refForCategory.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if (snapshot.value as? [String : Any]) != nil{
                    for (category, price) in totalDailyCategorySpend{
                        let newSpend = price as! Double
                        refForCategory.updateChildValues([category : newSpend])
                    }
                    
                }else{
                    refForCategory.updateChildValues(totalDailyCategorySpend)
                }
                
            })
            
        }
    }
    
    
    /*
     Method : This method calculates the daily category wise spend as well as daily total spend
     */
    func calculateDailySpend(userId : String, date : String, completion : @escaping (Double,[String: Any]) -> ()) {
        let dateRef = databaseRef.child("DailySpend").child(userId).child(date)
        var totalDailySpend = 0.0
        var totalDailyCategorySpend = [String: Any]()
        dateRef.observeSingleEvent(of: .value) { (snapshot) in
            if let dailySpendDict = snapshot.value as? [String : Any]{
                for (category, subcategorySpend) in dailySpendDict{
                    totalDailyCategorySpend[category] = 0.0
                    if let subCategoryPrice = subcategorySpend as? [String : Double]{
                        var categorySpend = 0.0
                        for (_, price) in subCategoryPrice{
                            categorySpend += price
                        }
                        totalDailyCategorySpend[category] = categorySpend
                        totalDailySpend += categorySpend
                    }
                }
            }
            completion(totalDailySpend, totalDailyCategorySpend)
        }
    }
    
}
