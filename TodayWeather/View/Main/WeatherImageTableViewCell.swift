//
//  WeatherImageTableViewCell.swift
//  TodayWeather
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class WeatherImageTableViewCell: BaseTableViewCell {

    static let identifier = "WeatherImageTableViewCell"
    
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var temperatureLabel: BaseLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    
}
