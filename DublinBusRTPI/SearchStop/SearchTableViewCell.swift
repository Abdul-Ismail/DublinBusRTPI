//
//  SearchTableViewCell.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 08/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var favourite: UIButton!
    @IBOutlet weak var busStopNumber: UILabel!
    @IBOutlet weak var busStopLocation: UILabel!

    
    @IBAction func favourite_TouchUpInside(_ sender: Any) {
        if Data.favourite.contains(busStopNumber.text!) {
            var index = Data.favourite.index(of: busStopNumber.text!)
            Data.favourite.remove(at: index!)
                    favourite.tintColor = UIColor.black
        }else {
            Data.favourite.append(busStopNumber.text!)
                    favourite.tintColor = UIColor.red
        }
        print(Data.favourite)
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFavouriteTableView"), object: nil)
            
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()

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
    }

}
