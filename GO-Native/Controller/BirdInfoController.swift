//
//  BirdInfoController.swift
//  GO-Native
//
//  Created by Peter Lee on 23/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class BirdInfoController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    private let topCellId = "topCellId"
    private let descCellId = "descCellId"
    private let sightCellId = "sightCellId"
    private let locationCellId = "mapCellId"
    
    var getBird: Bird?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bird Info"
        navigationController?.interactivePopGestureRecognizer?.delegate = self // allow swiping back
        
        setupLayout()
        
        collectionView.register(TopCell.self, forCellWithReuseIdentifier: topCellId)
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: descCellId)
        collectionView.register(SightingCell.self, forCellWithReuseIdentifier: sightCellId)
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: locationCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellId, for: indexPath) as! TopCell
            cell.bird = getBird
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descCellId, for: indexPath) as! DescriptionCell
            cell.bird = getBird
            return cell
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sightCellId, for: indexPath) as! SightingCell
            cell.imageList = getBird
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationCellId, for: indexPath) as! LocationCell // Doesnt need anything for now
            return cell
        }
    }
    
    // Cell Sizes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 60 is the total of padding from left + right combined
        let size: CGSize
        
        if indexPath.item == 0 {
            size = CGSize(width: view.frame.width - 60, height: view.frame.height/4 - 40)
        } else if indexPath.item == 1 {
            size = CGSize(width: view.frame.width - 60, height: view.frame.height/4 - 40)
        } else if indexPath.item == 2 {
            size = CGSize(width: view.frame.width - 60, height: view.frame.height/4 - 20)
        } else {
            size = CGSize(width: view.frame.width - 60, height: view.frame.height/4 - 10)
        }
        return size
    }
    
    // Vertical Line Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
     //Horizontal Line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }
    
    // Works with only the above line spacing functions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
    }
    
    
    
    private func setupLayout() {
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
}
