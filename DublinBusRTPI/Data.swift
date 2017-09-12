//
//  Data.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import Foundation

struct Data {
    static var favourite = [String]()
}



struct busDataStruct {
    let stopId: String?
    let fullname: String?
}

var busData: [busDataStruct] = []
