//
//  StopInformation.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation

//using optinal type because we have to take care of a case where its nill
struct busDataStruct {
    let stopId: String?
    let fullname: String?
    let longitude: String?
    let latitude: String?
}

var busData: [busDataStruct] = []

class StopInformation {
    
    //using optinal type because we have to take care of a case where its nill
    
    var counter = 0
    
    
    struct stopInformationKeys {
        static let stopid = "stopid"
        static let fullname = "fullname"
    }
    
    //passed from the parsed data from StopInformationJSon and I'm extracting the specific keys that I want from the string
    init(stopInformationDictionary: NSArray)
    {
        for stopInfo in stopInformationDictionary {
            if counter < 4728 {
            var stopIdExtracted = (stopInfo as? NSDictionary)?["stopid"] as? String ?? ""
            var fullnameExtracted = (stopInfo as? NSDictionary)?["fullname"] as? String ?? ""
            var latitudeExtracted = (stopInfo as? NSDictionary)?["latitude"] as? String ?? ""
            var longitudeExtracted = (stopInfo as? NSDictionary)?["longitude"] as? String ?? ""
            busData.append(busDataStruct(stopId: stopIdExtracted, fullname: fullnameExtracted, longitude: longitudeExtracted, latitude: latitudeExtracted))
                counter = counter + 1
            }
        }
    }

    
    /*
 {
     errorcode: "0",
     errormessage: "",
     numberofresults: 1,
     timestamp: "09/09/2017 18:27:21",
     results: [
         {
             stopid: "3237",
             displaystopid: "3237",
             shortname: "Sallynoggin Road",
             shortnamelocalized: "Bóthar an Naigín",
             fullname: "Sallynoggin Road",
             fullnamelocalized: "",
             latitude: "53.279135",
             longitude: "-6.137951944",
             lastupdated: "28/08/2017 08:47:44",
             operators: [
                 {
                     name: "bac",
                     routes: [
                         "111",
                         "7A",
                         "45A"
                         ]
                 }
         ]
     }
 ]
 }
 */
}
