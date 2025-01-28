//
//  ProfileVC.swift
//  Insta
//
//  Created by Toqsoft on 17/01/25.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var logout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func logoutBtn(_ sender: Any) {
        // Reset login state
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            
            // Navigate to LoginScreenVC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginScreenVC") as! LoginScreenVC
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
    }
}
