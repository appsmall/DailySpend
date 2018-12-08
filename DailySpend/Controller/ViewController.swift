//
//  ViewController.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 14/10/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var category = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //addNewCategoryWithSubCategory()
      //getCategories()
      // deleteCategory()
        
     // print(Utility.currentDate())
     // print(Utility.currentMonth())
        
        
//     let dailyCategorySpent = [CategorySpend.init(name: "Fuel", subCategory: "Activa", price: 300),
//                               CategorySpend.init(name: "Fuel", subCategory: "Truck", price: 5000),
//                               CategorySpend.init(name: "Bills", subCategory: "Newspaper", price: 40),
//                               CategorySpend.init(name: "Grocery", subCategory: "Other", price: 5000)]
        
        //Only single category can be update one time
//        let dailyCategorySpent = [CategorySpend.init(name: "Investment", subCategory: "Mutual Fund", price: 5000)]
//        addSpendForDay(dailySpend: dailyCategorySpent)
        
        //FirebaseManager.shared.categoriesObservers()
        
        //calculateDailySpend(date: "20-10-2018")
        User.shared().userId = "zLcehL4UCINao3azsJtGyrujXQ03"
        print(User.shared().categories)
        perform(#selector(checkCategory), with: nil, afterDelay: 60)
    }
    
    @objc func checkCategory(){
        User.destroy()
    }
    
    //MARK:- Fetch Update and Delete Daily Spent
    func addSpendForDay(dailySpend : [CategorySpend]){
        FirebaseManager.shared.updateDailySpend(userId: "zLcehL4UCINao3azsJtGyrujXQ03", date: "20-10-2018", totalDailySpend: dailySpend)
    }
    
//    func calculateDailySpend(date : String){
//        FirebaseManager.shared.calculateDailySpend(userId: "zLcehL4UCINao3azsJtGyrujXQ03", date: "18-10-2018")
//    }
    
    
    //MARK:- Fetch, Update and delete Category
    func addNewCategoryWithSubCategory(){
        let category = Category.init(name: "Bills", subcategory: ["Newspaper","Electricity"], icon: "")
        FirebaseManager.shared.addNewCategoryWithSubCategory(userId: "zLcehL4UCINao3azsJtGyrujXQ03", category: category)
        
    }
    
    func getCategories(){
        FirebaseManager.shared.getCategories(userId: "zLcehL4UCINao3azsJtGyrujXQ03") { (status, categories) in
            if status{
                guard let allUserCategories = categories else{
                    print("No Category present for the user")
                    return
                }
                User.shared().categories = allUserCategories
                print(User.shared().categories)
            }
        }
    }
    
    func deleteCategory(){
        let category = Category.init(name: "Bills", subcategory: ["Newspaper"], icon: nil)
        FirebaseManager.shared.deleteCategory(userId: "zLcehL4UCINao3azsJtGyrujXQ03", category: category)
    }


}

