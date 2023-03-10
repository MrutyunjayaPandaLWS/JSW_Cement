//
//  MSP_ClaimStatusTVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 24/11/22.
//

import UIKit

class MSP_ClaimStatusTVC: UITableViewCell {
    @IBOutlet var productNameLbl: UILabel!
    @IBOutlet var dealerNameLbl: UILabel!
    @IBOutlet var quantityLbl: UILabel!
    @IBOutlet var claimsIDLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var remarksLbl: UILabel!
    @IBOutlet var claimsStatus: UILabel!
    
    @IBOutlet var claimStatusView: UIView!
    @IBOutlet weak var claimRemarksLbl: UILabel!
    @IBOutlet var DealerCodeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        claimStatusView.layer.cornerRadius = 16
        claimStatusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
