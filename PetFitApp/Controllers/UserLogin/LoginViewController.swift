//
//  LoginViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 26/11/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.text = "sara@gmail.com"
        passwordTextField.text = "1234@sara"
        setUpeElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginbuttonTapped(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    Utilities.showError(error?.localizedDescription ?? "", self.errorLabel)
                } else {
                    Utilities.transitionToHome(self.view,self.storyboard)
                }
            }
        }
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
        print("signin")
    }
}

extension LoginViewController {
    func setUpeElements() {
        self.errorLabel.alpha = 0
        Utilities.styleTextField(emailTextfield)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signInButton)
        Utilities.styleFilledButton(loginButton)
    }
}
