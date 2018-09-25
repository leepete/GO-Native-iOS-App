//
//  BirdAddedController.swift
//  GO-Native
//
//  Created by Peter Lee on 12/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

class BirdAddedController: UIViewController {
    
    //Reading in Data
    var birds = [birdInfo]() //stores bird info
    
    @IBOutlet weak var birdLabel: UILabel!
    @IBOutlet weak var birdImage: UIImageView!
    
    var birdName = String()   //name of bird selected
    var birdPic = UIImage()     //Image of bird selected
    
    //name of bird selected
    var birdLabelMaoriSelect = String()
    
    //Type of bird selected
    var birdTypeSelect = String()
    
    //Status of bird selected
    var birdStatusSelect = String()
    
    //Description of bird selected
    var birdDescSelect = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set image and text to show up
        birdLabel.text = birdName
        birdImage.image = birdPic
        
        birdImage.layer.cornerRadius = birdImage.frame.height / 2
        birdImage.layer.borderWidth = 6.0
        birdImage.layer.borderColor = UIColor.white.cgColor
        birdImage.clipsToBounds = true
        
        loadJson()
        
        for bird in birds{
            if birdName == bird.birdName{
                birdLabelMaoriSelect = bird.maoriName
                birdTypeSelect = bird.type
                birdStatusSelect = bird.rarity
                birdDescSelect = bird.description
            }
        }
        
       self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Loads the json file with the bird data
    func loadJson(){
        let url = Bundle.main.url(forResource: "birdsInfo", withExtension: "json")!
        do{
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.birds = try decoder.decode([birdInfo].self, from: data)
        } catch let error {
            print(error as? Any)
        }
    }
    
    
    //Wanting to push the Label selected into the next View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let birdInfoController = segue.destination as? BirdInfoController{
            birdInfoController.birdImage = birdPic
            birdInfoController.birdName = birdName
            birdInfoController.birdNameMaori = birdLabelMaoriSelect
            birdInfoController.birdType = birdTypeSelect
            birdInfoController.birdStatus = birdStatusSelect
            birdInfoController.birdDescription = birdDescSelect
        }
        
    }
    
    //Go back to initial View Controller
    
//    @IBAction func seeTree(_ sender: UIButton) {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    
    
    
}

