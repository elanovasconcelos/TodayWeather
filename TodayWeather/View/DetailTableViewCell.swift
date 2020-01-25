//
//  DetailTableViewCell.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {

    static let identifier = "DetailTableViewCell"
    
    @IBOutlet var nameLabel: BaseLabel!
    @IBOutlet var informationLabel: BaseLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
