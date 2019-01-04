//
//  ReportCell.swift
//  DailySpend
//
//  Created by apple on 04/01/19.
//  Copyright © 2019 outect. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {

    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    
    var monthReport: MonthlyReport? {
        didSet {
            if let monthReport = monthReport {
                monthLabel.text = monthReport.month
                amountLabel.text = monthReport.amount
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewsAndConstraints()
    }
    
    func setupViewsAndConstraints() {
        self.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        amountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        amountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13).isActive = true
        
        self.addSubview(monthLabel)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        monthLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13).isActive = true
    }

}
