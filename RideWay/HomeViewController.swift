//
//  HomeViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/7/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var introLabel: UILabel!
    
    // MARK: - Properties
    var email: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad email: \(email)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let email = email else {
            print("There is an errpr in HomeViewController email")
            return
        }
        introLabel.text = "Holy Shit, \(email), you made it!"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
