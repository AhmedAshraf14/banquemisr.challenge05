//
//  UIActivityIndicator+Ext.swift
//  banquemisr.challenge05
//
//  Created by Ahmed Ashraf on 04/10/2024.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {

    func setup(in view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.color = .rateOrange
        self.hidesWhenStopped = true
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.widthAnchor.constraint(equalToConstant: 50),
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func show() {
        self.isHidden = false
        self.startAnimating()
    }
    
    func hide() {
        self.stopAnimating()
        self.isHidden = true
    }
}
