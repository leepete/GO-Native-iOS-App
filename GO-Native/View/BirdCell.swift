//
//  HomeView.swift
//  GO-Native
//
//  Created by Peter Lee on 14/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class BirdCell: BaseCell {
    
    var birdInstance: Bird? {
           didSet{
               if let imageName = birdInstance?.name {
                   birdImage.image = UIImage(named: imageName.lowercased())
               }
               
               if let name = birdInstance?.name{
                   let mutableAttributedString = NSMutableAttributedString()
                   let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
                   let italicAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12)]
                   
                   let boldAttributedString = NSAttributedString(string: name, attributes: boldAttribute)
                   
                   mutableAttributedString.append(boldAttributedString)
                   
                    if let name = birdInstance?.details {
                        // Check if this optional (maori name) is empty or not
                        guard let maori = name.maoriName, !maori.isEmpty else {
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
       }
    
    fileprivate let birdImage: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "tui"))
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    fileprivate let birdName: UILabel = {
        let name = UILabel()
        name.backgroundColor = UIColor.rgb(red: 255, green: 205, blue: 0)
        name.textColor = .black
        name.sizeToFit()
        name.numberOfLines = 0 // allows line break
        name.textAlignment = .center
        name.layer.masksToBounds = true
        return name
    }()
        
    override func setupLayout(){
        let width = self.bounds.width
        let height = self.bounds.height
        
        addSubview(birdImage)

        birdImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        birdImage.layer.cornerRadius = width / 2 // Make it Round
        birdImage.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: width, height: width)
        
        addSubview(birdName)
        birdName.layer.cornerRadius = width / 10 // Make it Round
        birdName.anchor(top: birdImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: width, height: (height/4) - 5)
    }
}

// This class is for the AddBirdController CollectionViewCell

class SelectBirdCell: BirdCell {
    override var birdInstance: Bird? {
        didSet{
            if let imageName = birdInstance?.name {
                let width = self.bounds.width
                
                birdImage.image = UIImage(named: imageName.lowercased())
                birdImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: width/2, height: width/2)
                birdImage.layer.cornerRadius = width/4
    
            }
            
            if let name = birdInstance?.name{
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

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
    }
}
