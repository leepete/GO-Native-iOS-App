//
//  AddABird.swift
//  GO-Native
//
//  Created by Peter Lee on 11/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

class AddABirdController: UIViewController {
    
    @IBOutlet weak var displayAddedImage: UIImageView!
    var imageView: UIImage!
    
    var navigationBarAppearance = UINavigationBar.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if imageView != nil {
            displayAddedImage.image = imageView
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
