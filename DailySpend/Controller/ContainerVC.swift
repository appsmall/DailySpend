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
        static let containerVCToNavigationVC = "ContainerVCToNavigationVC"
    }
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("CategoryVC is destroyed")
    }
    

    // MARK:- IBACTIONS
    @IBAction func addSpendViewTapped(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.dashboardVC])
    }

    @IBAction func categoryViewTapped(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.categoryVC])
    }
    
    @IBAction func dashboardViewTapped(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.dashboardVC])
    }
    
    @IBAction func spendDetailsViewTapped(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.spendDetailVC])
    }
    
    @IBAction func reportViewTapped(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoadViewController"), object: nil, userInfo: [storyboardIdParam: StoryboardId.reportVC])
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
