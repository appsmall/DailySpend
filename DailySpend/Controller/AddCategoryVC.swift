//
//  AddCategoryVC.swift
//  DailySpend
//
//  Created by apple on 01/01/19.
//  Copyright © 2019 outect. All rights reserved.
//

import UIKit

class AddCategoryVC: UIViewController {
    struct Storyboard {
        static let kCellId = "AddCategoryCell"
    }
    
    lazy var addCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 66, green: 54, blue: 48)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    var addCategoryViewTopConstraint: NSLayoutConstraint!
    var addCategoryViewHeightConstraint: NSLayoutConstraint!
    
    lazy var enterNewCatLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter new category"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var addCategoryTFView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.25)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var addCategoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter new category"
        textField.textColor = UIColor.white
        return textField
    }()
    
    lazy var submitButtonForCategory: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 150, green: 123, blue: 106)
        button.addTarget(self, action: #selector(submitBtnPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var addSubCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 66, green: 54, blue: 48)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var enterNewSubCatLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter new sub-category"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var addSubCategoryTFView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.25)
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var addSubCategoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter new sub-category"
        textField.textColor = UIColor.white
        return textField
    }()
    
    lazy var submitButtonForSubCategory: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 150, green: 123, blue: 106)
        button.addTarget(self, action: #selector(submitBtnPressed), for: .touchUpInside)
        return button
    }()
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var arrowCategoryImageView: UIImageView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomHiddenViewSelectCat: UIView!
    
    let categories = ["Grocery", "Petrol/Diesel", "Cloths", "Savings", "Emergency", "Food and Groceries", "Entertainment", "Add new category"]
    var isExpanded = false
    var tableViewContentHeight: CGFloat!
    var selectACategoryHeight: CGFloat!
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        self.perform(#selector(updateUIAfterDelay), with: nil, afterDelay: 0.0)
    }
    
    deinit {
        print("AddCategoryVC is destroyed")
    }
    
    // MARK:- CORE FUNCTIONS
    func updateUI() {
        categoryView.cornerView()
        
        self.arrowCategoryImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        categoryTableView.layer.cornerRadius = 5
        categoryTableView.layer.masksToBounds = true
    }
    
    // used to handle table view height according to their content-size
    @objc func updateUIAfterDelay() {
        tableViewContentHeight = categoryTableView.contentSize.height
        selectACategoryHeight = categoryView.frame.size.height
    }
    
    func setTableViewHeight(isOpen: Bool) {
        let viewHeight = self.view.frame.height / 2
        
        if isOpen {
            UIView.animate(withDuration: 0.4) {
                self.categoryTableViewHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        else {
            if tableViewContentHeight > viewHeight {
                UIView.animate(withDuration: 0.5) {
                    self.categoryTableViewHeightConstraint.constant = viewHeight
                    self.view.layoutIfNeeded()
                }
            }
            else {
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                    self.categoryTableViewHeightConstraint.constant = self.tableViewContentHeight
                }
            }
        }
    }
    
    func hideTableView() {
        var indexPaths = [IndexPath]()
        for row in categories.indices {
            print(row)
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
        
        if isExpanded {
            //categoryTableView.deleteRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.arrowCategoryImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
                self.setTableViewHeight(isOpen: true)
            }) { (status) in
                UIView.animate(withDuration: 0.3, animations: {
                    if let selectedText = self.categoryLabel.text {
                        if selectedText == "Add new category" {
                            self.addCategoryViewTopConstraint.isActive = false
                            self.addCategoryView.topAnchor.constraint(equalTo: self.bottomHiddenViewSelectCat.bottomAnchor).isActive = true
                            self.addCategoryViewHeightConstraint.constant = 3 * self.selectACategoryHeight
                            self.view.layoutIfNeeded()
                        }
                    }
                })
            }
            isExpanded = false
        } else {
            //categoryTableView.insertRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3) {
                self.arrowCategoryImageView.transform = CGAffineTransform.identity
                self.categoryTableViewHeightConstraint.constant = 250
                self.setTableViewHeight(isOpen: false)
            }
            isExpanded = true
        }
    }
    
    // MARK:- IBACTIONS
    @IBAction func backBtnPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func categoryViewTapped(_ sender: UITapGestureRecognizer) {
        hideTableView()
    }
}

// MARK:- TABLEVIEW DATASOURCE & DELEGATE METHODS
extension AddCategoryVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kCellId, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        if selectedCategory == "Add new category" {
            // Click on 'Add new category'
            setupAddNewCategoryViews()
        }
        else {
            // Click on any of the field except 'Add new category'
        }
        
        categoryLabel.text = selectedCategory
        self.hideTableView()
    }
}

