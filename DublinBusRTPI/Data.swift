//
//  Data.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation
import MapKit

struct Data {
    static var favourite = [String]()
}

//pin annotation
class PinAnnotation : NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title : String, subtitle : String, coordinate : CLLocationCoordinate2D){
        
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}




