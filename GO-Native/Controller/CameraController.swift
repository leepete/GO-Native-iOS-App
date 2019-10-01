//
//  CameraController.swift
//  GO-Native
//
//  Created by Peter Lee on 19/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit
import AVFoundation // import library for all audio/video capabilities

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate, SendImageControlDelegate {
    
    let output = AVCapturePhotoOutput()
    var sendImage = UIImage() // Store the image taken
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "back_arrow.png"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupHUD()
    }
    
    func didTapNext(_ viewController: UIViewController) {
        let nextViewController = AddBirdController()
        nextViewController.receivedImage = sendImage // Segue image to next VC
        
        let navController = UINavigationController(rootViewController: nextViewController) //Embed with Navigation Controller
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupHUD() {
        view.addSubview(dismissButton)
        
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 20, height: 30)
        
        view.addSubview(capturePhotoButton)
        
        capturePhotoButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 80, height: 80)
        
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        capturePhotoButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0) // Padding
    }
    
    @objc func handleCapturePhoto() {
        print("Capturing photo..")
        
        let settings = AVCapturePhotoSettings()
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let imageData = photo.fileDataRepresentation()
        let previewImage = UIImage(data: imageData!)
        
        let containerView = PreviewPhotoContainerView()
        containerView.delegate = self
        containerView.previewImageView.image = previewImage
        sendImage = previewImage! // store image

        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        print("Finish processing photo sample buffer...")
    }
    
    fileprivate func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        // Setup Inputs
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            if captureSession.canAddInput(input) {
                 captureSession.addInput(input)
            }
        } catch let err {
            print("Could not setup camera input:", err)
        }
        
        // Setup Outputs
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
