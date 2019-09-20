//
//  HomeView.swift
//  GO-Native
//
//  Created by Peter Lee on 14/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class BirdCell: UICollectionViewCell {
    
    fileprivate let birdImage: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "tui"))
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    fileprivate let birdName: UILabel = {
        let name = UILabel()
        name.backgroundColor = UIColor.rgb(red: 255, green: 205, blue: 0)
        name.tintColor = .black // font colour
        name.sizeToFit()
        name.numberOfLines = 0 // allows line break
        name.textAlignment = .center
        name.clipsToBounds = true
        return name
    }()
    
    var birdInstance: Bird? {
        didSet{
            if let imageName = birdInstance?.birdName {
                birdImage.image = UIImage(named: imageName.lowercased())
                
            }
            
            if let name = birdInstance?.birdName{
                let mutableAttributedString = NSMutableAttributedString()
                let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
                let italicAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12)]
                
                let boldAttributedString = NSAttributedString(string: name, attributes: boldAttribute)
                
                mutableAttributedString.append(boldAttributedString)
                
                // Check if this optional (maori name) is empty or not
                guard let maori = birdInstance?.maoriName, !maori.isEmpty else {
                    // if string is empty
                    birdName.attributedText = mutableAttributedString
                    return
                }
                let italicAttributedString = NSAttributedString(string: maori, attributes: italicAttribute)
                
                mutableAttributedString.append(NSAttributedString(string: "\n"))
                mutableAttributedString.append(italicAttributedString)
                
                birdName.attributedText = mutableAttributedString
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        let width = self.bounds.width
        let height = self.bounds.height
        
        addSubview(birdImage)

        birdImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        birdImage.layer.cornerRadius = width / 2 // Make it Round
        birdImage.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: width, height: width)
        
        addSubview(birdName)
        birdName.layer.cornerRadius = width / 10 // Make it Round
        birdName.anchor(top: birdImage.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: self.leftAnchor, paddingLeft: 5, right: self.rightAnchor, paddingRight: 5, width: 0, height: (height/4) - 5)

        
    }
}

// This class is for the AddBirdController CollectionViewCell

class SelectBirdCell: BirdCell {
    override var birdInstance: Bird? {
        didSet{
            if let imageName = birdInstance?.birdName {
                let width = self.bounds.width
                
                birdImage.image = UIImage(named: imageName.lowercased())
                birdImage.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: width/2, height: width/2)
                birdImage.layer.cornerRadius = width/4
    
            }
            
            if let name = birdInstance?.birdName{
                let mutableAttributedString = NSMutableAttributedString()
                let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
                let boldAttributedString = NSAttributedString(string: name, attributes: boldAttribute)
                
                mutableAttributedString.append(boldAttributedString)
                birdName.attributedText = mutableAttributedString
        
                birdName.backgroundColor = .clear
                birdName.font = UIFont.boldSystemFont(ofSize: 12)
            }
        }
    }
}
