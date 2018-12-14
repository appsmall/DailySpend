//
//  LoginVC.swift
//  DailySpend
//
//  Created by Shashank Panwar on 08/12/18.
//  Copyright © 2018 outect. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    struct Storyboard {
        static let signInVCToForgotPwdVC = "signInVCToForgotPwdVC"
        static let signinVCToSignupVC = "signinVCToSignupVC"
    }
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTFView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTFView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var createNewAccount: UIButton!
    @IBOutlet weak var userTFTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTFLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var semiCircleView: UIView!
    @IBOutlet weak var semiCircleViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var semiCircleViewHeightConstraint: NSLayoutConstraint!
    
    
    // MARK:- VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK:- CORE FUNCTIONS
    func setupUI() {
        emailView.cornerView()
        emailTFView.cornerView()
        passwordView.cornerView()
        passwordTFView.cornerView()
        
        loginButton.shadow(isCorner: false, color: UIColor.darkGray)
        //emailTFView.shadow(isCorner: true, color: UIColor.darkGray)
        //forgotPassword.textShadow()
        //createNewAccount.textShadow()
    }
    
    func userNameViewCovered() {
        UIView.animate(withDuration: 0.2) {
            self.userTFTrailingConstraint.constant = 0
            self.emailTFView.backgroundColor = UIColor(red: 117/255, green: 95/255, blue: 82/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func passwordViewCovered() {
        UIView.animate(withDuration: 0.2) {
            self.passwordTFLeadingConstraint.constant = 0
            self.passwordTFView.backgroundColor = UIColor(red: 117/255, green: 95/255, blue: 82/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func userNameViewUncovered() {
        UIView.animate(withDuration: 0.2) {
            self.userTFTrailingConstraint.constant = 60
            self.emailTFView.backgroundColor = UIColor(red: 128/255, green: 105/255, blue: 87/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    func passwordViewUncovered() {
        UIView.animate(withDuration: 0.2) {
            self.passwordTFLeadingConstraint.constant = 60
            self.passwordTFView.backgroundColor = UIColor(red: 128/255, green: 105/255, blue: 87/255, alpha: 1)
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK:- IBACTIONS
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func forgotPwdBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Storyboard.signInVCToForgotPwdVC, sender: nil)
    }
    
    @IBAction func createNewAccountBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Storyboard.signinVCToSignupVC, sender: nil)
    }
    
}


// MARK:- TEXT FIELD DELEGATE METHODS
extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            self.userNameViewCovered()
            self.passwordViewUncovered()
            
        case passwordTextField:
            self.passwordViewCovered()
            self.userNameViewUncovered()
            
        default:
            print("Default Case")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            self.userNameViewUncovered()
            
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            self.passwordViewUncovered()
            
        default:
            print("Default Case")
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.userNameViewUncovered()
        self.passwordViewUncovered()
    }
}
