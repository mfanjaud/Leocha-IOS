//
//  MeetupViewController.swift
//  Leocha-IOS
//
//  Created by Marion FANJAUD on 25/03/2018.
//  Copyright © 2018 Marion FANJAUD. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MeetupViewController: UIViewController, CLLocationManagerDelegate {
    
    
     let MEETUP_URL = "http://api.openweathermap.org/data/2.5/weather"
     let APP_ID = "37ff185589205d45a216d543e76"
     let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
