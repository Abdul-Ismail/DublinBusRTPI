//
//  SearchTableViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 08/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

struct stopInformation {
    let stopId: String?
    let fullname: String?
}

class SearchTableViewController: UITableViewController {
    
    let busStopNumber = ["3237", "4568"]
    let busStopLocation = ["Sallynoggin Rd", "HoneyPark"]
    var passedStopInformation: StopInformation!
    var stopInformationJson: StopInformationJson!
    var busInformation: [stopInformation] = []

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
                        self.busInformation.append(stopInformation(stopId: stopId, fullname: fullname))
                    }
                    self.tableView.reloadData()
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print(passedStopInformation.stopInformations.count)
        //print(self.passedStopInformation.stopInformations.count)
        return busInformation.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchCell.")
        }
        
        //let stopId = self.passedStopInformation.stopInformations[indexPath.row].stopId
        //let fullname = self.passedStopInformation.stopInformations[indexPath.row].fullname
        let stopId = busInformation[indexPath.row].stopId
        let fullname = busInformation[indexPath.row].fullname
        cell.busStopNumber.text = stopId
        cell.busStopLocation.text = fullname

        return cell
    }
    
    //Animated the cell appearance when the user is scrolling
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //sets the initial alpha value for the cell
        cell.alpha = 0.6
        let  transform = CATransform3DTranslate(CATransform3DIdentity, -50, 20, 0)
        cell.layer.transform = transform
        
        //will change the alpha gradually
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity // will change to original state
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }


}
