//
//  LocationManager.swift
//  TheWeatherApp
//
//  Created by Mehul Parmar on 1/13/18.
//  Copyright © 2018 org. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private var currentLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    private var updateClosure: ((CLLocationCoordinate2D) -> ())? = nil
    
    func fetchCurrentLocation(update:@escaping (CLLocationCoordinate2D) -> ()) {
        if let currentLocation = currentLocation {
            update(currentLocation)
        } else {
            if CLLocationManager.authorizationStatus() != .denied {
                locationManager.startUpdatingLocation()
                updateClosure = update
            } else {
                update(kCLLocationCoordinate2DInvalid)
            }
        }
    }
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self;
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        currentLocation = locValue
        updateClosure?(locValue)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            updateClosure?(kCLLocationCoordinate2DInvalid)
        }
    }
}
