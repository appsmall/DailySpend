//
//  CategoryVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

// Structure used for the categories model array
struct ExpandableNames {
    var isExpanded: Bool
    let category : String
    let subCategory: [String]
}

class CategoryVC: UIViewController {
    struct Storyboard {
        static let kCellId = "CategoryCell"
        static let categoryVCToAddCategoryVC = "categoryVCToAddCategoryVC"
    }
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories = [
        ExpandableNames(isExpanded: true, category: "Grocery", subCategory: ["Misc", "Others"]),
        ExpandableNames(isExpanded: false, category: "Petrol/Diesel", subCategory: ["Bike", "Scooty", "Car", "Bus", "Truck"]),
        ExpandableNames(isExpanded: true, category: "Cloths", subCategory: ["Suit", "Blazzer", "Western Dress", "Jeans"])
    ]
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK:- IBACTIONS
    @IBAction func addCategoryBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Storyboard.categoryVCToAddCategoryVC, sender: nil)
    }
}


// MARK:- TABLEVIEW DATASOURCE & DELEGATE METHODS
extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = categories[section].category
        let isExpand = categories[section].isExpanded
        
        let headerView = MyView()
        headerView.backgroundColor = UIColor.rgb(red: 66, green: 54, blue: 48)
        setupHeaderView(headerView: headerView, category: category, isExpand: isExpand, section: section)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCollapseExpand(gesture:)))
        headerView.addGestureRecognizer(tapGesture)
        
        return headerView
    }
    
    // MARK:- CREATE HEADER VIEW WITH INNER ELEMENTS
    func setupHeaderView(headerView: MyView, category: String, isExpand: Bool, section: Int) {
        let label = UILabel()
        label.text = category
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        let downImageView = UIImageView()
        downImageView.image = UIImage(named: "ic_arrow_down")
        downImageView.contentMode = .scaleToFill
        
        headerView.addSubview(label)
        headerView.addSubview(downImageView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: downImageView.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        downImageView.translatesAutoresizingMaskIntoConstraints = false
        downImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10).isActive = true
        downImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        downImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        downImageView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        
        headerView.tag = section
        headerView.imageView = downImageView
        
        if !isExpand {
            downImageView.transform = CGAffineTransform(rotationAngle: (.pi / -2))
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !categories[section].isExpanded {
            return 0
        }
        return categories[section].subCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kCellId, for: indexPath)
        let name = categories[indexPath.section].subCategory[indexPath.row]
        cell.textLabel?.text = name
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell
    }
    
    // MARK:- HANDLE EXPAND & COLLAPSE OF TABLE VIEW SECTIONS
    @objc func handleCollapseExpand(gesture: UITapGestureRecognizer) {
        guard let view = gesture.view as? MyView else{
            return
        }
        let section = view.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in categories[section].subCategory.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = categories[section].isExpanded
        categories[section].isExpanded = !isExpanded
        
        if isExpanded {
            categoryTableView.deleteRows(at: indexPaths, with: .fade)
            UIView.animate(withDuration: 0.3) {
                view.imageView?.transform = CGAffineTransform(rotationAngle: .pi / -2)
            }
        } else {
            categoryTableView.insertRows(at: indexPaths, with: .fade)
            UIView.animate(withDuration: 0.3) {
                view.imageView?.transform = CGAffineTransform.identity
            }
        }
    }
    
    // MARK:- SET TABLE VIEW CONTENT & VIEW HEIGHTS
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
