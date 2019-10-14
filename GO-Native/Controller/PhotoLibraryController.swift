//
//  PhotoLibraryController.swift
//  GO-Native
//
//  Created by Peter Lee on 4/10/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit
import Photos // Photos Framework to fetch photos

class PhotoLibraryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    
    var selectedImage: UIImage? // Current selected image
    var cellSelectedIndex = 0 // Selected Cell index - default is 0 (first cell)
    var images = [UIImage]() // Smaller sized Images
    var assets = [PHAsset]() // Original Sized Images
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        
        collectionView.backgroundColor = .white
        
        collectionView?.register(PhotoLibraryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PhotoLibraryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchPhotos()
    }
        
    fileprivate func assetFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30 // TEMP
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false) // sort images in descending order
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    
    fileprivate func fetchPhotos() {
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetFetchOptions())
        
        DispatchQueue.global(qos: .background).async { // Load it up in the "background thread" to reduce hanging time
            allPhotos.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200) // Initial Image size - have to re-fetch for larger size
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) {  (image, info) in
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset) // For original sized images
                           
                        // Select first image (will go through each enumeration) to be the selected image
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async { // Get back on the "main thread"
                            self.collectionView?.reloadData()
                        }
                    }
                }
           }
        }
    }
    
    fileprivate func setupNavigationController() {
        navigationItem.title = "Camera roll"
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext() {
        let nextViewController = AddBirdController()
        nextViewController.receivedImage = selectedImage
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelectedIndex = indexPath.item // keep track of indexPath
        
        self.selectedImage = images[cellSelectedIndex] // set image
        
        collectionView.reloadData() // make the CollectionView redraw itself/refresh so it shows the selectedImage in header
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoLibraryHeaderView
        header.photoImageView.image = selectedImage
        
        // re-fetching to get larger image size
        if let selectedImage = selectedImage {
            if let index = self.images.firstIndex(of: selectedImage) {
                let selectedAsset = self.assets[index]
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600) //larger size
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { (image, info) in  // Pull request the larger sized image
                    header.photoImageView.image = image
                }
            }
        }
        return header
    }
    
    // Header Size (needed)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoLibraryCell
        cell.photoImageView.image = images[indexPath.item]
        
        // Selection Highlighting
        if indexPath.item == 0 && cellSelectedIndex == 0 { // when presented, "highlight" first cell
            cell.photoImageView.alpha = 0.5
        } else if indexPath.item == cellSelectedIndex { // select other images
            cell.photoImageView.alpha = 0.5
        } else { // deselect images
            cell.photoImageView.alpha = 1.0
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width/4 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // Left and Right between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // Padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

}
