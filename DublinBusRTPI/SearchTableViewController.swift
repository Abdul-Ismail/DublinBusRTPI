//
//  SearchTableViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 08/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let busStopNumber = ["3237", "4568", "3236", "450", "3237", "4568", "3236", "450", "3237", "4568", "3236", "450", "3237", "4568", "3236", "450"]
    let busStopLocation = ["Sallynoggin Rd", "HoneyPark", "Sallynoggin, Pearse Street", "Trinty college", "Sallynoggin Rd", "HoneyPark", "Sallynoggin, Pearse Street", "Trinty college", "Sallynoggin Rd", "HoneyPark", "Sallynoggin, Pearse Street", "Trinty college", "Sallynoggin Rd", "HoneyPark", "Sallynoggin, Pearse Street", "Trinty college"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()


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
        return busStopNumber.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchCell.")
        }
        
        let stopNumber = busStopNumber[indexPath.row]
        let stopLocation = busStopLocation[indexPath.row]
        
        cell.busStopNumber.text = stopNumber
        cell.busStopLocation.text = stopLocation

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
    


}
