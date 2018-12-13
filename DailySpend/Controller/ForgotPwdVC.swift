//
//  ForgotPwdVC.swift
//  DailySpend
//
//  Created by Shashank Panwar on 13/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class ForgotPwdVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTFView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var userTFTrailingConstraint: NSLayoutConstraint!
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK:- CORE FUNCTIONS
    func setupUI() {
        emailView.cornerView()
        emailTFView.cornerView()
    }
    
    func userNameViewCovered() {
        UIView.animate(withDuration: 0.2) {
            self.userTFTrailingConstraint.constant = 0
            self.emailView.backgroundColor = UIColor(red: 117/255, green: 95/255, blue: 82/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func userNameViewUncovered() {
        UIView.animate(withDuration: 0.2) {
            self.userTFTrailingConstraint.constant = 60
            self.emailView.backgroundColor = UIColor(red: 128/255, green: 105/255, blue: 87/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    
    // MARK:- IBACTIONS
    @IBAction func resetBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func signInWithAnotherAccountBtnPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK:- TEXT FIELD DELEGATE METHODS
extension ForgotPwdVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            self.userNameViewCovered()
            
        default:
            print("Default Case")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            self.userNameViewUncovered()
            
        default:
            print("Default Case")
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.userNameViewUncovered()
    }
}
