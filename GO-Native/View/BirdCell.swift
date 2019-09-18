//
//  HomeView.swift
//  GO-Native
//
//  Created by Peter Lee on 14/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class BirdCell: UICollectionViewCell {
    
    private let birdImage: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "tui"))
        imageView.translatesAutoresizingMaskIntoConstraints = false // Enable autolayout
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let birdName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(birdImage)

        // Center Image
        birdImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        // Adjust Width and Height of Image - Make them the same lengths
        birdImage.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        birdImage.heightAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        birdImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        birdImage.layer.cornerRadius = self.bounds.width / 2 // Make it Round
        
        addSubview(birdName)
        
        // Anchor Name below Image
        birdName.topAnchor.constraint(equalTo: birdImage.bottomAnchor, constant: 5).isActive = true
        birdName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        birdName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        birdName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0 ).isActive = true
        birdName.heightAnchor.constraint(equalToConstant: (self.bounds.height/4) - 5).isActive = true // consider anchor constant
        birdName.layer.cornerRadius = self.bounds.width / 10 // Make it Round

        
    }
}
