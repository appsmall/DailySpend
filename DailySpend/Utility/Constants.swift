//
//  Constants.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 21/10/18.
//  Copyright © 2018 outect. All rights reserved.
//

import Foundation

let emptyString = ""
let storyboardIdParam = "VC"


// MARK:- STORYBOARD ID's
struct StoryboardId {
    static let dashboardVC = "DashboardVC"
    static let addSpendVC = "AddSpendVC"
    static let categoryVC = "CategoryVC"
    static let spendDetailVC = "SpendDetailsVC"
    static let reportVC = "ReportVC"
}

// MARK:- ALERT
struct Alert {
    static let alert = "Alert"
    static let ok = "Ok"
    static let cancel = "Cancel"
}

struct Menu {
    static let dashboard = "Dashboard"
    static let addSpend = "Add Spend"
    static let category = "Category"
    static let spendDetails = "Spend Details"
    static let report = "Report"
}

// MARK:- GENERAL MESSGES
let atleastOneOfTheFieldIsEmpty = "Atleast one of the field is empty"
let pleaseEnterTheCategory = "Please enter the category."
let pleaseEnterTheSubCategory = "Please enter the sub-category."
let uploadPicture = "Upload Picture"
let pleaseSelectPictureMethod = "Please select a picture method."
let openCamera = "Open Camera"
let openPhotoGallery = "Open Photo Library"
let cameraNotAvailable = "Camera not available on your device."
let photoLibraryNotAvailable = "Photo library not available on your device."
