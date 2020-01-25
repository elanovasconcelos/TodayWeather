//
//  UITableViewExtension.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

extension UITableView {
    func register(nibName: String, forCellReuseIdentifier: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func register(nibNameAndIdentifier: String) {
        register(nibName: nibNameAndIdentifier, forCellReuseIdentifier: nibNameAndIdentifier)
    }
}
