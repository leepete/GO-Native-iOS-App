//
//  BirdAddedController.swift
//  GO-Native
//
//  Created by Peter Lee on 12/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

class BirdAddedController: UIViewController {
    
    @IBOutlet weak var birdLabel: UILabel!
    
    var birdName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birdLabel.text = birdName
        
       self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
