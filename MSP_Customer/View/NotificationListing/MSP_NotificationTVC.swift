//
//  MSP_NotificationTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 26/11/2022.
//

import UIKit

class MSP_NotificationTVC: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet var pushMessageLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
