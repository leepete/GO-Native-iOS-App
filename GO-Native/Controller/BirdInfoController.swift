//
//  BirdInfoController.swift
//  GO-Native
//
//  Created by Peter Lee on 19/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

class BirdInfoController: UIViewController {

    @IBOutlet weak var birdImageView: UIImageView!
    @IBOutlet weak var birdLabel: UILabel!
    @IBOutlet weak var birdLabelMaori: UILabel!
    @IBOutlet weak var birdTypeLabel: UILabel!
    @IBOutlet weak var birdTypeStatus: UILabel!
    
    @IBOutlet weak var birdDescriptionText: UILabel!
    
    var birdImage = UIImage()
    var birdName = String()
    var birdNameMaori = String()
    var birdType = String()
    var birdStatus = String()
    
    var birdDescription = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        birdImageView.image = birdImage
        birdImageView.layer.cornerRadius = birdImageView.frame.height / 2
        birdImageView.layer.borderWidth = 5.0
        birdImageView.layer.borderColor = UIColor.white.cgColor
        birdImageView.clipsToBounds = true
        
        birdLabel.text = birdName
        birdLabelMaori.text = birdNameMaori
        birdTypeLabel.text = birdType
        birdTypeStatus.text = birdStatus
        
        birdDescriptionText.text = birdDescription
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

