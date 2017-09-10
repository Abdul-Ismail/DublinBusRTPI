//
//  DueTimeTableViewCell.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class DueTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var route: UILabel!
    
    @IBOutlet weak var dueTime: UILabel!
    @IBOutlet weak var destination: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
