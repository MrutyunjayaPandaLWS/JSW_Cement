//
//  KC_DropDownTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/02/2023.
//

import UIKit

class SelectDealerDropDownTVC: UITableViewCell {

    @IBOutlet weak var selectedTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
