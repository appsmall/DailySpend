//
//  ContainerVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}
