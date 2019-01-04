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
        static let kCategoryCellId = "CatCell"
        static let kSubCategoryCellId = "SubCatCell"
    }
    
    /*lazy var addSpendTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Storyboard.kCellId)
        return tableView
    }()*/
    
    
    @IBOutlet weak var categoryView: RoundCornerView!
    @IBOutlet weak var categoryArrowImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var subCategoryView: RoundCornerView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var subCatArrowImageView: UIImageView!
    @IBOutlet weak var subCatTableView: UITableView!
    @IBOutlet weak var subCatTableViewHeightConstraint: NSLayoutConstraint!
    
    //var addSpendTableViewHeightConstraint: NSLayoutConstraint!
    //var addSpendTableViewTopConstraint: NSLayoutConstraint!
    var catTableViewContentHeight: CGFloat!
    var subCatTableViewContentHeight: CGFloat!
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
        self.view.bringSubviewToFront(categoryTableView)
        self.view.bringSubviewToFront(subCatTableView)
        categoryTableView.rowHeight = UITableView.automaticDimension
        subCatTableView.rowHeight = UITableView.automaticDimension
    }
    
    // used to handle table view height according to their content-size
    @objc func updateUIAfterDelay() {
        catTableViewContentHeight = categoryTableView.contentSize.height
        subCatTableViewContentHeight = subCatTableView.contentSize.height
    }
    
    
    // MARK:- UPDATE TABLE VIEW HEIGHT CONSTRAINTS
    func setTableViewHeight(isOpen: Bool) {
        let viewHeight = self.view.frame.height / 2
        
        if isOpen {
            UIView.animate(withDuration: 0.4) {
                if self.isCategory {
                    self.categoryTableViewHeightConstraint.constant = 0
                } else {
                    self.subCatTableViewHeightConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            }
        }
        else {
            if isCategory {
                if catTableViewContentHeight > viewHeight {
                    UIView.animate(withDuration: 0.5) {
                        self.categoryTableViewHeightConstraint.constant = viewHeight
                        self.view.layoutIfNeeded()
                    }
                }
                else {
                    UIView.animate(withDuration: 0.5) {
                        //self.addSpendTableViewHeightConstraint.constant = self.tableViewContentHeight
                        self.categoryTableViewHeightConstraint.constant = 250
                        self.view.layoutIfNeeded()
                    }
                }
            }
            else {
                if subCatTableViewContentHeight > viewHeight {
                    UIView.animate(withDuration: 0.5) {
                        self.subCatTableViewHeightConstraint.constant = viewHeight
                        self.view.layoutIfNeeded()
                    }
                }
                else {
                    UIView.animate(withDuration: 0.5) {
                        //self.addSpendTableViewHeightConstraint.constant = self.tableViewContentHeight
                        self.subCatTableViewHeightConstraint.constant = 250
                        self.view.layoutIfNeeded()
                    }
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
    
    /*func setupTableView(topView: UIView) {
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
    }*/
    
    @IBAction func categoryViewTapped(_ sender: UITapGestureRecognizer) {
        self.isCategory = true
        self.categoryTableView.reloadData()
        self.hideTableView(selectedCategory: emptyString, arrowImageView: categoryArrowImageView)
        
        /*self.removeTableView()
        self.setupTableView(topView: categoryView)*/
    }
    
    @IBAction func subCategoryViewTapped(_ sender: UITapGestureRecognizer) {
        self.isCategory = false
        self.subCatTableView.reloadData()
        self.hideTableView(selectedCategory: emptyString, arrowImageView: subCatArrowImageView)
        /*self.removeTableView()
        self.setupTableView(topView: subCategoryView)*/
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
        
        if isCategory {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kCategoryCellId, for: indexPath)
            cell.textLabel?.text = categories[indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kSubCategoryCellId, for: indexPath)
            cell.textLabel?.text = subCategories[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCategory {
            let selectedCategory = categories[indexPath.row]
            categoryLabel.text = selectedCategory
            self.hideTableView(selectedCategory: selectedCategory, arrowImageView: categoryArrowImageView)
        }
        else {
            let selectedSubCategory = subCategories[indexPath.row]
            subCategoryLabel.text = selectedSubCategory
            self.hideTableView(selectedCategory: selectedSubCategory, arrowImageView: subCatArrowImageView)
        }
    }
}
