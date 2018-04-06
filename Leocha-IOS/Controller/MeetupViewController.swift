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
    
    
    //Constants

    
    
    //Declare instance variables here
    let locationManager = CLLocationManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    

    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    


    
    
    //MARK: - UI Updates
    /***************************************************************/
    

    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    

    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:

    
    //Write the PrepareForSegue Method here
    


}
    
    
    






