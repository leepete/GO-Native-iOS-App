//
//  AddBirdController.swift
//  GO-Native
//
//  Created by Peter Lee on 19/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class AddBirdController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    private let collectionViewHeader: UILabel = {
        let label = UILabel()
        label.text = "Which bird did you find?"
        label.backgroundColor = .red
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        return cell
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

        selectButton.anchor(top: collectionView.bottomAnchor, paddingTop: outsidePadding/2, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
    }
    

}
