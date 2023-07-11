//
//  senderInfoImageTableViewCell.swift
//  demoCHAT
//
//  Created by Arokia-M3 on 06/01/21.
//

import UIKit

class senderInfoImageTableViewCell: UITableViewCell {

    @IBOutlet var customView: UIView!
    @IBOutlet var itemcustomer: UILabel!
    @IBOutlet var itemTime: UILabel!
    @IBOutlet var itemimage: UIImageView!
    @IBOutlet var itemtext: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        customView.cornerRadius = 15
        customView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
