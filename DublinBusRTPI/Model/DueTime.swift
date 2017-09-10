//
//  DueTime.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation

class DueTime {
    
    struct stopDueTimeInformation {
        let busRoute: String?
        let dueTime: String?
    }
    
    struct stopInformationKeys {
        static let duetime = "duetime"
        static let route = "route"
    }
    
    var stopDueTimeInformations: [stopDueTimeInformation] = []
    
    
    init(dueTimeDictionary: NSArray) {
        for dueTimes in dueTimeDictionary {
            var dueTime = (dueTimes as? NSDictionary)?["stopid"] as? String ?? ""
            var route = (dueTimes as? NSDictionary)?["route"] as? String ?? ""
            stopDueTimeInformations.append(stopDueTimeInformation(busRoute: route, dueTime: dueTime))
        }
    }
    
}
