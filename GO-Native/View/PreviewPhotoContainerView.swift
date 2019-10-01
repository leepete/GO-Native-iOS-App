//
//  PreviewPhotoContainerView.swift
//  GO-Native
//
//  Created by Peter Lee on 25/09/19.
//  Copyright © 2019 Peter Lee. All rights reserved.
//

import UIKit

protocol SendImageControlDelegate {
    func didTapNext(_ viewController: UIViewController)
}

class PreviewPhotoContainerView: UIView {
    
    var delegate: SendImageControlDelegate?

    let previewImageView: UIImageView = {
        let iv = UIImageView()
        iv.restorationIdentifier = "f"
        return iv
    }()
    
    let cancelButton: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "exit_button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "next_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleSave() {
        let viewController = AddBirdController()
        self.delegate?.didTapNext(viewController)
    }
    
    @objc func handleCancel() {
        self.removeFromSuperview() // remove current view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewImageView)
        previewImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
        addSubview(cancelButton)
        cancelButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        
        addSubview(nextButton)
        nextButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 24, width: 50, height: 50)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
