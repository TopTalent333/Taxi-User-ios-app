//
//  NotficationTableViewCell.swift
//  Apporio Taxi
//
//  Created by AppOrio on 04/09/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class NotficationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageviewheight: NSLayoutConstraint!
    
    @IBOutlet weak var headinglabel: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var labeltext: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
