//
//  MSP_MySummaryTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit

class MSP_MySummaryTVC: UITableViewCell {

    @IBOutlet weak var approvedQtyLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    
    @IBOutlet weak var volumeClaimed: UILabel!
    
    @IBOutlet weak var rejectedQty: UILabel!
    
    @IBOutlet weak var pendingQty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
