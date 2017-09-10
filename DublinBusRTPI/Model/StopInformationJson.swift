//
//  StopInformationJson.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation
import Alamofire

class StopInformationJson {
    
    let stopInformationURL: URL?
    
    init(url: URL){
        stopInformationURL = url
    }
    
    func getStopInformation(completion: @escaping (StopInformation?) -> Void) {
        if let url = stopInformationURL {
            Alamofire.request(url).responseJSON(completionHandler: { (response) in //1
                if let jsonDictionary = response.result.value as? [String : Any] {
                    if let resultStopInformationDictionary = jsonDictionary["results"] as? NSArray{
                        let stopInformation = StopInformation(stopInformationDictionary: resultStopInformationDictionary)
                        completion(stopInformation)
                        
                    } else {
                        completion(nil)
                    }

                }

                
            })
        }
    }
}

/* *** 1 ***
 inside here is a closure, it is a function you can pass around like a variable
 this request will go to download the data, the process of downloading the data
 takes some time to download, it will get off the main que to download the data
 and after the data is collected it will then call this closure. This way it does
 not interfer with the UI and will reduce any lag
 */
