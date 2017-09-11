//
//  SearchTableViewCell.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 08/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var stopNumberHeader: UILabel!
    @IBOutlet weak var favourite: UIButton!
    @IBOutlet weak var busStopNumber: UILabel!
    @IBOutlet weak var busStopLocation: UILabel!

    @IBOutlet weak var backgroundCellView: UIView!
    
    
    @IBAction func favourite_TouchUpInside(_ sender: Any) {
        if Data.favourite.contains(busStopNumber.text!) {
            var index = Data.favourite.index(of: busStopNumber.text!)
            Data.favourite.remove(at: index!)
                    favourite.tintColor = UIColor.black
        }else {
            Data.favourite.append(busStopNumber.text!)
                    favourite.tintColor = UIColor.red
        }
            
        
    }
    
    
    //responding to notification from FavouriteTableViewController for removing favroutie
    //action changes image back to unsaved stop
    @objc func add(notification: Notification) {
        guard var removedFavourite = notification.object as? String else {
            return print("Did not recieve a object in notification")
        }
        if busStopNumber.text == removedFavourite {
            favourite.tintColor = UIColor.black
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //notificaion from favouriteTableView
        NotificationCenter.default.addObserver(self, selector: #selector(add), name: NSNotification.Name.init("changeColorAsStopIsNoLongerFavourited"), object: nil)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
        favourite.setImage( UIImage.init(named: "favourite"), for: .normal)
        
        if (Data.favourite.contains(busStopNumber.text!)) {
                favourite.tintColor = UIColor.red
        }else {
                favourite.tintColor = UIColor.black
        }
        
        self.backgroundCellView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0) //content view is view of cell
        backgroundCellView.layer.cornerRadius = 4.0
        backgroundCellView.layer.masksToBounds = false //inorder to get the shadow
        //backgroundCellView.layer.shadowColor = CGColor.init(colorSpace: CGColorSpace, components: <#T##UnsafePointer<CGFloat>#>)
        backgroundCellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCellView.layer.shadowOpacity = 0.8
        
    }
    

}
