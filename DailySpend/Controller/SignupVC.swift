//
//  SignupVC.swift
//  DailySpend
//
//  Created by Shashank Panwar on 13/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var userNameTFView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userNameTFViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTFView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTFViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTFView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTFViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTFView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneTFViewLeadingConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK:- CORE FUNCTIONS
    func setupUI() {
        usernameView.cornerView()
        userNameTFView.cornerView()
        emailView.cornerView()
        emailTFView.cornerView()
        passwordView.cornerView()
        passwordTFView.cornerView()
        phoneView.cornerView()
        phoneTFView.cornerView()
    }
    
    func userNameViewCovered() {
        UIView.animate(withDuration: 0.2) {
            self.userNameTFViewTrailingConstraint.constant = 0
            self.userNameTFView.backgroundColor = UIColor(red: 117/255, green: 95/255, blue: 82/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func emailViewCovered() {
        UIView.animate(withDuration: 0.2) {
            self.emailTFViewLeadingConstraint.constant = 0
            self.emailTFView.backgroundColor = UIColor(red: 117/255, green: 95/255, blue: 82/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func passwordViewCovered() {
        UIView.animate(withDuration: 0.2) {
            self.passwordTFViewTrailingConstraint.constant = 0
            self.passwordTFView.backgroundColor = UIColor(red: 117/255, green: 95/255, blue: 82/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func phoneViewCovered() {
        UIView.animate(withDuration: 0.2) {
            self.phoneTFViewLeadingConstraint.constant = 0
            self.phoneTFView.backgroundColor = UIColor(red: 117/255, green: 95/255, blue: 82/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func userNameViewUncovered() {
        UIView.animate(withDuration: 0.2) {
            self.userNameTFViewTrailingConstraint.constant = 60
            self.userNameTFView.backgroundColor = UIColor(red: 128/255, green: 105/255, blue: 87/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func emailViewUncovered() {
        UIView.animate(withDuration: 0.2) {
            self.emailTFViewLeadingConstraint.constant = 60
            self.emailTFView.backgroundColor = UIColor(red: 128/255, green: 105/255, blue: 87/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func passwordViewUncovered() {
        UIView.animate(withDuration: 0.2) {
            self.passwordTFViewTrailingConstraint.constant = 60
            self.passwordTFView.backgroundColor = UIColor(red: 128/255, green: 105/255, blue: 87/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func phoneViewUncovered() {
        UIView.animate(withDuration: 0.2) {
            self.phoneTFViewLeadingConstraint.constant = 60
            self.phoneTFView.backgroundColor = UIColor(red: 128/255, green: 105/255, blue: 87/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK:- TEXT FIELD DELEGATE METHODS
extension SignupVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case usernameTextField:
            self.userNameViewCovered()
            self.emailViewUncovered()
            self.passwordViewUncovered()
            self.phoneViewUncovered()
            
        case emailTextField:
            self.emailViewCovered()
            self.userNameViewUncovered()
            self.passwordViewUncovered()
            self.phoneViewUncovered()
            
        case passwordTextField:
            self.passwordViewCovered()
            self.userNameViewUncovered()
            self.emailViewUncovered()
            self.phoneViewUncovered()
            
        case phoneTextField:
            self.phoneViewCovered()
            self.userNameViewUncovered()
            self.emailViewUncovered()
            self.passwordViewUncovered()
            
        default:
            print("Default Case")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            emailTextField.becomeFirstResponder()
            self.emailViewUncovered()
            self.passwordViewUncovered()
            self.phoneViewUncovered()
            
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            self.userNameViewUncovered()
            self.passwordViewUncovered()
            self.phoneViewUncovered()
            
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            self.userNameViewUncovered()
            self.emailViewUncovered()
            self.phoneViewUncovered()
            
        case phoneTextField:
            phoneTextField.resignFirstResponder()
            self.userNameViewUncovered()
            self.emailViewUncovered()
            self.passwordViewUncovered()
            
        default:
            print("Default Case")
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.userNameViewUncovered()
        self.emailViewUncovered()
        self.passwordViewUncovered()
        self.phoneViewUncovered()
    }
}
