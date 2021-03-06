//
//  LocationModel.swift
//  TodayWeather
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationModelDelegate: class {
    func locationModel(_ model: LocationModel, didChange location: Location)
}

final class LocationModel: NSObject {
    
    private let locationManager: CLLocationManager
    
    weak var delegate: LocationModelDelegate?
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    /// It starts trying to get a location. The location will return by the delegate just one time if possible.
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdateLocation() {
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        stopUpdateLocation()
        guard let coordinate = manager.location?.coordinate else { return }
        
        let location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
        delegate?.locationModel(self, didChange: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LocationModel] error: \(error.localizedDescription)")
        //TODO: show error to user
    }
}
