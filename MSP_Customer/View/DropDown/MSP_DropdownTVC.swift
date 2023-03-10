//
//  MSP_DropdownTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 26/11/2022.
//

import UIKit

class MSP_DropdownTVC: UITableViewCell {

    @IBOutlet weak var dropdownInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
