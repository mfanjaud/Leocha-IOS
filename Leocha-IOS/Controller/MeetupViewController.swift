//
//  MeetupViewController.swift
//  Leocha-IOS
//
//  Created by Marion FANJAUD on 25/03/2018.
//  Copyright © 2018 Marion FANJAUD. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class MeetupViewController: UITableViewController {
    
    var events = [[String: String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let urlString = "https://api.meetup.com/2/events?key=37ff185589205d45a216d543e76&group_urlname=lyontalks&sign=true"
        
        if let url = URL(string: urlString) {
            if let data = try? String(contentsOf: url){
                let json = JSON(parseJSON: data)
                if json["results"] != JSON.null {
                    print("Get data")
                    parse(json: json)
                    print(events)
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Parsing JSON
    /***************************************************************/
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["name"].stringValue
            let time = result["time"].stringValue
            let venue = result["venue"]["name"].stringValue
            let detail = result["description"].stringValue
            let eventUrl = result["event_url"].stringValue
            let participantCount = result["yes_rsvp_count"].stringValue
            let obj = ["title": title, "time": time, "detail": detail , "venue": venue, "event URL" : eventUrl, "participation" : participantCount]
            events.append(obj)
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - TableView DataSource Methods
    /***************************************************************/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let events = self.events[indexPath.row]
        cell.textLabel?.text = events["title"]
        cell.detailTextLabel?.text = events["venue"]
        return cell
    }
    
    
    
    //MARK: - TableView Delegate Methods
    /***************************************************************/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let events = self.events[indexPath.row]
        let urlEvents = events["event URL"]
        if let url = URL(string: urlEvents!) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    
}


    






