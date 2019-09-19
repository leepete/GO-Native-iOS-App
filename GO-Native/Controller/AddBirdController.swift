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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
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
        view.addSubview(birdImage)
        view.addSubview(geotagMap)
        view.addSubview(collectionView)
        view.addSubview(selectButton)
        
        birdImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16, bottom: nil, paddingBottom: 0, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 100, height: 100)

        
    }
    

}
