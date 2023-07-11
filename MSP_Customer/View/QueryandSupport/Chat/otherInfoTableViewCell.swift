//
//  otherInfoTableViewCell.swift
//  demoCHAT
//
//  Created by Arokia-M3 on 06/01/21.
//

import UIKit

class otherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var customImage: UIView!
    @IBOutlet var itemcustomer: UILabel!
    @IBOutlet var itemTime: UILabel!
    @IBOutlet var itemText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
     
        customImage.cornerRadius = 15
        customImage.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner]
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
