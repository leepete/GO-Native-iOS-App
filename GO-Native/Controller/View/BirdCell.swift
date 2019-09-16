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
        imageView.clipsToBounds = true // allow rounding
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let birdName: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tui", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255/255, green: 205/255, blue: 0/255, alpha: 1.0)
        button.tintColor = .black // font colour
        button.clipsToBounds = true // allow rounding
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        addSubview(birdImage)
        addSubview(birdName)

        // Center Image
        birdImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        // Adjust Width and Height of Image
        birdImage.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        birdImage.heightAnchor.constraint(equalToConstant: self.bounds.height - (self.bounds.height/4)).isActive = true
        birdImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        birdImage.layer.cornerRadius = self.bounds.width / 2 // Make it Round
        
        // Anchor Name below Image
        birdName.topAnchor.constraint(equalTo: birdImage.bottomAnchor, constant: 5).isActive = true
        // Width and Height
        birdName.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        birdName.heightAnchor.constraint(equalToConstant: (self.bounds.height/4) - 5).isActive = true // consider anchor constant
        birdName.layer.cornerRadius = self.bounds.width / 10 // Make it Round
        
        
    }
}
