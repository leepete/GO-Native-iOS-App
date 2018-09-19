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
    
    let collectionImages: [String] = ["tui","kaka","fantail", "pukeko", "silvereye","blackbird","kakariki","kea", "pigeon", "seagull", "sparrow", "woodpigeon"]
    
    //to allow only one selection
    var selectedCell = false
    var count = 0
    
    //name of bird selected
    var birdSelectLabel = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Checks if image is not null
        if imageView != nil {
            displayAddedImage.image = imageView
        }
        
        //Initial adding button is disabled
        pleaseSelectButton.isEnabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //The amount of items we want in our collection view  - will be the same as number of images in array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImages.count
    }

    //Populate the views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.myImageView.image = UIImage(named: collectionImages[indexPath.row])
        cell.myLabel.text = collectionImages[indexPath.item]
        
        return cell
    }
    
    
    //If cell is touched - THIS COULD BE WAY BETTER, but works for somewhat for now - still needs fix
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        birdSelectLabel = collectionImages[indexPath.item] //get label
        print(birdSelectLabel)
        
        if count == 0{
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
        }
    }
    
    //Wanting to push the Label selected into the next View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let birdAddedController = segue.destination as! BirdAddedController
        birdAddedController.birdName = birdSelectLabel
    }
    
    

}


