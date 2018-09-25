//
//  BirdCollectionTreeCollectionViewController.swift
//  GO-Native
//
//  Created by Peter Lee on 12/09/18.
//  Copyright © 2018 Peter Lee. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BirdCollectionTreeCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
