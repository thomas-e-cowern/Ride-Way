//
//  LogRegViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/7/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit
import Firebase

class LogRegViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var rideSegmentTabs: UISegmentedControl!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerLoginButton: UIButton!
    
    // MARK: - Properties
    var isSignedIn: Bool = false
    var userEmail: String = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    @IBAction func segmentSelected(_ sender: Any) {
        // reversing signed in status
        isSignedIn = !isSignedIn
        
        // set button accordingly
        if isSignedIn {
            registerLoginButton.setTitle("Login", for: .normal)
        } else {
            registerLoginButton.setTitle("Register", for: .normal)
        }
        
    }
    
    @IBAction func registerLoginButtonTapped(_ sender: Any) {
        // validate the user's data and clear the textfields
        guard let email = emailTextfield.text, !email.isEmpty else {
            print("Something is wrong with the user's email")
            return
        }
        guard let password = passwordTextfield.text, !password.isEmpty else {
            print("Something is wrong with the user's password")
            return
        }
        emailTextfield.text = nil
        passwordTextfield.text = nil
        // check login or register
        if isSignedIn {
            // sign in the user
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
        } else {
            // register the user
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                // check data was returned
                if let user = user {
                    // transition to home screen
                    print("📍📍📍📍📍 User: \(user.user.email) 📍📍📍📍📍")
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            if let desitnationVC = segue.destination as? HomeViewController {
                desitnationVC.email = userEmail
            }
        }
    }
}


