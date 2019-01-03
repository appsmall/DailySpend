//
//  ContainerVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    struct Storyboard {
        static let kCellId = "TabCell"
        static let containerVCToNavigationVC = "ContainerVCToNavigationVC"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let menuItems = [(Menu.dashboard, "ic_dashboard"), (Menu.addSpend, "ic_add-spend"), (Menu.category, "ic_category"), (Menu.spendDetails, "ic_spend-detail"), (Menu.report, "ic_Report")]
    
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("CategoryVC is destroyed")
    }
    
    
    // MARK:- NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.containerVCToNavigationVC {
            if let destination = segue.destination as? NavigationVC {
                destination.containerVC = self
            }
        }
    }
}


// MARK:- COLLECTION VIEW DATA SOURCE & DELEGATE METHODS
extension ContainerVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.kCellId, for: indexPath) as! TabBarCell
        let item = menuItems[indexPath.row]
        cell.tabLabel.text = item.0
        cell.tabImageView.image = UIImage(named: item.1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = menuItems[indexPath.row].0
        
        switch selectedItem {
        case Menu.dashboard:
            print("Dashboard")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.dashboardVC])
            
        case Menu.addSpend:
            print("Add Spend")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.dashboardVC])
            
        case Menu.category:
            print("Category")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.categoryVC])
            
        case Menu.spendDetails:
            print("Spend Details")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.spendDetailVC])
            
        case Menu.report:
            print("Report")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.reportVC])
            
        default:
            break
        }
    }
}
