//
//  AddABird.swift
//  GO-Native
//
//  Created by Peter Lee on 11/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

class AddABirdController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    //Image from Camera or Photo Library
    @IBOutlet weak var displayAddedImage: UIImageView!
    var imageView: UIImage!
    
    @IBOutlet weak var pleaseSelectButton: UIButton! //may want to parse this in a parameter instead of using it publicly
    
    //Reading in Data
    var birds = [birdInfo]() //stores bird info
    
    //to allow only one selection
    var selectedCell = false
    var count = 0
    
    //name of bird selected
    var birdLabelSelect = String()
    
    //Image of bird selected
    var birdImageSelect = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadJson()
        print(birds)
        
        //Checks if image is not null
        if imageView != nil {
            displayAddedImage.image = imageView
            displayAddedImage.layer.cornerRadius = displayAddedImage.frame.height/2
            displayAddedImage.layer.borderWidth = 5.0
             displayAddedImage.layer.borderColor = UIColor.white.cgColor
             displayAddedImage.clipsToBounds = true
        }
        
        //Initial adding button is disabled
        pleaseSelectButton.isEnabled = false
        
        
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
    

    //The amount of items we want in our collection view  - will be the same as number of images in array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return birds.count
    }

    //Populate the Collection views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let bird = birds[indexPath.row] //select the birds from data
        
        cell.myImageView.image = UIImage(named: bird.birdName.lowercased())
        cell.myLabel.text = bird.birdName
       
        return cell
    }
    
    
    //If cell is touched - THIS COULD BE WAY BETTER, but works for somewhat for now - still needs fix
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let bird = birds[indexPath.row] //select the birds from data
        birdLabelSelect = bird.birdName //get label
        birdImageSelect = UIImage(named: bird.birdName.lowercased())! //get image
        print(birdLabelSelect)
        
        if count == 0 && selectedCell == false{
            selectedCell = true //set true when touched
            
            cell?.layer.borderWidth = 4.0
            cell?.layer.borderColor = UIColor.yellow.cgColor
            
            pleaseSelectButton.setImage(UIImage(named: "save"), for: UIControl.State.normal) //change image
            pleaseSelectButton.isEnabled = true
            count += 1 //add 1 because we only want to allow 1
        } else{
            cell?.layer.borderWidth = 0.0
            cell?.layer.borderColor = nil
            
            pleaseSelectButton.setImage(UIImage(named: "nobird"), for: UIControl.State.normal) //change image
            pleaseSelectButton.isEnabled = false
            count -= 1 //subtract because it has been deselected
            selectedCell = false
        }
    }
    
    //Wanting to push the Label selected into the next View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let birdAddedController = segue.destination as! BirdAddedController
        birdAddedController.birdName = birdLabelSelect
        birdAddedController.birdPic = birdImageSelect
        
    }
    
    

}


