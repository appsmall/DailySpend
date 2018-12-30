//
//  CategoryVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryView: RoundCornerView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.lightGray
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    var pickerViewBottomConstraint: NSLayoutConstraint!
    let categoryArray = ["Household", "Petrol/Diesel", "Funds"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupPickerViewConstraints()
    }
    
    func setupPickerViewConstraints() {
        self.view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        pickerViewBottomConstraint = pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 200)
        pickerViewBottomConstraint.isActive = true
    }
    
    
    @IBAction func categoryViewTapped(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneWithPickerView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func doneWithPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerViewBottomConstraint.constant = 200
            self.view.layoutIfNeeded()
        })
    }

}

extension CategoryVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryLabel.text = categoryArray[row]
    }
}
