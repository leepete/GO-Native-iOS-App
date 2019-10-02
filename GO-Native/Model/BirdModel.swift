//
//  Model.swift
//  GO-Native
//
//  Created by Peter Lee on 20/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

struct BirdList : Codable {
    var birds: [Bird]?
}

struct Bird: Codable {
    let name : String?
    let details: BirdDetails?
}

struct BirdDetails: Codable {
    let maoriName : String?
    let stats: BirdStats?
    let description: String?
}

struct BirdStats: Codable {
    let type: String!
    let status: String!
    let habitat: String!
}

struct LocalDatabase: Decodable{
    
    // Gets local database
    static func fetchBirds(completionHandler: @escaping ([Bird]) -> ()){
        guard let jsonUrlString = Bundle.main.path(forResource: "birds_database", ofType: "json") else { return }
        let url = URL(fileURLWithPath: jsonUrlString) 
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to retrieve data from file:" , err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let birds = try decoder.decode(BirdList.self, from: data)
                
                var allBirds = [Bird]()
                
                for getBird in birds.birds! {
                    var stats: BirdStats?
                    var details: BirdDetails?
                    
                    if let deep = getBird.details {
                        stats = BirdStats(type: deep.stats!.type, status: deep.stats!.status, habitat: deep.stats!.habitat)
                        details = BirdDetails(maoriName: deep.maoriName, stats: stats!, description: deep.description)
                    }
                    let obj = Bird(name: getBird.name, details: details!)
                    allBirds.append(obj) // add to list of objects
                }
                
                DispatchQueue.main.async {
                    completionHandler(allBirds) // completion handler when done
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}
