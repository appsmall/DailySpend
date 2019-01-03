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
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_back_white"), for: .normal)
        return button
    }()
    
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
        button.layer.cornerRadius = (3 * selectACategoryHeight * 0.25) / 2
        button.layer.masksToBounds = true
        return button
    }()
    var submitBtnTopConstraint: NSLayoutConstraint!
    var submitBtnHeightConstraint: NSLayoutConstraint!
    
    lazy var addNewSubCatView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 66, green: 54, blue: 48)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    var addNewSubCatViewHeightConstraint: NSLayoutConstraint!
    var addNewSubCatViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var arrowCategoryImageView: UIImageView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomHiddenViewSelectCat: UIView!
    @IBOutlet weak var categoryTableViewTopConstraint: NSLayoutConstraint!
    
    let categories = ["Grocery", "Petrol/Diesel", "Cloths", "Savings", "Emergency", "Food and Groceries", "Entertainment", "Add new category"]
    let subCategories = ["Add new sub-category"]
    var isExpanded = false
    var tableViewContentHeight: CGFloat!
    var selectACategoryHeight: CGFloat!
    var isCategory = true   // On first, table view always shows categories array
    var isSubmitBtnPressedOnSubCategory = false  // to check the submit button tap on which view (category or subcategory view)
    var backArrowBtnHeightConstraint: NSLayoutConstraint!  // update back button height when 'Enter new subcategory'
    var hiddenViewHeight: CGFloat!        // Calculate hiddenView width
    
    
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
        hiddenViewHeight = bottomHiddenViewSelectCat.frame.height
    }
    
    func alertWithSingleAction(message : String){
        let okAction = UIAlertAction(title: Alert.ok, style: .default, handler: nil)
        let actions = [okAction]
        Utility.alert(on: self, title: Alert.alert, message: message, withActions: actions, style: .alert)
    }
    
    // MARK:- UPDATE TABLE VIEW HEIGHT CONSTRAINTS
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
    
    // MARK:- HIDE TABLE VIEW
    func hideTableView(selectedCategory: String) {
        var indexPaths = [IndexPath]()
        for row in categories.indices {
            print(row)
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
        
        if isExpanded {
            //categoryTableView.deleteRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3, animations: {
                if self.isCategory {
                    // Category View
                    self.arrowCategoryImageView.transform = CGAffineTransform(rotationAngle: .pi / -2)
                } else {
                    // Sub-category View
                    self.arrowButton.transform = CGAffineTransform(rotationAngle: .pi / -2)
                }
                
                self.setTableViewHeight(isOpen: true)
            }) { (status) in
            }
            isExpanded = false
        } else {
            //categoryTableView.insertRows(at: indexPaths, with: .fade)
            
            UIView.animate(withDuration: 0.3) {
                if self.isCategory {
                    // Category View
                    self.arrowCategoryImageView.transform = CGAffineTransform.identity
                } else {
                    // Sub-category View
                    self.arrowButton.transform = CGAffineTransform.identity
                }
                
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
        self.view.bringSubviewToFront(categoryTableView)
        hideTableView(selectedCategory: "")
    }
}

