//
//  HomeController.swift
//  GO-Native
//
//  Created by Peter Lee on 14/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit


class HomeController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    
    var birdObjects = [Bird]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    private let backgroundImage : UIImageView = {
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.image = UIImage(named: "tree_background")
        background.contentMode = .scaleAspectFill
        return background
    }()
    
    private let addBirdButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"add_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Tree"
        
        setupLayout()
        
        // Make Bird Button work
        addBirdButton.addTarget(self, action: #selector(addPhotoAlert), for: .touchUpInside)
        
        // Register bird cells
        collectionView.register(BirdCell.self, forCellWithReuseIdentifier: cellId)

        // Get access to the Data Model
        BirdInventory.fetchBirds{(getBird) -> () in
            self.birdObjects = getBird
            self.collectionView.reloadData()
        }
    
    }
    
    // Number of Cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return birdObjects.count
    }
    
    // Manage data within cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BirdCell
        cell.birdInstance = birdObjects[indexPath.item] //get the cell instance and set/send it to the birdObjects that were retrieved
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
        
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    private func setupLayout() {
        for subview in self.view.subviews {
            // find the base background and remove it
            if(subview.restorationIdentifier == "background") {
                subview.removeFromSuperview()
            }
        }
        
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        view.addSubview(collectionView)
        view.addSubview(addBirdButton)
        
        collectionView.anchor(top: view.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: view.bounds.width, height: view.bounds.height - (view.bounds.height/6))
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addBirdButton.anchor(top: collectionView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        addBirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    

}
