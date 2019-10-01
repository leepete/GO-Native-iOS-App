//
//  HomeController.swift
//  GO-Native
//
//  Created by Peter Lee on 14/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.S
//

import UIKit
import Firebase

class HomeController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    
    var postData: [Bird] = []
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let backgroundImage : UIImageView = {
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.image = UIImage(named: "tree_background")
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private let getExploringImage : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "emptybird"))
        iv.contentMode = .scaleAspectFit
        iv.restorationIdentifier = "getExploring";
        return iv
    }()
    
    private let addBirdButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"add_button"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Tree"

        readData(completionHandler: {(getBird) -> () in
            self.postData = getBird
            self.collectionView.reloadData()
        })
    
        setupLayout()
        
        // Make Bird Button work
        addBirdButton.addTarget(self, action: #selector(addPhotoAlert), for: .touchUpInside)
        
        // Register bird cells
        collectionView.register(BirdCell.self, forCellWithReuseIdentifier: cellId)
        
        for subview in self.view.subviews {
            // find the base background and remove it
            if(subview.restorationIdentifier == "background") {
                subview.removeFromSuperview()
            }
        }
    }
    
    func readData(completionHandler: @escaping ([Bird]) -> Void) {
        var allBirds = [Bird]()
        
        ref = Database.database().reference()
        databaseHandle = ref?.child("birds").observe(.childAdded, with: {(snapshot) in
            guard let post = snapshot.value as? Dictionary<String,Any> else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try JSONSerialization.data(withJSONObject: post)
                let model = try decoder.decode(Bird.self, from: jsonData)

                var stats: BirdStats?
                var details: BirdDetails?

                if let deep = model.details {
                    stats = BirdStats(type: deep.stats!.type, status: deep.stats!.status, habitat: deep.stats!.habitat)
                   details = BirdDetails(maoriName: deep.maoriName, stats: stats!, description: deep.description)
                }
                let obj = Bird(name: model.name!, details: details!)
                allBirds.append(obj) // add to list of objects

                DispatchQueue.main.async {
                    completionHandler(allBirds) // completion handler when done
                }
            } catch let err {
                print("Error: ", err)
          }
        })
    }
    
    
    // Number of Cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if postData.count > 0 {
             for subview in self.view.subviews {
                if(subview.restorationIdentifier == "getExploring"){ // TEMP HACK
                        subview.removeFromSuperview()
                }
            }
        }
        return postData.count
    }
    
    // SEGUE
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = BirdInfoController()
        nextViewController.getBird = postData[indexPath.item]
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // Manage data within cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BirdCell
        cell.birdInstance = postData[indexPath.item] //get the cell instance and set/send it to the postData that were retrieved
        return cell
    }
    
    // Width of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3 // "2" to account for the vertical spaces (pixels)
        let height = width + (width/3)
        return CGSize(width: width, height: height)
    }
    
    //Horizontal Line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
        
        return UIEdgeInsets(top: top/2, left: left, bottom: bottom, right: right)
    }
    
    private func setupLayout() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(getExploringImage)
        
        view.addSubview(collectionView)
        view.addSubview(addBirdButton)
        
        getExploringImage.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        getExploringImage.center(x: view.centerXAnchor, paddingX: 0, y: view.centerYAnchor, paddingY: 0)
        
        collectionView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.bounds.width, height: view.bounds.height - (view.bounds.height/6))
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addBirdButton.anchor(top: collectionView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addBirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}
