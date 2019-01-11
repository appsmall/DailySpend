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
    
    @IBOutlet weak var dateView: RoundCornerView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateArrowImageView: UIImageView!
    @IBOutlet weak var amountTextField: UITextField!
    
    lazy var datePickerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 150, green: 123, blue: 106)
        return view
    }()
    
    lazy var headingDatePickerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 66, green: 54, blue: 48)
        return view
    }()
    var datePicker = UIDatePicker()
    var datePickerViewXConstraint: NSLayoutConstraint!
    var overlayView: UIView!
    weak var containerVC: ContainerVC?
    
    
    
    //var addSpendTableViewHeightConstraint: NSLayoutConstraint!
    //var addSpendTableViewTopConstraint: NSLayoutConstraint!
    var catTableViewContentHeight: CGFloat!
    var subCatTableViewContentHeight: CGFloat!
    var isExpanded = false
    var isCategory = false
    var isTapOnView = false
    var isDateViewExpanded = false
    
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
        
        categoryTableView.layer.cornerRadius = 5
        categoryTableView.layer.masksToBounds = true
        subCatTableView.layer.cornerRadius = 5
        subCatTableView.layer.masksToBounds = true
        categoryTableView.rowHeight = UITableView.automaticDimension
        subCatTableView.rowHeight = UITableView.automaticDimension
        
        self.setupOverlayView()
        self.setupDatePickerView()
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
                        self.categoryTableViewHeightConstraint.constant = self.catTableViewContentHeight
                        //self.categoryTableViewHeightConstraint.constant = 250
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
                        self.subCatTableViewHeightConstraint.constant = self.subCatTableViewContentHeight
                        //self.subCatTableViewHeightConstraint.constant = 250
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
        if isTapOnView {
            isTapOnView = false
            self.categoryView.isUserInteractionEnabled = true
            self.subCategoryView.isUserInteractionEnabled = true
        } else {
            isTapOnView = true
            
            self.isCategory = true
            self.categoryView.isUserInteractionEnabled = true
            self.subCategoryView.isUserInteractionEnabled = false
            self.categoryTableView.reloadData()
        }
        self.hideTableView(selectedCategory: emptyString, arrowImageView: categoryArrowImageView)
        
        /*self.removeTableView()
        self.setupTableView(topView: categoryView)*/
    }
    
    @IBAction func subCategoryViewTapped(_ sender: UITapGestureRecognizer) {
        if isTapOnView {
            isTapOnView = false
            self.categoryView.isUserInteractionEnabled = true
            self.subCategoryView.isUserInteractionEnabled = true
        }
        else {
            isTapOnView = true
            
            self.isCategory = false
            self.categoryView.isUserInteractionEnabled = false
            self.subCategoryView.isUserInteractionEnabled = true
            self.subCatTableView.reloadData()
        }
        self.hideTableView(selectedCategory: emptyString, arrowImageView: subCatArrowImageView)
        
        /*self.removeTableView()
        self.setupTableView(topView: subCategoryView)*/
    }
    
    @IBAction func dateViewTapped(_ sender: UITapGestureRecognizer) {
        self.setupAnimationOnDateView()
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
        
        isTapOnView = false
        self.categoryView.isUserInteractionEnabled = true
        self.subCategoryView.isUserInteractionEnabled = true
    }
}


