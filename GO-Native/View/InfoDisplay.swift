//
//  InfoDisplay.swift
//  GO-Native
//
//  Created by Peter Lee on 23/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class TopCell: BaseCell {
    
    var bird: Bird? {
        didSet {
            if let image = bird?.name {
                birdImage.image = UIImage(named: image.lowercased())
            }
            
            if let name = bird?.name {
                let mutableAttributedString = NSMutableAttributedString()
                var boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
                var italicAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)]
                
                if name.count > 5 {
                    boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
                    italicAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12)]
                    
                }
               
                let boldAttributedString = NSAttributedString(string: name, attributes: boldAttribute)
               
                mutableAttributedString.append(boldAttributedString)
               
                if let name = bird?.details {
                    // Check if this optional (maori name) is empty or not
                    if let maori = name.maoriName {
                        let italicAttributedString = NSAttributedString(string: maori, attributes: italicAttribute)
                        
                        mutableAttributedString.append(NSAttributedString(string: " "))
                        mutableAttributedString.append(italicAttributedString)
                        
                        nameLabel.attributedText = mutableAttributedString
                    }   else {
                        // if string is empty
                        nameLabel.attributedText = mutableAttributedString
                    }
                }
            }

            if let fineDetails = bird?.details {
                if let type = fineDetails.stats?.type {
                    birdType.text = type
                }
                if let status = fineDetails.stats?.status {
                    birdStatus.text = status
                }
                if let habitat = fineDetails.stats?.habitat {
                    birdHabitat.text = habitat         //TEXT paragraph style for spacing i think
                }
            }


        }
    }
    
    private let birdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.sizeToFit()
        imageView.layer.borderWidth = 5.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        
        name.numberOfLines = 0
        name.textColor = .black
        return name
    }()
    
    private let divider: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }()
    
    private let categorySubheader: UIStackView = {
        let labelTitleColor = UIColor.darkGray
        
        let typeTitle = UILabel()
        typeTitle.text = "TYPE"
        typeTitle.textColor = labelTitleColor
        
        let statusTitle = UILabel()
        statusTitle.text = "STATUS"
        statusTitle.textColor = labelTitleColor
        
        let habitatTitle = UILabel()
        habitatTitle.text = "HABITAT"
        habitatTitle.textColor = labelTitleColor
        
        typeTitle.font = typeTitle.font.withSize(12)
        statusTitle.font = statusTitle.font.withSize(12)
        habitatTitle.font = habitatTitle.font.withSize(12)
                
        return UIStackView(arrangedSubviews: [typeTitle, statusTitle, habitatTitle])
    }()
    
    private let birdType: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(12)
        return label
    }()
    
    private let birdStatus: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(12)
        return label
    }()
    
    private let birdHabitat: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(12)
        return label
    }()
  
    override func setupLayout() {
        backgroundColor = UIColor.rgb(red: 239, green: 239, blue: 239)
        layer.cornerRadius = 5
        
        addSubview(birdImage)
        addSubview(nameLabel)
        addSubview(divider)
        
        birdImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.width/3 , height: frame.width/3)
        birdImage.layer.cornerRadius = frame.width / 6
        
        nameLabel.anchor(top: topAnchor, left: birdImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        divider.anchor(top: nameLabel.bottomAnchor, left: birdImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: (frame.width/3) * 2, height: 3)
        
        // Extra details
        categorySubheader.axis = .vertical
        categorySubheader.distribution = .fillEqually
        categorySubheader.spacing = 5
        
        let categoryDetails = UIStackView(arrangedSubviews: [birdType, birdStatus, birdHabitat])
        categoryDetails.axis = .vertical
        categoryDetails.distribution = .fillEqually
        categoryDetails.spacing = 5

        let combinedCategory = UIStackView(arrangedSubviews: [categorySubheader, categoryDetails])
        combinedCategory.distribution = .fillEqually
        combinedCategory.spacing = -40

        addSubview(combinedCategory)
        
        combinedCategory.anchor(top: divider.bottomAnchor, left: birdImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
    }
    
}

class DescriptionCell: BaseCell {
    
    var bird: Bird? {
        didSet {
            if let i = bird?.details {
                if let description = i.description {
                    descriptionText.text = description //Probably want ATTR STRING instead
                }
            }
        }
    }
      
    private let header: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
      
    private let descriptionText: UITextView = {
        let description = UITextView()
        description.backgroundColor = .clear
        description.textContainer.lineFragmentPadding = 0 // bring text to left edge
        description.textContainerInset = .zero // bring text to align with top
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        
        let paragraphString = NSMutableAttributedString(string: "Tui are unique to New Zealand and belong to the honeyeater family, which means they feed mainly on nectar from flowers of native plants.\nCan be locally abundant where there is good pest control and flowering/fruiting habitat.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        description.attributedText = paragraphString
        description.sizeToFit()
        description.isEditable = false
        description.font = UIFont.systemFont(ofSize: 12)
        description.textColor = .black
        
        return description
      }()
    
    override func setupLayout() {
        backgroundColor = UIColor.rgb(red: 239, green: 239, blue: 239)
        layer.cornerRadius = 5
        
        addSubview(header)
        addSubview(descriptionText)
        
        header.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        descriptionText.anchor(top: header.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
    }
}

class SightingCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // TOFIX
    var imageList: Bird?
    
    private let cellId = "cellId"
    
    private let header: UILabel = {
        let label = UILabel()
        label.text = "My Sightings"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // Holds Sighting Images
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        return collection
    }()
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 //TEMP
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        
        //TO FIX
        if let unwrap = imageList?.name {
            if indexPath.item == 0 {
                  cell.bird = "\(unwrap)_sighting1"
            } else if indexPath.item == 1 {
                  cell.bird = "\(unwrap)_sighting2"
            } else if indexPath.item == 2 {
                cell.bird = "\(unwrap)_sighting3"
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: frame.width/3)
    }
           
    override func setupLayout() {
        backgroundColor = UIColor.rgb(red: 239, green: 239, blue: 239)
        layer.cornerRadius = 5
        
        addSubview(header)
        addSubview(collectionView)
        
        header.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        collectionView.anchor(top: header.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
   }
}

class ImageCell: BaseCell {
    
    var bird: String? {
         didSet {
            if let images = bird {
                imageView.image = UIImage(named: images.lowercased())
             }
         }
     }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setupLayout() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        backgroundColor = .purple //TEMP
    }
}

class LocationCell: BaseCell {
    
    private let header: UILabel = {
        let label = UILabel()
        label.text = "Sighting Map"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
     }()
    
    private let map: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "larger geomap")
        imageView.layer.masksToBounds = true
        imageView.sizeToFit()
        return imageView
    }()
    
    override func setupLayout() {
        backgroundColor = UIColor.rgb(red: 239, green: 239, blue: 239)
        layer.cornerRadius = 5
        
        addSubview(header)
        addSubview(map)
        
       header.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        map.anchor(top: header.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: 0, height: 0)
    }
    
}
