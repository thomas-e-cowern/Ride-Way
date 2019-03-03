//
//  VehicleController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/8/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class VehicleController {
    
    static let shared =  VehicleController()
    
    var bikeCount: Int = 0
    
    func createVehicleInfo(displacementCC: String, displacementCI: String, make: String, model: String, year: String, plantCity: String, plantState: String, vin: String, completion: @escaping (VehicleInfo?) -> Void) {
        let vehicleInfo = VehicleInfo(displacementCC: displacementCC, displacementCI: displacementCI, make: make, model: model, year: year, plantCity: plantCity, plantState: plantState, vin: vin)
        FirebaseController.shared.saveToDatabase(vehicleInfo: vehicleInfo, completion: completion)
    }
    
    func saveVehicleInfo(displacementCC: String, displacementCI: String, make: String, model: String, year: String, plantCity: String, plantState: String, vin: String, image: Data, completion: @escaping (VehicleInfo?) -> Void) {
        let vehicleInfo = VehicleInfo(displacementCC: displacementCC, displacementCI: displacementCI, make: make, model: model, year: year, plantCity: plantCity, plantState: plantState, vin: vin)
        FirebaseController.shared.saveBikePic(bike: vehicleInfo, image: image)
//        FirebaseController.shared.saveToDatabase(vehicleInfo: vehicleInfo, completion: completion)
    }
    
    func fetchVehicles(completion: @escaping ([VehicleInfo]?) -> Void) {
        FirebaseController.shared.fetchVehiclesFromFirebaseFor(completion: completion)
    }
    
    func deleteMotorcycle(motorcycle: VehicleInfo, completion: @escaping (Bool) -> Void) {
        FirebaseController.shared.deleteVehicleFromFirebase(vehicle: motorcycle) { (success) in
            if success == true {
                print("deleted Motorcycle")
                completion(true)
            } else {
                print("problem deleting motorcycle")
                completion(false)
            }
        }
    }
    
    func fetchVinResults(with userVin: String, completion: @escaping (VehicleInfo?) -> Void) {
        // reference complete url: "https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvaluesextended/5UXWX7C5*BA?format=json"
        // base url
        let vinBaseUrl = URL(string: "https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvaluesextended/")
        // ensure base url is present
        guard var url = vinBaseUrl else {
            print("There is no baseUrl")
            return
        }
        // append userVin to the url
        url.appendPathComponent(userVin)
        // add the json format variable to a url component
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let returnQueryType = URLQueryItem(name: "format", value: "json")
        // add the components
        components?.queryItems = [returnQueryType]
        // put the final url together with all info
        guard let finalUrl = components?.url else {
            print("There is a problem with the finalUrl")
            return
        }
        // set up the request
        let request = URLRequest(url: finalUrl)
        
        print("💙💙💙💙💙URL: \(request)💙💙💙💙💙")
        // Making the fetch call to the api
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // check for an error immediately
            if let error = error {
                print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            // ensure data is present
            guard let data = data else {
                print("There was something wrong with the data")
                return
            }
//            print("💜💜💜💜💜Data: \(data)💜💜💜💜💜")
            // initialize json decoder
//            let jsonDecoder = JSONDecoder()
             // decode the json data returned and check for errors
            do {
                let vehicleJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                guard let unwrappedVehicle = vehicleJson?["Results"] else { return }
                print("VJ: \(String(describing: unwrappedVehicle))")
                let thisVehicle = unwrappedVehicle as? [String : String]
                print("TV: \(String(describing: thisVehicle))")
//                let thisVehicle = try JSONSerialization.jsonObject(with: unwrappedVehicle, options: []) as? [String : Any]
////                guard let thisVehicle = vehicleJson?["Results"] else { return }
//                print("💚💚💚💚💚Vehicle Info: \(thisVehicle)💚💚💚💚💚")
//                let vehicleInfo = VehicleInfo(dictionary: thisVehicle)
                // return the info for additional uses
                
                completion(nil)
            } catch {
                print("😡 👎 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
}
