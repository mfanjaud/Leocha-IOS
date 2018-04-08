//
//  MeetUpService.swift
//  Leocha-IOS
//
//  Created by Marion FANJAUD on 27/03/2018.
//  Copyright © 2018 Marion FANJAUD. All rights reserved.
//

import Foundation

typealias JSONDictionary = Dictionary<String,Any>

class MeetupService {
    
    let MeetupApiKey = "37ff185589205d45a216d543e76"
    var baseUrl: String = "https://api.meetup.com/"
    lazy var session: URLSession = URLSession.shared
    
    func fetchMeetupGroupInLocation(latitude: Double, longitude: Double, completion: @escaping (_ results: [JSONDictionary]?, _ error: Error?) -> ()) {
        guard let url = URL(string: "\(baseUrl)find/groups?&lat=\(latitude)&lon=\(longitude)&page=10&key=\(MeetupApiKey)") else {
            fatalError()
        }
        
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                do {
                    let results = try JSONSerialization.jsonObject(with: data!) as? [JSONDictionary]
                    completion(results, nil);
                    
                } catch let underlyingError {
                    completion(nil, underlyingError);
                }
            })
            }.resume()
    }
}