// MARK:- DATE VIEW
// SETUP BLACK OVERLAY VIEW
// SETUP DATE VIEW & CONSTRAINTS
// ANIMATION ON PRESENTING DATE VIEW
// SELECTOR METHOD : DONE BUTTON ON DATE VIEW
extension AddSpendVC {
    func setupDatePickerView() {
        guard let containerVC = containerVC else{
            return
        }
        
        containerVC.view.addSubview(datePickerView)
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerViewXConstraint = datePickerView.centerXAnchor.constraint(equalTo: containerVC.view.centerXAnchor, constant: -self.view.frame.width)
        datePickerViewXConstraint.isActive = true
        datePickerView.centerYAnchor.constraint(equalTo: containerVC.view.centerYAnchor).isActive = true
        datePickerView.widthAnchor.constraint(equalTo: containerVC.view.widthAnchor, multiplier: 0.8).isActive = true
        datePickerView.heightAnchor.constraint(equalTo: containerVC.view.heightAnchor, multiplier: 0.4).isActive = true
        datePickerView.layer.cornerRadius = 8
        datePickerView.layer.masksToBounds = true
        
        datePickerView.addSubview(headingDatePickerView)
        headingDatePickerView.translatesAutoresizingMaskIntoConstraints = false
        headingDatePickerView.leadingAnchor.constraint(equalTo: datePickerView.leadingAnchor).isActive = true
        headingDatePickerView.trailingAnchor.constraint(equalTo: datePickerView.trailingAnchor).isActive = true
        headingDatePickerView.topAnchor.constraint(equalTo: datePickerView.topAnchor).isActive = true
        headingDatePickerView.heightAnchor.constraint(equalTo: datePickerView.heightAnchor, multiplier: 0.22).isActive = true
        
        datePicker.datePickerMode = .date
        datePickerView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: datePickerView.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: datePickerView.trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: headingDatePickerView.bottomAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: datePickerView.bottomAnchor).isActive = true
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        headingDatePickerView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leadingAnchor.constraint(equalTo: headingDatePickerView.leadingAnchor, constant: 8).isActive = true
        cancelButton.topAnchor.constraint(equalTo: headingDatePickerView.topAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: headingDatePickerView.bottomAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        headingDatePickerView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.trailingAnchor.constraint(equalTo: headingDatePickerView.trailingAnchor, constant: -8).isActive = true
        doneButton.topAnchor.constraint(equalTo: headingDatePickerView.topAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: headingDatePickerView.bottomAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.addTarget(self, action: #selector(doneBtnPressed), for: .touchUpInside)
        
        let selectedDateLabel = UILabel()
        selectedDateLabel.text = "Please select date"
        selectedDateLabel.textColor = UIColor.white
        selectedDateLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        selectedDateLabel.textAlignment = .center
        self.headingDatePickerView.addSubview(selectedDateLabel)
        selectedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedDateLabel.topAnchor.constraint(equalTo: headingDatePickerView.topAnchor).isActive = true
        selectedDateLabel.bottomAnchor.constraint(equalTo: headingDatePickerView.bottomAnchor).isActive = true
        selectedDateLabel.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 8).isActive = true
        selectedDateLabel.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -8).isActive = true
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.lightGray
        datePickerView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupOverlayView() {
        overlayView = UIView()
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0
        self.view.addSubview(overlayView)
        overlayView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func setupAnimationOnDateView() {
        guard let containerVC = containerVC else{
            return
        }
        
        if isDateViewExpanded {
            UIView.animate(withDuration: 0.3, animations: {
                self.datePickerViewXConstraint.constant = -self.view.frame.width
                containerVC.view.layoutIfNeeded()
            }) { (completed) in
                UIView.animate(withDuration: 0.3) {
                    self.overlayView.alpha = 0
                    containerVC.view.layoutIfNeeded()
                }
            }
            
            isDateViewExpanded = false
        }
        else {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.overlayView.alpha = 0.8
                containerVC.view.layoutIfNeeded()
            }) { (completed) in
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 6, options: .curveEaseInOut, animations: {
                    self.datePickerViewXConstraint.constant = 0
                    containerVC.view.layoutIfNeeded()
                }, completion: nil)
            }
            
            isDateViewExpanded = true
        }
    }
    
    @objc func doneBtnPressed() {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let dateString = dateFormatter.string(from: selectedDate)
        
        self.dateLabel.text = dateString
        
        setupAnimationOnDateView()
    }
    
    @objc func cancelBtnPressed() {
        setupAnimationOnDateView()
    }
}


extension AddSpendVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == amountTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
