//
//  RegisterScreenVC.swift
//  Insta
//
//  Created by Toqsoft on 17/01/25.
//

import UIKit

class RegisterScreenVC: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var passWordTf: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var mobileNoOrEmailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
       
    }
        @objc func dismissKeyboard() {
          view.endEditing(true)
      }
    @IBAction func signUp(_ sender: Any) {
        // Validate user input
            guard let username = UserName.text, !username.isEmpty,
                  let fullName = fullNameTF.text, !fullName.isEmpty,
                  let mobileOrEmail = mobileNoOrEmailTF.text, !mobileOrEmail.isEmpty,
                  let password = passWordTf.text, !password.isEmpty else {
                showAlert(title: "Error", message: "All fields are required.")
                return
            }

            // Store data in UserDefaults
            let userData: [String: String] = [
                "username": username,
                "fullName": fullName,
                "mobileOrEmail": mobileOrEmail,
                "password": password
            ]
            UserDefaults.standard.set(userData, forKey: "UserData")
            
            // Navigate to LoginScreenVC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LoginScreenVC") as! LoginScreenVC
            self.present(controller, animated: true)
        }

        // Helper to show alerts
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
