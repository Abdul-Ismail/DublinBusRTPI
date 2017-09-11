//
//  DueTimeTableViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

struct stopDueTimeInformation {
    let busRoute: String?
    let dueTime: String?
}
var a = 0
class DueTimeTableViewController: UITableViewController {
    
    var checkBusStop: String = ""
    var dueTime: DueTimeJson!
    var stopDueTimeInformations: [stopDueTimeInformation] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none //disables the cell lines
        
        dueTime = DueTimeJson(stopid: checkBusStop)
        dueTime.getStopDueTime { (dueTimeNSArray) in
            if let dueTimeNSArray = dueTimeNSArray {
                              DispatchQueue.main.async {
            for stopDueTime in dueTimeNSArray {
                //print(dueTime)
                var dueTime = (stopDueTime as? NSDictionary)?["duetime"] as? String ?? ""
                var route = (stopDueTime as? NSDictionary)?["route"] as? String ?? ""
                self.stopDueTimeInformations.append(stopDueTimeInformation(busRoute: route, dueTime: dueTime))
                //print(route)
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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stopDueTimeInformations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dueCell", for: indexPath) as? DueTimeTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchCell.")
        }
        
        let dueTime = stopDueTimeInformations[indexPath.row].busRoute
        let route = stopDueTimeInformations[indexPath.row].dueTime

        cell.dueTime.text = dueTime
        cell.route.text = route
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
 

}
