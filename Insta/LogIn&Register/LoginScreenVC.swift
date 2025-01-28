//
//  LoginScreenVC.swift
//  Insta
//
//  Created by Toqsoft on 17/01/25.
//

import UIKit

class LoginScreenVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var passWordTF: UITextField!
    @IBOutlet weak var enterUsernameOrNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
          view.endEditing(true)
      }

    @IBAction func forgetpassWordBtn(_ sender: Any) {
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let enteredUsername = enterUsernameOrNumber.text, !enteredUsername.isEmpty,
                  let enteredPassword = passWordTF.text, !enteredPassword.isEmpty else {
                showAlert(title: "Error", message: "Please enter both username and password.")
                return
            }
            
            if let savedUserData = UserDefaults.standard.dictionary(forKey: "UserData") as? [String: String],
               let savedUsername = savedUserData["username"],
               let savedPassword = savedUserData["password"] {
                
                if enteredUsername == savedUsername && enteredPassword == savedPassword {
                    // Save login state
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    
                    // Navigate to MainTabBarController
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                    self.present(controller, animated: true)
                } else {
                    showAlert(title: "Error", message: "Invalid username or password.")
                }
            } else {
                showAlert(title: "Error", message: "No user data found. Please register first.")
            }
    }
    
    @IBAction func signinButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterScreenVC") as! RegisterScreenVC
        self.present(controller, animated: true)
    }
    // Helper to show alerts
       func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           self.present(alert, animated: true)
       }
}
