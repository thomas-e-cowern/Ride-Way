//
//  LogInViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/18/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var loginEmailTextfield: UITextField!
    @IBOutlet weak var loginPasswordTextfield: UITextField!
    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEmailTextfield.layer.borderWidth = 1
        loginEmailTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        loginPasswordTextfield.layer.borderWidth = 1
        loginPasswordTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = loginEmailTextfield.text, !email.isEmpty else {
            print("Something is wrong with the user's email")
            return
        }
        guard let password = loginPasswordTextfield.text, !password.isEmpty else {
            print("Something is wrong with the user's password")
            return
        }
        print(email)
        print(password)
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let user = user {
                print("📍📍📍📍📍 User: \(user.user.email) 📍📍📍📍📍")
                guard let email = user.user.email else {
                    print("Problem getting user email in signIn")
                    return
                }
                self.userEmail = email
                self.performSegue(withIdentifier: "toHome", sender: self)
            } else {
                // show error message
                if let error = error {
                    print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            if let desitnationVC = segue.destination as? HomeViewController {
                desitnationVC.email = userEmail
            }
        }
    }
}
