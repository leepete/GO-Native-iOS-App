//
//  Model.swift
//  GO-Native
//
//  Created by Peter Lee on 20/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

struct Bird : Decodable{
    let birdName : String
    let maoriName : String
    let description: String
    let rarity: String
    let type: String
}


struct BirdInventory: Decodable{
    var name: String?
    var birds: [Bird]?
    
    // Parses JSON File
    static func fetchBirds(completionHandler: @escaping ([Bird]) -> ()){
        guard let jsonUrlString = Bundle.main.path(forResource: "birdsInfo", ofType: "json") else { return }
        let url = URL(fileURLWithPath: jsonUrlString)
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to retrieve data from file:" , err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let birds = try JSONDecoder().decode([Bird].self, from: data)
                
                var birdObjects = [Bird]()
                
                for bird in birds {
                    let obj = Bird(birdName: bird.birdName, maoriName: bird.maoriName, description: bird.description, rarity: bird.rarity, type: bird.type)
                    birdObjects.append(obj) // add to list of objects
                }
                
                DispatchQueue.main.async {
                    completionHandler(birdObjects) // completion handler when done
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
    
}
