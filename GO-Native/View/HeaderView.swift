//
//  HeaderView.swift
//  GO-Native
//
//  Header for CollectionView in AddBirdController
//
//  Created by Peter Lee on 20/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Which bird did you find?"
        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
        headerLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerLabel.center(x: centerXAnchor, paddingX: 0, y: centerYAnchor, paddingY: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