// MARK:- TABLEVIEW DATASOURCE & DELEGATE METHODS
extension AddCategoryVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCategory {
            // Category View
            return categories.count
        } else {
            // Subcategory View
            return subCategories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kCellId, for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        if isCategory {
            // Category View
            cell.textLabel?.text = categories[indexPath.row]
        } else {
            // Subcategory View
            cell.textLabel?.text = subCategories[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCategory {
            // Category View
            let selectedCategory = categories[indexPath.row]
            self.hideTableView(selectedCategory: selectedCategory)
            
            if selectedCategory == "Add new category" {
                // Click on 'Add new category'
                setupAddNewCategoryViews()
                perform(#selector(startAnimation), with: ["isCat":isCategory, "isAddNewCat": true], afterDelay: 0.0)
            }
            else {
                // Click on any of the field except 'Add new category'
                self.chooseSubCategoryFromExistingCategory()
                perform(#selector(startAnimation), with: ["isCat":isCategory, "isAddNewCat": false], afterDelay: 0.0)
            }
            
            isCategory = false
            categoryView.isUserInteractionEnabled = false
            categoryLabel.text = selectedCategory
        }
        else {
            // Subcategory View
            let selectedCategory = subCategories[indexPath.row]
            //self.showHideSubCategoryTableView(selectedCategory: selectedCategory)
            self.hideTableView(selectedCategory: selectedCategory)
            
            if selectedCategory == "Add new sub-category" {
                // Click on 'Add new sub-category'
                chooseAddNewSubCatFromSubCategories()
                perform(#selector(startAnimation), with: ["isCat":isCategory, "isAddNewCat": true], afterDelay: 0.0)
            }
            else {
                // Click on any of the field except 'Add new sub-category'
                showSubmitButtonOnSelectionOnSubCategory(addCategoryView)
                perform(#selector(startAnimation), with: ["isCat":isCategory, "isAddNewCat": false], afterDelay: 0.0)
            }
            
            enterNewCatLabel.text = selectedCategory
            addCategoryView.isUserInteractionEnabled = false
        }
    }
}

// MARK:- SELECTOR FUNCTIONS
extension AddCategoryVC {
    // MARK:- SUBMIT BUTTON SHOWS (WHEN YOU TAP ON "ADD NEW CATEGORY")
    @objc func submitBtnPressed() {
        if isSubmitBtnPressedOnSubCategory {
            // When user tap on submit button on Sub-Category View, then
            // Category and SubCategory are successfully saved.
            
            let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
            Utility.alert(on: self, title: "Alert", message: "Category and SubCategory are successfully saved.", withActions: [actionOk], style: .alert)
        }
        else {
            // When user tap on submit button on Category View, then
            // Move to Sub-Category View
            UIView.transition(with: addCategoryView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                // Enter new Sub-Category
                self.backArrowBtnHeightConstraint.constant = 30
                self.enterNewCatLabel.text = "Enter new sub-category"
                self.addCategoryTextField.placeholder = "Enter new sub-category"
                self.isSubmitBtnPressedOnSubCategory = true
            }, completion: nil)
            
            self.isSubmitBtnPressedOnSubCategory = true
        }
    }
    
    // MARK:- BACK BUTTONS SHOWS (WHEN YOU TAP ON "ADD NEW CATEGORY")
    @objc func backToAddCategoryBtnPressed() {
        // Back to Category View from Sub-Category View
        UIView.transition(with: addCategoryView, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.backArrowBtnHeightConstraint.constant = 0
            self.enterNewCatLabel.text = "Enter new category"
            self.addCategoryTextField.placeholder = "Enter new category"
            self.isSubmitBtnPressedOnSubCategory = false
        }, completion: nil)
    }
    
    // MARK:- START ANIMATION WITH VIEWS
    @objc func startAnimation(userInfo: Any) {
        if let userInfo = userInfo as? [String:Any] {
            if let isCat = userInfo["isCat"] as? Bool, let isAddNewCat = userInfo["isAddNewCat"] as? Bool {
                if isCat {
                    if isAddNewCat {
                        showAddNewCategoryViewWithAnimation()
                    }
                    else {
                        self.showSubCategoryViewWithAnimation()
                    }
                }
                else {
                    if isAddNewCat {
                        openTextFieldToAddSubCategoryWithAnimation()
                    }
                    else {
                        showSubmitButtonWithAnimation()
                    }
                }
            }
        }
    }
    
    // MARK:- TAP ON SUBCATEGORY VIEW (SHOWS WHEN YOU TAP ANY OF THE CATEGORY EXCEPT "ADD NEW CATEGORY")
    @objc func subcategoryViewTapped() {
        self.categoryTableView.reloadData()
        tableViewContentHeight = categoryTableView.contentSize.height
        //showHideSubCategoryTableView(selectedCategory: "")
        hideTableView(selectedCategory: "")
    }
}

// MARK:- CREATE VIEWS AND SETUP CONSTRAINTS
extension AddCategoryVC {
    
    // MARK:- SETUP VIEWS WHEN YOU TAPPED "ADD NEW CATEGORY"
    func setupAddNewCategoryViews() {
        self.view.addSubview(addCategoryView)
        addCategoryView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        addCategoryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addCategoryViewTopConstraint = addCategoryView.topAnchor.constraint(equalTo: self.bottomHiddenViewSelectCat.topAnchor)
        addCategoryViewTopConstraint.isActive = true
        addCategoryViewHeightConstraint = addCategoryView.heightAnchor.constraint(equalToConstant: 0)
        addCategoryViewHeightConstraint.isActive = true
        
        addCategoryView.addSubview(arrowButton)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.leadingAnchor.constraint(equalTo: addCategoryView.leadingAnchor, constant: 10).isActive = true
        backArrowBtnHeightConstraint = arrowButton.heightAnchor.constraint(equalToConstant: 0)
        backArrowBtnHeightConstraint.isActive = true
        arrowButton.widthAnchor.constraint(equalTo: arrowButton.heightAnchor).isActive = true
        arrowButton.topAnchor.constraint(equalTo: addCategoryView.topAnchor, constant: 10).isActive = true
        arrowButton.addTarget(self, action: #selector(backToAddCategoryBtnPressed), for: .touchUpInside)
        
        addCategoryView.addSubview(enterNewCatLabel)
        enterNewCatLabel.translatesAutoresizingMaskIntoConstraints = false
        enterNewCatLabel.leadingAnchor.constraint(equalTo: arrowButton.trailingAnchor, constant: 0).isActive = true
        enterNewCatLabel.trailingAnchor.constraint(equalTo: addCategoryView.trailingAnchor, constant: -10).isActive = true
        enterNewCatLabel.topAnchor.constraint(equalTo: addCategoryView.topAnchor, constant: 10).isActive = true
        enterNewCatLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addCategoryView.addSubview(addCategoryTFView)
        addCategoryTFView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryTFView.leadingAnchor.constraint(equalTo: addCategoryView.leadingAnchor, constant: 10).isActive = true
        addCategoryTFView.trailingAnchor.constraint(equalTo: addCategoryView.trailingAnchor, constant: -10).isActive = true
        addCategoryTFView.topAnchor.constraint(equalTo: enterNewCatLabel.bottomAnchor, constant: 10).isActive = true
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
        submitButtonForCategory.addTarget(self, action: #selector(submitBtnPressed), for: .touchUpInside)
    }
    
    // MARK:- SETUP VIEWS WHEN YOU TAP ANY OF THE CATEGORY EXCEPT "ADD NEW CATEGORY"
    func setupCommonSubCategoryViews() {
        self.view.addSubview(addCategoryView)
        addCategoryView.translatesAutoresizingMaskIntoConstraints = false
        addCategoryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        addCategoryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addCategoryViewTopConstraint = addCategoryView.topAnchor.constraint(equalTo: self.bottomHiddenViewSelectCat.topAnchor)
        addCategoryViewTopConstraint.isActive = true
        addCategoryViewHeightConstraint = addCategoryView.heightAnchor.constraint(equalToConstant: 0)
        addCategoryViewHeightConstraint.isActive = true
        
        addCategoryView.addSubview(arrowButton)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.trailingAnchor.constraint(equalTo: addCategoryView.trailingAnchor, constant: -16).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowButton.widthAnchor.constraint(equalToConstant: 25.5).isActive = true
        arrowButton.centerYAnchor.constraint(equalTo: addCategoryView.centerYAnchor).isActive = true
        
        addCategoryView.addSubview(enterNewCatLabel)
        enterNewCatLabel.translatesAutoresizingMaskIntoConstraints = false
        enterNewCatLabel.centerYAnchor.constraint(equalTo: addCategoryView.centerYAnchor).isActive = true
        enterNewCatLabel.leadingAnchor.constraint(equalTo: addCategoryView.leadingAnchor, constant: 16).isActive = true
        enterNewCatLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -5).isActive = true
        
        self.view.removeConstraint(categoryTableViewTopConstraint)
        categoryTableView.topAnchor.constraint(equalTo: addCategoryView.bottomAnchor).isActive = true
    }
    
    func chooseSubCategoryFromExistingCategory() {
        self.setupCommonSubCategoryViews()
        
        enterNewCatLabel.text = "Select a sub-category"
        arrowButton.setImage(UIImage(named: "ic_arrow_down"), for: .normal)
        arrowButton.transform = CGAffineTransform(rotationAngle: .pi / -2)
        arrowButton.isUserInteractionEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(subcategoryViewTapped))
        addCategoryView.addGestureRecognizer(tapGesture)
    }
    
    // MARK:- SETUP SUBMIT BUTTON WHEN YOU TAP ON ANY SUB-CATEGORY EXCEPT "ADD NEW SUB-CATEGORY"
    func showSubmitButtonOnSelectionOnSubCategory(_ topBindView: UIView) {
        self.view.addSubview(self.submitButtonForCategory)
        self.submitButtonForCategory.translatesAutoresizingMaskIntoConstraints = false
        submitBtnTopConstraint = self.submitButtonForCategory.topAnchor.constraint(equalTo: topBindView.topAnchor)
        submitBtnTopConstraint.isActive = true
        submitBtnHeightConstraint = self.submitButtonForCategory.heightAnchor.constraint(equalTo: self.addCategoryView.heightAnchor, multiplier: 0)
        submitBtnHeightConstraint.isActive = true
        self.submitButtonForCategory.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.submitButtonForCategory.widthAnchor.constraint(equalTo: self.addCategoryView.widthAnchor, multiplier: 0.6).isActive = true
        
        submitButtonForCategory.backgroundColor = UIColor.rgb(red: 56, green: 57, blue: 43)
    }
    
    // MARK:- SETUP TEXT FIELD VIEW WHEN YOU TAP ON "ADD NEW SUB-CATEGORY"
    func chooseAddNewSubCatFromSubCategories() {
        self.view.addSubview(addNewSubCatView)
        addNewSubCatView.translatesAutoresizingMaskIntoConstraints = false
        addNewSubCatView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        addNewSubCatView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        addNewSubCatViewTopConstraint = addNewSubCatView.topAnchor.constraint(equalTo: addCategoryView.topAnchor, constant: 0)
        addNewSubCatViewTopConstraint.isActive = true
        addNewSubCatViewHeightConstraint = addNewSubCatView.heightAnchor.constraint(equalToConstant: 0)
        addNewSubCatViewHeightConstraint.isActive = true
        
        addNewSubCatView.addSubview(addCategoryTextField)
        addCategoryTextField.translatesAutoresizingMaskIntoConstraints = false
        addCategoryTextField.leadingAnchor.constraint(equalTo: addNewSubCatView.leadingAnchor, constant: 10).isActive = true
        addCategoryTextField.trailingAnchor.constraint(equalTo: addNewSubCatView.trailingAnchor, constant: -10).isActive = true
        addCategoryTextField.topAnchor.constraint(equalTo: addNewSubCatView.topAnchor, constant: 2).isActive = true
        addCategoryTextField.bottomAnchor.constraint(equalTo: addNewSubCatView.bottomAnchor, constant: 2).isActive = true
        
        showSubmitButtonOnSelectionOnSubCategory(addNewSubCatView)
        
        addCategoryTextField.attributedPlaceholder = NSAttributedString(string: "Enter new sub-category", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        addCategoryTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    }
}

// MARK:- ANIMATIONS
extension AddCategoryVC {
    // MARK:- ANIMATION WHEN YOU ADD NEW CATEGORY
    func openTextFieldToAddSubCategoryWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.addNewSubCatViewTopConstraint.constant = self.selectACategoryHeight + self.hiddenViewHeight
            self.addNewSubCatViewHeightConstraint.constant = self.selectACategoryHeight
            self.addNewSubCatView.layer.cornerRadius = self.selectACategoryHeight / 2
            self.addNewSubCatView.layer.masksToBounds = true
            self.view.layoutIfNeeded()
        }, completion: { (completed) in
            
            UIView.animate(withDuration: 0.3, animations: {
                self.submitButtonAnimation()
                self.view.layoutIfNeeded()
            })
        })
    }
    
    // MARK:- ANIMATION WHEN YOU TAP ON ANY CATEGORY EXCEPT "ADD NEW CATEGORY"
    func showSubCategoryViewWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.addCategoryViewTopConstraint.isActive = false
            self.addCategoryView.topAnchor.constraint(equalTo: self.bottomHiddenViewSelectCat.bottomAnchor).isActive = true
            self.addCategoryViewHeightConstraint.constant = self.selectACategoryHeight
            self.addCategoryView.layer.cornerRadius = self.selectACategoryHeight / 2
            self.addCategoryView.layer.masksToBounds = true
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK:- ANIMATION WHEN YOU TAP ON "ADD NEW CATEGORY"
    func showAddNewCategoryViewWithAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.addCategoryViewTopConstraint.isActive = false
            self.addCategoryView.topAnchor.constraint(equalTo: self.bottomHiddenViewSelectCat.bottomAnchor).isActive = true
            self.addCategoryViewHeightConstraint.constant = 3 * self.selectACategoryHeight
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK:- ANIMATION WHEN YOU TAP ON ANY SUB-CATEGORY EXCEPT "ADD NEW SUB-CATEGORY"
    func showSubmitButtonWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.submitButtonAnimation()
            self.view.layoutIfNeeded()
        })
    }
    
    func submitButtonAnimation() {
        self.submitBtnHeightConstraint.constant = self.selectACategoryHeight
        self.submitBtnTopConstraint.constant = self.addCategoryView.frame.height + self.hiddenViewHeight
        self.submitButtonForCategory.layer.cornerRadius = self.selectACategoryHeight / 2
        self.submitButtonForCategory.layer.masksToBounds = true
    }
}
