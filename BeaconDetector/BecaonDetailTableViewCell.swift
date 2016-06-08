//
//  BecaonDetailTableViewCell.swift
//  BeaconDetector
//
//  Created by Ashish on 08/06/16.
//  Copyright © 2016 Laxman. All rights reserved.
//

import UIKit

class BecaonDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var beaconProximatyLabel: UILabel!
    @IBOutlet weak var beaconMajorLabel: UILabel!
    @IBOutlet weak var beaconMinorLabel: UILabel!
    @IBOutlet weak var beaconUUIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
