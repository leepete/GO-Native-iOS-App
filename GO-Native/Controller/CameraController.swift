//
//  CameraController.swift
//  GO-Native
//
//  Created by Peter Lee on 19/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit
import AVFoundation // import library for all audio/video capabilities

class CameraController: UIViewController {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "back_arrow.png"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupHUD()
    }
    
    @objc func handleCapturePhoto() {
        print("Capturing Photo")
    }
    
    @objc func handleDismiss() { //TODO: Make animation transition
        dismiss(animated: true, completion: nil)
    }
    
    
    private func setupHUD() {
        view.addSubview(dismissButton)
        
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12, bottom: nil, paddingBottom: 0, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 12, right: nil, paddingRight: 0, width: 20, height: 30)
        
        view.addSubview(capturePhotoButton)
        
        capturePhotoButton.anchor(top: nil, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 24, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 80, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        capturePhotoButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0) // Padding
    }
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        // Setup Inputs
        let captureDevice =  AVCaptureDevice.default(for: AVMediaType.video)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            if captureSession.canAddInput(input) {
                 captureSession.addInput(input)
            }
        } catch let err {
            print("Could not setup camera input:", err)
        }
        
        // Setup Outputs
        let output = AVCapturePhotoOutput()
        if captureSession.canAddOutput(output) {
          captureSession.addOutput(output)
        }
        
        // Setup Output Preview
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame // set to viewController frame
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning() // get actual camera output (what you physically see)
    }
}
