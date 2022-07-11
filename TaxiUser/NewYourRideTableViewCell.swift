//
//  NewYourRideTableViewCell.swift
//  TaxiUser
//
//  Created by AppOrio on 24/05/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class NewYourRideTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var normalfirstlocationview: UIView!
    
    @IBOutlet weak var normalsecondlocationview: UIView!
    
    @IBOutlet weak var rentallocationview: UIView!
    
    @IBOutlet weak var rentallocationtext: UILabel!
    
    @IBOutlet weak var normalredview: UIView!
    
    @IBOutlet weak var normalgreenview: UIView!
    
    @IBOutlet weak var rentalredview: UIView!
    
    @IBOutlet weak var normalimageview: UIView!
    
    @IBOutlet weak var rentalimageview: UIView!
    
    @IBOutlet weak var rentalmapimageview: UIImageView!

    
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var firstlocation: UILabel!
    
    @IBOutlet weak var secondlocation: UILabel!
    
    @IBOutlet weak var firstmapimageview: UIImageView!
    
    @IBOutlet weak var secondimageview: UIImageView!
    
    @IBOutlet weak var datelabel: UILabel!
    
    @IBOutlet weak var statuslabel: UILabel!
    
    @IBOutlet weak var pricelabel: UILabel!
    
    
    @IBOutlet weak var orangecolorview: UIView!
    
    
    @IBOutlet weak var carnamelabel: UILabel!
    @IBOutlet weak var driverimage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
