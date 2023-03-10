//
//  SideMenuTableViewCell.swift
//  MSP
//
//  Created by admin on 21/11/22.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var viewGradient: GradientView!
    
    @IBOutlet var sideMenuDataLbl: UILabel!
    @IBOutlet var sideMenuImage: UIImageView!
    @IBOutlet var leadingConstrain: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
