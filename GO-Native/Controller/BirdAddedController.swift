//
//  BirdAddedController.swift
//  GO-Native
//
//  Created by Peter Lee on 21/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class BirdAddedController: BaseViewController {
        
    var birdInstance: Bird? {
        didSet{
            if let imageName = birdInstance?.name {
                birdImage.image = UIImage(named: imageName.lowercased())
            }
                
            if let birdName = birdInstance?.name {
                let mutableAttributedString = NSMutableAttributedString()
                let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32)]
                let italicAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 20)]
                
                let boldAttributedString = NSAttributedString(string: birdName, attributes: boldAttribute)
                mutableAttributedString.append(boldAttributedString)
                
                // Check if this optional (maori name) is empty or not
                if let name = birdInstance?.details {
                    guard let maori = name.maoriName, !maori.isEmpty else { // if string is empty
                        bottomLabel.attributedText = mutableAttributedString
                        return
                    }
                    let italicAttributedString = NSAttributedString(string: maori, attributes: italicAttribute)
                
                    mutableAttributedString.append(NSAttributedString(string: "\n"))
                    mutableAttributedString.append(italicAttributedString)
                    
                    bottomLabel.attributedText = mutableAttributedString
                }
            }
        }
    }
        
    private let topLabel: UILabel = {
        let label = UILabel()
        let mutable = NSMutableAttributedString()
        let boldHeader = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        let boldSubheader = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        let headerString = NSAttributedString(string: "Hooray!", attributes: boldHeader)
        let subheaderString = NSAttributedString(string: "You collected a...", attributes: boldSubheader)
            
        mutable.append(headerString)
        mutable.append(NSAttributedString(string: "\n"))
        mutable.append(subheaderString)
        
        label.attributedText = mutable
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
        
    private let birdImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.sizeToFit()
        let layer = imageView.layer
        layer.cornerRadius = UIScreen.main.bounds.width / 4
        layer.borderWidth = 7.0
        layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
        
    private let pointImage: UIImageView = {
        let image = UIImage(named: "points")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let displayBird: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = UIColor.rgb(red: 239, green: 239, blue: 239)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let learnMoreButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "learn_more_button")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let seeTreeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "see_my_tree_button")
        button.setImage(image, for: .normal)
        return button
    }()
    
    @objc func learnMore() {
        print("Going into more INFO")
        let nextViewController = BirdInfoController()
        nextViewController.getBird = birdInstance // then send this Bird object to the next view controller so it can use it
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bird Added"
        
        setupLayout()
        
        learnMoreButton.addTarget(self, action: #selector(learnMore), for: .touchUpInside)
        seeTreeButton.addTarget(self, action: #selector(goHome), for: .touchUpInside)
    }
    
    private func setupLayout() {
        let width = displayBird.frame.width
        let height = (displayBird.frame.height/2) + 40
        view.addSubview(displayBird) // to hold everything
        
        displayBird.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: width, height: height)
                
        displayBird.addSubview(topLabel)
        displayBird.addSubview(birdImage)
        displayBird.addSubview(pointImage)
        displayBird.addSubview(bottomLabel)
        
        let labelHeight = height/3.5 // About 28% of the height each side
        topLabel.anchor(top: displayBird.topAnchor, left: displayBird.leftAnchor, bottom: nil, right: displayBird.rightAnchor, paddingTop: labelHeight/4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        topLabel.center(x: displayBird.centerXAnchor, paddingX: 0, y: nil, paddingY: 0)

        birdImage.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: width/2, height: width/2)
        birdImage.center(x: displayBird.centerXAnchor, paddingX: 0, y: displayBird.centerYAnchor, paddingY: -10)

        pointImage.anchor(top: nil, left: nil, bottom: birdImage.bottomAnchor, right: birdImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)

        bottomLabel.anchor(top: nil, left: displayBird.leftAnchor, bottom: displayBird.bottomAnchor, right: displayBird.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: labelHeight/4, paddingRight: 0, width: 0, height: 0)
    
        
        // Buttons
        let stackedButtons = UIStackView(arrangedSubviews: [learnMoreButton, seeTreeButton])
        stackedButtons.axis = .vertical
        stackedButtons.distribution = .fillEqually
        stackedButtons.spacing = -40
        stackedButtons.backgroundColor = .purple

        view.addSubview(stackedButtons)

        stackedButtons.anchor(top: displayBird.bottomAnchor, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        stackedButtons.center(x: view.centerXAnchor, paddingX: 0, y: nil, paddingY: 0)
 
    }
}
