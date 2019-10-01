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
        action.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { action in self.useCamera()}))
        action.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in self.addFromCameraRoll()}))
        action.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(action, animated: true, completion: nil)
    }
    
    func useCamera() {
        let cameraController = CameraController()
        cameraController.modalPresentationStyle = .fullScreen
        present(cameraController, animated: true, completion: nil)
    }
    
    func addFromCameraRoll() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat,
                paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {

        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(x: NSLayoutXAxisAnchor?, paddingX: CGFloat, y: NSLayoutYAxisAnchor?, paddingY: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = x {
            centerXAnchor.constraint(equalTo: centerX, constant: paddingX).isActive = true
        }
        if let centerY = y {
            centerYAnchor.constraint(equalTo: centerY, constant: paddingY).isActive = true
        }
    }
}
