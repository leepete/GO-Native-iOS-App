//
//  BirdAddedController.swift
//  GO-Native
//
//  Created by Peter Lee on 21/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class BirdAddedController: BaseViewController{
    
    //ADD FLOW LAYOUT
    
    private let displayBird: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let topLabel: UILabel = {
        let text = UILabel()
        text.text = "Hooray! \n You collected a..."
        return text
    }()
    
    private let birdImage: UIImageView = {
        let image = UIImage(named: "tui")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let pointImage: UIImageView = {
        let image = UIImage(named: "points")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let birdLabel: UILabel = {
        let label = UILabel()
        label.text = "Tui \n Tui"
        return label
    }()
    
    //label - image -absolute image - label - [buttons]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(displayBird)
        displayBird.addSubview(topLabel)
        displayBird.addSubview(birdImage)
        birdImage.addSubview(pointImage)
        displayBird.addSubview(birdLabel)
        
        displayBird.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 100, height: 100)
    }
}
