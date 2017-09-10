//
//  FavouriteTableViewCell.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    @IBOutlet weak var busStopId: UILabel!
    @IBOutlet weak var busStopLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
