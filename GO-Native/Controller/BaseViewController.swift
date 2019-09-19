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
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.setupAlertController()

//                present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
    @objc func openUserProfile() {
        print("OPENED USER INFO")
    }
    
}
