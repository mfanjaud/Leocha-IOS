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

class MeetupViewController: UITableViewController {
    
    var eventsArray = [Meetup]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Set up the location manager here.
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        parseJSON()
       

    }
    
    
    //MARK: - Networking
    /***************************************************************/

 
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func parseJSON() {
        let url = URL(string: "https://api.meetup.com/find/groups?photo-host=public&location=lyon&page=20&text=English&sig_id=250969086&sig=a3e509757d6ca5a8272f5c41b9bd5ed589961d24")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            if let array = json["companies"] as? [String] {
                self.eventsArray = array
            }
            
            print(self.eventsArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
        
    }

}






extension MeetupViewController {
    
    //MARK: - TableView DataSource Methods
    /***************************************************************/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.eventsArray[indexPath.row].eventName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.eventsArray.count
        
    }
    
}
    






