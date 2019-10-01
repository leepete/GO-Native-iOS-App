//
//  AddBirdController.swift
//  GO-Native
//
//  Created by Peter Lee on 19/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddBirdController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var ref: DatabaseReference?
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    
    var birdObjects = [Bird]()
    
    var receivedImage: UIImage?
    var isSelected: Bool = false
    var savedBird: Bird?
    
    private let birdImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.borderWidth = 5.0
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    // Currently a static image - TOFIX
    private let geotagMap: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "geomap"))
        image.layer.masksToBounds = true
        image.layer.borderWidth = 5.0
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.rgb(red: 239, green: 239, blue: 239)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "nobird"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add a Bird"
        birdImage.image = receivedImage
        
        setupLayout()
        
        collectionView.register(SelectBirdCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        // Get access to the Data Model
        LocalDatabase.fetchBirds{(getBird) -> () in
            self.birdObjects = getBird //doesnt work
            self.collectionView.reloadData()
        }
        
        selectButton.addTarget(self, action: #selector(saveSelection), for: .touchUpInside)
    }
    
    @objc func saveSelection() {
        let nextViewController = BirdAddedController()
        nextViewController.birdInstance = savedBird
        
        postToFirebase()
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func postToFirebase() {
        let postName = savedBird!.name!
        var postDetails: [String: Any]!
        var postStats: [String: String]!
        
        if let i = savedBird!.details {
            postStats = ["type": i.stats!.type!, "status": i.stats!.status!, "habitat": i.stats!.habitat!]
            postDetails = ["maoriName": i.maoriName!, "stats": postStats!, "description": i.description!]
        }

        let post: [String: Any] = [
            "name": postName,
            "details": postDetails!
        ]
       
        // Firebase Write
        ref = Database.database().reference()
        ref?.child("birds").childByAutoId().setValue(post)
    }
    
    func changeCell(cells: UICollectionViewCell) {
        let selectedColor = UIColor.rgb(red: 247, green: 186, blue: 0).cgColor
        
        for cell in cells.subviews {
            if cell is UIImageView {
                if cell.layer.borderColor != selectedColor { //if it isn't selected
                    cell.layer.borderColor = selectedColor
                } else {
                    cell.layer.borderColor = UIColor.white.cgColor
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return birdObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectBirdCell
        if !isSelected {
            changeCell(cells: cell)
            isSelected = true
            savedBird = cell.birdInstance
        }
        // Enable button when at least been touched once
        selectButton.setImage(UIImage(named: "save"), for: .normal)
        selectButton.isUserInteractionEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectBirdCell
        if isSelected {
           changeCell(cells: cell)
            isSelected = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width) / 3
        return CGSize(width: width, height: width - 35)
    }
    
    //Horizontal Line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Vertical Line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectBirdCell
        cell.birdInstance = birdObjects[indexPath.item]
        return cell
    }
    
    // Render out Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        return header
    }
    
    // Adjust Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        return .init(width: width, height: 50)
    }
    
    
    private func setupLayout() {
        
        let outsidePadding = CGFloat(24)
        let width = view.bounds.width
        let height = view.bounds.height
        
        view.addSubview(birdImage)
        view.addSubview(geotagMap)
        view.addSubview(collectionView)
        view.addSubview(selectButton)
        
        birdImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: outsidePadding, paddingLeft: outsidePadding, paddingBottom: 0, paddingRight: 0, width: 130, height: 130)
        birdImage.layer.cornerRadius = 130 / 2
        
        geotagMap.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: birdImage.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: outsidePadding,paddingLeft: 8, paddingBottom: 0, paddingRight: outsidePadding, width: 150, height: 130)
        geotagMap.layer.cornerRadius = 15
        
        collectionView.anchor(top: geotagMap.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: outsidePadding - (outsidePadding/3), paddingLeft: outsidePadding, paddingBottom: 0, paddingRight: outsidePadding, width: width, height: height/2)
        collectionView.layer.cornerRadius = 15

        selectButton.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    

}
