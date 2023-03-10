//
//  MSP_LodgeQueryTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 23/11/2022.
//

import UIKit

class MSP_LodgeQueryTVC: UITableViewCell {

    @IBOutlet weak var queryRefLbl: UILabel!
    
    @IBOutlet weak var queryStatusLbl: UILabel!
    
    @IBOutlet weak var queryTypeLbl: UILabel!
    @IBOutlet weak var queryInfo: UILabel!
    
    @IBOutlet weak var queryDate: UILabel!
    
    @IBOutlet weak var queryTimeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
