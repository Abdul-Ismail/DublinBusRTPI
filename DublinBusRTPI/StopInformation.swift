//
//  StopInformation.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation

//modelling our current model

class StopInformation {
    
    //using optinal type because we have to take care of a case where its nill
    struct stopInformation {
    let stopId: String?
    let fullname: String?
    }
    
    var counter = 0
    var stopInformations: [stopInformation] = []
    
    
    
    struct stopInformationKeys {
        static let stopid = "stopid"
        static let fullname = "fullname"
    }
    
    
    init(stopInformationDictionary: NSArray)
    {
        for stopInfo in stopInformationDictionary {
            if counter < 4728 {
            var stopIdExtracted = (stopInfo as? NSDictionary)?["stopid"] as? String ?? ""
            var fullnameExtracted = (stopInfo as? NSDictionary)?["fullname"] as? String ?? ""
            stopInformations.append(stopInformation(stopId: stopIdExtracted, fullname: fullnameExtracted))
                counter = counter + 1
            }
        }
        //print(stopInformations)
    }
        
        
//        for stopInfo in stopInformationDictionary {
////print(stopInfo)
//           // var b = (stopInfo["stopid"]
//            //print(type(of: stopInfo))
//            }
//        }
    
    
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
