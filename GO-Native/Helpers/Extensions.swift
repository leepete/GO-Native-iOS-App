//
//  Extensions.swift
//  GO-Native
//
//  Created by Peter Lee on 19/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UINavigationController {
    // View controller-based status bar appearance now needs to be set to YES in info.plist
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

extension UIViewController {
    func setupAlertController() {
        let action = UIAlertController(title: "How would you like to add your bird?", message: "", preferredStyle: .actionSheet)
        action.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { action in self.useCamera()}))
        action.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in self.addFromCameraRoll()}))
        action.addAction(UIAlertAction(title: "Scan QR Code", style: .default, handler: { action in self.addFromQRCode()}))
        action.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(action, animated: true, completion: nil)
    }
    
    func useCamera() {
        let cameraController = CameraController()
        present(cameraController, animated: true, completion: nil)
    }
    
    func addFromCameraRoll() {
        
    }
    
    func addFromQRCode() {
        
    }
}
