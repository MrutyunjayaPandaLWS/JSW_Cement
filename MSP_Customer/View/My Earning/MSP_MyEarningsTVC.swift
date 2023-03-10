//
//  MSP_MyEarningsTVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 24/11/22.
//

import UIKit

class MSP_MyEarningsTVC: UITableViewCell {

    @IBOutlet var pointsLbl: UILabel!
    @IBOutlet var delaerNameLbl: UILabel!
    @IBOutlet var cancelLbl: UILabel!
    
    @IBOutlet var claimIDLbl: UILabel!
    
    //@IBOutlet var statusView: UIView!
    @IBOutlet var dateLbl: UILabel!
    
    @IBOutlet var quantityLbl: UILabel!
    @IBOutlet var productNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        super.awakeFromNib()
//        statusView.layer.cornerRadius = 16
//        statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
