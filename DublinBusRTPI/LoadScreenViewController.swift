//
//  LoadScreenViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 12/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class LoadScreenViewController: UIViewController {
    
    var passedStopInformation: StopInformation!
    var stopInformationJson: StopInformationJson!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://data.dublinked.ie/cgi-bin/rtpi/busstopinformation?stopid&format=json")
        
        stopInformationJson = StopInformationJson(url: url!)
        stopInformationJson.getStopInformation { (stopInfo) in
            if let passedStopInformation = stopInfo {
                DispatchQueue.main.async {
                    for i in 0..<passedStopInformation.stopInformations.count {
                        var stopId = passedStopInformation.stopInformations[i].stopId
                        var fullname = passedStopInformation.stopInformations[i].fullname
                        busData.append(busDataStruct(stopId: stopId, fullname: fullname))
                    }
                        self.performSegue(withIdentifier: "loadingDone_Segue", sender: self)
                    
                }
            }
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
