//
//  AddSpendVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit


class AddSpendVC: UIViewController {
    struct Storyboard {
        static let kCellId = "AddSpendCell"
    }
    
    lazy var addSpendTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Storyboard.kCellId)
        return tableView
    }()
    
    
    @IBOutlet weak var categoryView: RoundCornerView!
    @IBOutlet weak var categoryArrowImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var subCategoryView: RoundCornerView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var subCatArrowImageView: UIImageView!
    
    var addSpendTableViewHeightConstraint: NSLayoutConstraint!
    var addSpendTableViewTopConstraint: NSLayoutConstraint!
    var tableViewContentHeight: CGFloat!
    var isExpanded = false
    var isCategory = false
    
    var categories = ["A", "B", "C"]
    var subCategories = ["D", "E", "F"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        self.perform(#selector(updateUIAfterDelay), with: nil, afterDelay: 0.0)
    }
    
    
    // MARK:- CORE FUNCTIONS
    func updateUI() {
        self.categoryArrowImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        self.subCatArrowImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        addSpendTableView.rowHeight = UITableView.automaticDimension
    }
    
    // used to handle table view height according to their content-size
    @objc func updateUIAfterDelay() {
        tableViewContentHeight = addSpendTableView.contentSize.height
    }
    
    
    // MARK:- UPDATE TABLE VIEW HEIGHT CONSTRAINTS
    func setTableViewHeight(isOpen: Bool) {
        let viewHeight = self.view.frame.height / 2
        
        if isOpen {
            UIView.animate(withDuration: 0.4) {
                self.addSpendTableViewHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        else {
            if tableViewContentHeight > viewHeight {
                UIView.animate(withDuration: 0.5) {
                    self.addSpendTableViewHeightConstraint.constant = viewHeight
                    self.view.layoutIfNeeded()
                }
            }
            else {
                UIView.animate(withDuration: 0.5) {
                    //self.addSpendTableViewHeightConstraint.constant = self.tableViewContentHeight
                    self.addSpendTableViewHeightConstraint.constant = 250
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    // MARK:- HIDE TABLE VIEW
    func hideTableView(selectedCategory: String, arrowImageView: UIImageView) {
        var indexPaths = [IndexPath]()
        for row in categories.indices {
            print(row)
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
        
        if isExpanded {
            //categoryTableView.deleteRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3, animations: {
                arrowImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
                self.setTableViewHeight(isOpen: true)
            }) { (status) in
            }
            isExpanded = false
        } else {
            //categoryTableView.insertRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3) {
                arrowImageView.transform = CGAffineTransform.identity
                self.setTableViewHeight(isOpen: false)
            }
            isExpanded = true
        }
    }
    
    func setupTableView(topView: UIView) {
        self.view.addSubview(addSpendTableView)
        addSpendTableView.translatesAutoresizingMaskIntoConstraints = false
        addSpendTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        addSpendTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addSpendTableViewHeightConstraint = addSpendTableView.heightAnchor.constraint(equalToConstant: 0)
        addSpendTableViewHeightConstraint.isActive = true
        addSpendTableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
    }
    
    func removeTableView() {
        addSpendTableView.removeFromSuperview()
    }
    
    @IBAction func categoryViewTapped(_ sender: UITapGestureRecognizer) {
        self.removeTableView()
        self.setupTableView(topView: categoryView)
        self.isCategory = true
        self.addSpendTableView.reloadData()
        self.hideTableView(selectedCategory: emptyString, arrowImageView: categoryArrowImageView)
    }
    
    @IBAction func subCategoryViewTapped(_ sender: UITapGestureRecognizer) {
        self.removeTableView()
        self.setupTableView(topView: subCategoryView)
        self.isCategory = false
        self.addSpendTableView.reloadData()
        self.hideTableView(selectedCategory: emptyString, arrowImageView: subCatArrowImageView)
    }
    
}

extension AddSpendVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCategory {
            return categories.count
        }
        else {
            return subCategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kCellId, for: indexPath)
        
        if isCategory {
            cell.textLabel?.text = categories[indexPath.row]
            
        } else {
            cell.textLabel?.text = subCategories[indexPath.row]
        }
        
        tableViewContentHeight = addSpendTableView.contentSize.height
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
