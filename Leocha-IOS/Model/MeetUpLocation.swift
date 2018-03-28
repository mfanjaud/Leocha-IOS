//
//  MeetUpLocation.swift
//  Leocha-IOS
//
//  Created by Marion FANJAUD on 27/03/2018.
//  Copyright © 2018 Marion FANJAUD. All rights reserved.
//

import Foundation
import CoreLocation

class MeetUpLocation {
    
    var locationManager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D?
    
    init() {
        coordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)! )
    }
    
}
