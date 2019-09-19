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

class BaseViewController: UIViewController {
    
    private let backgroundImage : UIImageView = {
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        background.image = UIImage(named: "nature_background")
        background.contentMode = .scaleAspectFill
        background.restorationIdentifier = "background"; // tag this view
        return background
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImage)

        setupNavButtons()
    }
    
    func setupNavButtons() {
        //Nav Bar Buttons
        let progressBar = UIImage(named: "progressbar")?.withRenderingMode(.alwaysOriginal) //TODO: Make it a proper working one
        let progressBarButtonItem = UIBarButtonItem(image: progressBar, style:.plain, target: self, action: #selector(openUserProfile))
        
        navigationItem.leftBarButtonItem = progressBarButtonItem
        
        let treeImage = UIImage(named: "tree")?.withRenderingMode(.alwaysOriginal) // Rendering mode removes blue hue
        let treeBarButtonItem = UIBarButtonItem(image: treeImage, style: .plain, target: self, action: #selector(goHome))
        let plusImage = UIImage(named: "plus_button")?.withRenderingMode(.alwaysOriginal)
        let plusBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(addPhoto))
        
        navigationItem.rightBarButtonItems = [treeBarButtonItem, plusBarButtonItem].reversed()
    }
    
    @objc func goHome() {
        self.navigationController?.pushViewController(HomeController(), animated: true)
    }
    
    @objc func addPhoto() {
        print("ADDING QR CODE/PHOTO")
         self.navigationController?.pushViewController(AddBirdController(), animated: true) // TEMP
    }
    @objc func addPhotoAlert() { // TEMP
        print("ADDING QR CODE/PHOTO")
        self.setupAlertController()
    }
    
    @objc func openUserProfile() {
        print("OPENED USER INFO")
    }
    
}
