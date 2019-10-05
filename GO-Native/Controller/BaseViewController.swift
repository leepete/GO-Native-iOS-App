//
//  BaseViewController.swift
//  GO-Native
//
//  Most controllers will inherit from this Controller
//
//  Created by Peter Lee on 19/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController{
    
    private let backgroundImage : UIImageView = {
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.image = UIImage(named: "nature_background")
        background.contentMode = .scaleAspectFill
        background.restorationIdentifier = "background"; // tag this view
        return background
    }()
    
    // Encases the barbutton
    private let userProgress: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(openUserProfile), for: .touchUpInside)
        return button
    }()
    
    private let levelBar: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "progressbar")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 10)
        label.text = "Level 2: Bird Watcher"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)
        userProgress.addSubview(levelBar)
        userProgress.addSubview(levelLabel)
        levelBar.addSubview(levelLabel)
        levelBar.anchor(top: userProgress.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        levelLabel.anchor(top: levelBar.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupNavButtons()
    }
    
    func setupNavButtons() {
        //Nav Bar Buttons
        //TODO: Make it a proper working one
        let progressBarButtonItem = UIBarButtonItem()
        progressBarButtonItem.customView = userProgress
        userProgress.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUserProfile)))
      
        navigationItem.leftBarButtonItem = progressBarButtonItem
        
        let treeImage = UIImage(named: "tree")?.withRenderingMode(.alwaysOriginal) // Rendering mode removes blue hue
        let treeBarButtonItem = UIBarButtonItem(image: treeImage, style: .plain, target: self, action: #selector(goHome))
        let plusImage = UIImage(named: "plus_button")?.withRenderingMode(.alwaysOriginal)
        let plusBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(addPhoto))
        
        navigationItem.rightBarButtonItems = [treeBarButtonItem, plusBarButtonItem].reversed()
    }
    
    @objc func goHome() {
        self.navigationController?.pushViewController(HomeController(), animated: false)
    }
    
    @objc func addPhoto() {
        print("Opening Camera")
        self.useCamera()
    }
    
    @objc func openUserProfile() {
        print("OPENED USER INFO")
    }
    
}
