//
//  DueTimeJson.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation
import Alamofire

class DueTimeJson {
    
    let dueTimeURL: URL?
    
    init(stopid: String){
        dueTimeURL = URL(string: "https://data.dublinked.ie/cgi-bin/rtpi/realtimebusinformation?stopid=\(stopid)&format=json")
        print("SSSSSSSSSSS")
        print(stopid)
    }
    
    func getStopDueTime(completion: @escaping (NSArray?) -> Void) {
        if let url = dueTimeURL {
            Alamofire.request(url).responseJSON(completionHandler: { (response) in //1
                if let jsonDictionary = response.result.value as? [String : Any] {
                    if let dueTimeResults = jsonDictionary["results"] as? NSArray{
                        completion(dueTimeResults)
                        
                    } else {
                        completion(nil)
                    }
                    
                }
                
                
            })
        }
    }
}
