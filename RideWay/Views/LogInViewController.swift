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
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var userEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        loginEmailTextfield.layer.borderWidth = 1
        loginEmailTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        loginPasswordTextfield.layer.borderWidth = 1
        loginPasswordTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        var message: String = ""
        guard let email = loginEmailTextfield.text, !email.isEmpty else {
            print("Something is wrong with the user's email")
            message = "Please enter a valid email and password"
            self.showActionSheet(message: message)
            return
        }
        guard let password = loginPasswordTextfield.text, !password.isEmpty else {
            print("Something is wrong with the user's password")
            message = "Please enter a valid email and password"
            self.showActionSheet(message: message)
            return
        }
        print(email)
        print(password)
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let user = user {
                print("📍📍📍📍📍 User: \(String(describing: user.user.email)) 📍📍📍📍📍")
                guard let email = user.user.email else {
                    print("Problem getting user email in signIn")
                    message = "Please enter a valid email and password"
                    self.showActionSheet(message: message)
                    return
                }
                self.userEmail = email
                self.performSegue(withIdentifier: "toHome", sender: self)
            } else {
                // show error message
                if let error = error {
                    print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    if error.localizedDescription == "The password is invalid or the user does not have a password." {
                        print("This email and password combination is incorrect")
                        message = "This email and password combination is incorrect"
                    } else if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        print("No such user")
                        message = "No such user"
                    } else if error.localizedDescription == "The email address is badly formatted." {
                        message = "The email needs tp be correctly formatted"
                    }
                    self.showActionSheet(message: message)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginEmailTextfield.resignFirstResponder()
        loginPasswordTextfield.resignFirstResponder()
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            if let desitnationVC = segue.destination as? HomeViewController {
                desitnationVC.email = userEmail
            }
        }
    }
}

extension LogInViewController {
    func showActionSheet(message: String) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        actionSheet.title = message
        present(actionSheet, animated: true, completion: nil)
    }
}
