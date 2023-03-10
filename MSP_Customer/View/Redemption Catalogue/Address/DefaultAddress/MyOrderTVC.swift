//
//  MyOrderTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 21/11/2022.
//

import UIKit

class MyOrderTVC: UITableViewCell {

    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var catagoryName: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
