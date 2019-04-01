//
//  NavigationVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class NavigationVC: UINavigationController {

    
    weak var containerVC: ContainerVC?
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeFirstVC()
    }
    
    
    // MARK:- CORE FUNCTIONS
    func initializeFirstVC() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadViewControllers), name: NSNotification.Name(rawValue: "LoadViewController"), object: nil)
        
        if let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: StoryboardId.dashboardVC) as? DashboardVC {
            self.pushViewController(dashboardVC, animated: true)
        }
    }
    
    @objc func loadViewControllers(notification: NSNotification) {
        if let userInfo = notification.userInfo as? [String:Any] {
            if let storyboardId = userInfo[storyboardIdParam] as? String {
                if let selectedVC = self.storyboard?.instantiateViewController(withIdentifier: storyboardId) {
                    if let presentedVC = self.viewControllers.first {
                        if selectedVC.classForCoder == presentedVC.classForCoder {
                            // Nothing will do when click on same view controller
                            //
                        }
                        else {
                            // Set selected view controller in the navigation stack
                            self.setViewControllers([selectedVC], animated: false)
                            
                            if let addSpendVC = selectedVC as? AddSpendVC {
                                addSpendVC.containerVC = containerVC
                            }
                        }
                    }
                }
            }
        }
    }

}
