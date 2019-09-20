//
//  AddBirdController.swift
//  GO-Native
//
//  Created by Peter Lee on 19/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class AddBirdController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    
    var birdObjects = [Bird]()
    
    private let birdImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "tui"))
        image.clipsToBounds = true
        image.layer.borderWidth = 5.0
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    // Currently a static image - TOFIX
    private let geotagMap: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "geomap"))
        image.clipsToBounds = true
        image.layer.borderWidth = 5.0
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.rgb(red: 235, green: 235, blue: 235)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "nobird"), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add a Bird"
        
        setupLayout()
        
        collectionView.register(SelectBirdCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        // Get access to the Data Model
        BirdInventory.fetchBirds{(getBird) -> () in
            self.birdObjects = getBird
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return birdObjects.count
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
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectBirdCell
//        cell.backgroundColor = .red
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
        
        birdImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: outsidePadding, bottom: nil, paddingBottom: 0, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: outsidePadding, right: nil, paddingRight: 0, width: 130, height: 130)
        birdImage.layer.cornerRadius = 130 / 2
        
        geotagMap.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: outsidePadding, bottom: nil, paddingBottom: 0, left: birdImage.rightAnchor, paddingLeft: 8, right: view.rightAnchor, paddingRight: outsidePadding, width: 150, height: 130)
        geotagMap.layer.cornerRadius = 15
        
        collectionView.anchor(top: geotagMap.bottomAnchor, paddingTop: outsidePadding - (outsidePadding/3), bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: outsidePadding, right: view.rightAnchor, paddingRight: outsidePadding, width: width, height: height/2)
        collectionView.layer.cornerRadius = 15

        selectButton.anchor(top: collectionView.bottomAnchor, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
    }
    

}
