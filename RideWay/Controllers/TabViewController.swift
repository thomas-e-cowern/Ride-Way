//
//  TabViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/18/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    var bikeInfo: VehicleInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TVC: \(String(describing: bikeInfo))")
        // Do any additional setup after loading the view.
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

extension TabViewController {

}
