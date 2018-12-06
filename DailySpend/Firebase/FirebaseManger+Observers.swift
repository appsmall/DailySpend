//
//  FirebaseManger+Observers.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 21/10/18.
//  Copyright © 2018 outect. All rights reserved.
//

import Foundation
import Firebase

extension FirebaseManager{
    
    func categoriesObservers(user : User , completion : @escaping (Bool, [Category]?) -> ()){
        let categoryRef = databaseRef.child("Categories").child(user.userId)
        categoryRef.observe(.value) { (snapshot) in
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
                    completion(true, categories)
                }
            }else{
                completion(false, nil)
            }
        }
    }
}
