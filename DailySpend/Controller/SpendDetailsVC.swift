//
//  SpendDetailsVC.swift
//  DailySpend
//
//  Created by Rahul Chopra on 29/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit
import FSCalendar

class SpendDetailsVC: UIViewController {
    struct Storyboard {
        static let kCellId = "SpendDetailCell"
    }

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var spendDetailTableView: UITableView!
    
    var spendDetails = [ExpandableNames(isExpanded: false, category: "Grocery", subCategory: ["Misc", "Others"]),
                        ExpandableNames(isExpanded: false, category: "Petrol/Diesel", subCategory: ["Bike", "Scooty", "Car", "Bus", "Truck"]),
                        ExpandableNames(isExpanded: false, category: "Cloths", subCategory: ["Suit", "Blazzer", "Western Dress", "Jeans"])]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}


// MARK:- TABLEVIEW DATASOURCE & DELEGATE METHODS
extension SpendDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = spendDetails[section].category
        let isExpand = spendDetails[section].isExpanded
        
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
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
        return spendDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !spendDetails[section].isExpanded {
            return 0
        }
        return spendDetails[section].subCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.kCellId, for: indexPath)
        let name = spendDetails[indexPath.section].subCategory[indexPath.row]
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
        for row in spendDetails[section].subCategory.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = spendDetails[section].isExpanded
        spendDetails[section].isExpanded = !isExpanded
        
        if isExpanded {
            spendDetailTableView.deleteRows(at: indexPaths, with: .fade)
            UIView.animate(withDuration: 0.3) {
                view.imageView?.transform = CGAffineTransform(rotationAngle: .pi / -2)
            }
        } else {
            spendDetailTableView.insertRows(at: indexPaths, with: .fade)
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

// MARK:- FSCALENDAR DATA SOURCE & DELEGATE METHODS
extension SpendDetailsVC: FSCalendarDataSource, FSCalendarDelegate {
    
    // Show 'Food' string in place of Date
    /*func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return "Food"
    }
    
    // Show 'Food' string in the bottom of the Date
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return "Food"
    }
    
    // Show image in place of Date
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return UIImage(named: "ic_camera")
    }
    
    // This method will called when you swipe the view
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
     
    }*/
    
     // This method will called when you select the date
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected Date: \(date)")
    }
    
     // This method will called when you deselect the date
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Deselected Date: \(date)")
    }
    
}