extension AddCategoryVC {
    func setupAddNewCategoryViews() {
        self.view.addSubview(addCategoryView)
        addCategoryView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        addCategoryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addCategoryViewTopConstraint = addCategoryView.topAnchor.constraint(equalTo: self.bottomHiddenViewSelectCat.topAnchor)
        addCategoryViewTopConstraint.isActive = true
        addCategoryViewHeightConstraint = addCategoryView.heightAnchor.constraint(equalToConstant: 0)
        addCategoryViewHeightConstraint.isActive = true
        
        addCategoryView.addSubview(enterNewCatLabel)
        enterNewCatLabel.translatesAutoresizingMaskIntoConstraints = false
        enterNewCatLabel.leadingAnchor.constraint(equalTo: addCategoryView.leadingAnchor, constant: 10).isActive = true
        enterNewCatLabel.trailingAnchor.constraint(equalTo: addCategoryView.trailingAnchor, constant: -10).isActive = true
        enterNewCatLabel.topAnchor.constraint(equalTo: addCategoryView.topAnchor, constant: 10).isActive = true
        
        addCategoryView.addSubview(addCategoryTFView)
        addCategoryTFView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryTFView.leadingAnchor.constraint(equalTo: addCategoryView.leadingAnchor, constant: 10).isActive = true
        addCategoryTFView.trailingAnchor.constraint(equalTo: addCategoryView.trailingAnchor, constant: -10).isActive = true
        addCategoryTFView.topAnchor.constraint(equalTo: enterNewCatLabel.bottomAnchor, constant: 16).isActive = true
        addCategoryTFView.heightAnchor.constraint(equalTo: addCategoryView.heightAnchor, multiplier: 0.3).isActive = true
        
        addCategoryTFView.addSubview(addCategoryTextField)
        addCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        addCategoryTextField.leadingAnchor.constraint(equalTo: addCategoryTFView.leadingAnchor, constant: 8).isActive = true
        addCategoryTextField.trailingAnchor.constraint(equalTo: addCategoryTFView.trailingAnchor, constant: -8).isActive = true
        addCategoryTextField.topAnchor.constraint(equalTo: addCategoryTFView.topAnchor, constant: 2).isActive = true
        addCategoryTextField.bottomAnchor.constraint(equalTo: addCategoryTFView.bottomAnchor, constant: 2).isActive = true
        
        addCategoryView.addSubview(submitButtonForCategory)
        submitButtonForCategory.translatesAutoresizingMaskIntoConstraints = false
        submitButtonForCategory.centerXAnchor.constraint(equalTo: addCategoryView.centerXAnchor).isActive = true
        submitButtonForCategory.widthAnchor.constraint(equalTo: addCategoryView.widthAnchor, multiplier: 0.5).isActive = true
        submitButtonForCategory.bottomAnchor.constraint(equalTo: addCategoryView.bottomAnchor, constant: -10).isActive = true
        submitButtonForCategory.heightAnchor.constraint(equalTo: addCategoryView.heightAnchor, multiplier: 0.25).isActive = true
        submitButtonForCategory.cornerView()
    }
    
    func setupAddNewSubCategoryViews() {
        self.view.addSubview(addSubCategoryView)
        addSubCategoryView.translatesAutoresizingMaskIntoConstraints = false
        addSubCategoryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        addSubCategoryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addSubCategoryView.topAnchor.constraint(equalTo: self.bottomHiddenViewSelectCat.topAnchor).isActive = true
        addSubCategoryView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        
        addSubCategoryView.addSubview(enterNewSubCatLabel)
        enterNewSubCatLabel.translatesAutoresizingMaskIntoConstraints = false
        enterNewSubCatLabel.leadingAnchor.constraint(equalTo: addSubCategoryView.leadingAnchor, constant: 10).isActive = true
        enterNewSubCatLabel.trailingAnchor.constraint(equalTo: addSubCategoryView.trailingAnchor, constant: -10).isActive = true
        enterNewSubCatLabel.topAnchor.constraint(equalTo: addSubCategoryView.topAnchor, constant: 10).isActive = true
        
        addSubCategoryView.addSubview(addSubCategoryTFView)
        addSubCategoryTFView.translatesAutoresizingMaskIntoConstraints = false
        addSubCategoryTFView.leadingAnchor.constraint(equalTo: addSubCategoryTFView.leadingAnchor, constant: 10).isActive = true
        addSubCategoryTFView.trailingAnchor.constraint(equalTo: addSubCategoryView.trailingAnchor, constant: -10).isActive = true
        addSubCategoryTFView.topAnchor.constraint(equalTo: enterNewSubCatLabel.bottomAnchor, constant: 16).isActive = true
        addSubCategoryTFView.heightAnchor.constraint(equalTo: addSubCategoryView.heightAnchor, multiplier: 0.3).isActive = true
        
        addSubCategoryView.addSubview(addSubCategoryTextField)
        addSubCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubCategoryTextField.leadingAnchor.constraint(equalTo: addSubCategoryTFView.leadingAnchor, constant: 8).isActive = true
        addSubCategoryTextField.trailingAnchor.constraint(equalTo: addSubCategoryTFView.trailingAnchor, constant: -8).isActive = true
        addSubCategoryTextField.topAnchor.constraint(equalTo: addSubCategoryTFView.topAnchor, constant: 2).isActive = true
        addSubCategoryTextField.bottomAnchor.constraint(equalTo: addSubCategoryTFView.bottomAnchor, constant: 2).isActive = true
        
        addSubCategoryView.addSubview(submitButtonForSubCategory)
        submitButtonForSubCategory.translatesAutoresizingMaskIntoConstraints = false
        submitButtonForSubCategory.centerXAnchor.constraint(equalTo: addSubCategoryView.centerXAnchor).isActive = true
        submitButtonForSubCategory.widthAnchor.constraint(equalTo: addSubCategoryView.widthAnchor, multiplier: 0.5).isActive = true
        submitButtonForSubCategory.bottomAnchor.constraint(equalTo: addSubCategoryView.bottomAnchor, constant: -10).isActive = true
        submitButtonForSubCategory.heightAnchor.constraint(equalTo: addSubCategoryView.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    func removeAddNewCategoryViews() {
        addCategoryView.removeFromSuperview()
    }
    
    @objc func submitBtnPressed() {
        print("Submit Button Pressed")
        
        
        UIView.transition(with: addSubCategoryView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.setupAddNewSubCategoryViews()
        }, completion: nil)
    }
}
