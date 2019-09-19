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
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func setupHUD() {
        view.addSubview(dismissButton)
        dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(capturePhotoButton)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        capturePhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        capturePhotoButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0) // Padding
        capturePhotoButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        capturePhotoButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
