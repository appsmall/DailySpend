//
//  ReportVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

struct MonthlyReport {
    let month: String
    let amount: String
}


class ReportVC: UIViewController {
    struct Storyboard {
        static let kCellId = "ReportCell"
    }
    
    lazy var generatePdfBtn : UIButton = {
        let button = UIButton()
        button.setTitle("Generate PDF", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Colors.viewBackground
        return button
    }()
    
    @IBOutlet weak var totalSavingsView: UIView!
    @IBOutlet weak var totalSavingLabel: UILabel!
    @IBOutlet weak var arrowReportImageView: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var reportTableView: UITableView!
    @IBOutlet weak var reportTableViewHeightConstraint: NSLayoutConstraint!
    var tableViewContentHeight: CGFloat!
    var isExpanded = false
    
    let reports = [MonthlyReport(month: "October 2018", amount: "Rs. 50000"),
                   MonthlyReport(month: "November 2018", amount: "Rs. 18000"),
                   MonthlyReport(month: "December 2018", amount: "Rs. 22500")]
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        self.perform(#selector(updateUIAfterDelay), with: nil, afterDelay: 0.0)
        self.setupGeneratePdfButtonConstraints()
    }
    
    
    // MARK:- CORE FUNCTIONS
    func updateUI() {
        self.arrowReportImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        reportTableView.layer.cornerRadius = 5
        reportTableView.layer.masksToBounds = true
        
        reportTableView.rowHeight = UITableView.automaticDimension
    }
    
    // used to handle table view height according to their content-size
    @objc func updateUIAfterDelay() {
        totalSavingsView.cornerView()
        tableViewContentHeight = reportTableView.contentSize.height
    }
    
    // MARK:- UPDATE TABLE VIEW HEIGHT CONSTRAINTS
    func setTableViewHeight(isOpen: Bool) {
        let viewHeight = self.view.frame.height / 2
        
        if isOpen {
            UIView.animate(withDuration: 0.4) {
                self.reportTableViewHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        else {
            if tableViewContentHeight > viewHeight {
                UIView.animate(withDuration: 0.5) {
                    self.reportTableViewHeightConstraint.constant = viewHeight
                    self.view.layoutIfNeeded()
                }
            }
            else {
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                    self.reportTableViewHeightConstraint.constant = self.tableViewContentHeight
                }
            }
        }
    }
    
    // MARK:- HIDE TABLE VIEW
    func hideTableView(selectedCategory: String) {
        var indexPaths = [IndexPath]()
        for row in reports.indices {
            print(row)
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
        
        if isExpanded {
            //categoryTableView.deleteRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.arrowReportImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
                self.setTableViewHeight(isOpen: true)
            }) { (status) in
            }
            isExpanded = false
        } else {
            //categoryTableView.insertRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3) {
                self.arrowReportImageView.transform = CGAffineTransform.identity
                
                self.reportTableViewHeightConstraint.constant = 250
                self.setTableViewHeight(isOpen: false)
            }
            isExpanded = true
        }
    }
    
    func setupGeneratePdfButtonConstraints() {
        self.view.addSubview(generatePdfBtn)
        generatePdfBtn.translatesAutoresizingMaskIntoConstraints = false
        generatePdfBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        generatePdfBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        generatePdfBtn.heightAnchor.constraint(equalToConstant: self.totalSavingsView.frame.height).isActive = true
        generatePdfBtn.topAnchor.constraint(equalTo: self.hiddenView.bottomAnchor).isActive = true
        generatePdfBtn.layer.cornerRadius = self.totalSavingsView.frame.height / 2
        generatePdfBtn.layer.masksToBounds = true
        
        generatePdfBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    
    // MARK:- IBACTIONS
    @IBAction func totalSavingViewTapped(_ sender: UITapGestureRecognizer) {
        self.view.bringSubviewToFront(reportTableView)
        hideTableView(selectedCategory: emptyString)
    }
    
}

// MARK:- TABLEVIEW DATASOURCE & DELEGATE METHODS
extension ReportVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kCellId, for: indexPath) as! ReportCell
        
        let selectedReport = reports[indexPath.row]
        cell.monthReport = selectedReport
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = reports[indexPath.row]
        self.hideTableView(selectedCategory: emptyString)
        totalSavingLabel.text = selectedItem.month + " (\(selectedItem.amount))"
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.generatePdfBtn.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
