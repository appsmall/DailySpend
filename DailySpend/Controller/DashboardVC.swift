//
//  DashboardVC.swift
//  DailySpend
//
//  Created by apple on 20/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    struct Storyboard {
        static let dashboardVCToProfileVC = "dashboardVCToProfileVC"
    }

    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK:- IBACTIONS
    @IBAction func profileIconBtnPressed(_ sender: RoundButton) {
        self.performSegue(withIdentifier: Storyboard.dashboardVCToProfileVC, sender: nil)
    }
    
}
