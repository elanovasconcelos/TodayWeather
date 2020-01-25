//
//  UIViewExtension.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func anchor(top: NSLayoutYAxisAnchor,
                leading:NSLayoutXAxisAnchor,
                bottom: NSLayoutYAxisAnchor,
                trailing: NSLayoutXAxisAnchor,
                padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
    }
}
