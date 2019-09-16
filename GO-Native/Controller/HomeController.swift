//
//  HomeController.swift
//  GO-Native
//
//  Created by Peter Lee on 14/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    
    var birdObjects = [Bird]()
    
    private let backgroundImage : UIImageView = {
       let background = UIImageView()
        background.image = UIImage(named: "tree_background")
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private let addBirdButton : UIButton = {
        let add = UIButton()
        add.setBackgroundImage(UIImage(named:"add_button"), for: .normal)
        return add
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Tree"
        
        collectionView?.backgroundView = backgroundImage
        
        collectionView?.register(BirdCell.self, forCellWithReuseIdentifier: cellId)
        
        // Get access to the data
        fetchBirds{(getBird) -> () in
            self.birdObjects = getBird
            self.collectionView?.reloadData()
        }
    }
    
    // Parses JSON File
    func fetchBirds(completionHandler: @escaping ([Bird]) -> ()){
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
    
    // Number of Cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return birdObjects.count
    }
    
    // Manage data within cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    // Width of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3 // "2" to account for the vertical spaces (pixels)
        return CGSize(width: width, height: width + (width/3))
    }
    
    //Horizontal Line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
   
    // Vertical Line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    // Collection View Padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top = CGFloat((view.frame.width / 5) / 2) // half of 1/5
        let left = CGFloat((view.frame.width / 5) / 2)
        let bottom = CGFloat(0)
        let right = CGFloat((view.frame.width / 5) / 2)
        
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

}
