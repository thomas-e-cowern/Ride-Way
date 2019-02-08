//
//  NewVehicleViewController.swift
//  FirebaseAuth
//
//  Created by Thomas Cowern New on 2/7/19.
//

import UIKit

class NewVehicleViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var vinTextfield: UITextField!
    @IBOutlet weak var vinButton: UIButton!
    @IBOutlet weak var yearResultLabel: UILabel!
    @IBOutlet weak var makeResultLabel: UILabel!
    @IBOutlet weak var modelResultLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Fetch info from API
    
    
    // MARK: - Methods
    @IBAction func getVinButtonTapped(_ sender: Any) {
        // reference complete url: "https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvaluesextended/5UXWX7C5*BA?format=json"
        // get the user's vin
        guard let userVin: String = vinTextfield.text else {
            print("Something went wrong getting the vin entered in the text box")
            return
        }
        // base url
        let vinBaseUrl = URL(string: "https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvaluesextended/")
        
        guard var url = vinBaseUrl else {
            print("There is no baseUrl")
            return
        }
        
        url.appendPathComponent(userVin)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let returnQueryType = URLQueryItem(name: "format", value: "json")
        
        components?.queryItems = [returnQueryType]
        
        guard let finalUrl = components?.url else {
            print("There is a problem with the finalUrl")
            return
        }
        
        var request = URLRequest(url: finalUrl)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let error = error {
                    print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                    return
                }
            
            guard let data = data as? [[String : Any]] else {
                print("There was something wrong with the data")
                return
            }
            
            let jsonDecoder = JSONDecoder()
        
            
        }.resume()
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
