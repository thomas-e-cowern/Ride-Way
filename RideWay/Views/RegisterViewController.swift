//
//  RegisterViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/18/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerEmailTextfield: UITextField!
    @IBOutlet weak var registerPasswordTextfield: UITextField!
    @IBOutlet weak var registerConfirmPasswordTextfield: UITextField!
    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerEmailTextfield.layer.borderWidth = 1
        registerEmailTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        registerPasswordTextfield.layer.borderWidth = 1
        registerPasswordTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        registerConfirmPasswordTextfield.layer.borderWidth = 1
        registerConfirmPasswordTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        
        
        guard let email = registerEmailTextfield.text, !email.isEmpty else {
            print("Something is wrong with the user's email")
            return
        }
        guard let password = registerPasswordTextfield.text, !password.isEmpty else {
            print("Something is wrong with the user's password")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // check data was returned
            if let user = user {
                // transition to home screen
                //                    print("📍📍📍📍📍 User: \(user.user.email) 📍📍📍📍📍")
                guard let email = user.user.email else {
                    print("Problem getting user email in createUser")
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
    
    @IBAction func backToLoginButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
