//
//  FavouriteTableViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class FavouriteTableViewController: UITableViewController {

    var pressedBusStop = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Data.favourite)
        
        
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFavouriteTableView"), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable) , name: NSNotification.Name(rawValue:"reloadFavouriteTableView"), object: nil)

    }
    
//    func reloadTable() {
//        print("IM IN")
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Data.favourite.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as? FavouriteTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchCell.")
        }
            let stopId = Data.favourite[indexPath.row]
            cell.busStopId.text = stopId
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pressedBusStop = Data.favourite[indexPath.row]
        performSegue(withIdentifier: "FavouriteToDueTime", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DueTimeTableViewController = segue.destination as! DueTimeTableViewController
        DueTimeTableViewController.checkBusStop = pressedBusStop
    }
    
    //makes a cell deletable and then removes it from favourited arrau and calls notification to changes it color
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            var removedFavourite = Data.favourite[indexPath.row]
            Data.favourite.remove(at: indexPath.row)
            self.tableView.reloadData()
            
             NotificationCenter.default.post(name:     NSNotification.Name.init("changeColorAsStopIsNoLongerFavourited"), object: removedFavourite)

        }
    }

}
