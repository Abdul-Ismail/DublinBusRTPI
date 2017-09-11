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

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var passedStopInformation: StopInformation!
    var stopInformationJson: StopInformationJson!
    var busInformation: [stopInformation] = []
    var filteredBusInformation: [stopInformation] = []
    var pressedBusStop = ""

    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
      
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none //disables the cell lines
        
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
        if isSearching  {
            return filteredBusInformation.count
        }else {
           return busInformation.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchCell.")
        }
        
        let stopId: String
        let fullname: String
        if isSearching {
            stopId = filteredBusInformation[indexPath.row].stopId!
            fullname = filteredBusInformation[indexPath.row].fullname!
        }else {
            stopId = busInformation[indexPath.row].stopId!
            fullname = busInformation[indexPath.row].fullname!
        }

        
        cell.busStopNumber.text = stopId
        cell.busStopLocation.text = fullname
        
        return cell
    }
    
    //Animated the cell appearance when the user is scrolling
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //sets the initial alpha value for the cell
        cell.alpha = 0.6
        //let  transform = CATransform3DTranslate(CATransform3DIdentity, -50, 20, 0)
        //cell.layer.transform = transform
        
        //will change the alpha gradually
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1
           /// cell.layer.transform = CATransform3DIdentity // will change to original state
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            pressedBusStop = filteredBusInformation[indexPath.row].stopId!
        }else {
            pressedBusStop = busInformation[indexPath.row].stopId!
        }
        performSegue(withIdentifier: "clickedRow_Segue", sender: self)
    }
    
    //this function is run before we perform the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DueTimeTableViewController = segue.destination as! DueTimeTableViewController
        DueTimeTableViewController.checkBusStop = pressedBusStop
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            isSearching = false
            view.endEditing(true)
            self.tableView.reloadData()
            
        }else {
            isSearching = true
            filteredBusInformation.removeAll()
            for i in 0..<busInformation.count {
                var currentStopId = busInformation[i].stopId
                //var
                var keyword = searchBar.text!
                if currentStopId?.range(of:keyword) != nil {
                    filteredBusInformation.append(busInformation[i])
                }
            }
                self.tableView.reloadData()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    
 


}
