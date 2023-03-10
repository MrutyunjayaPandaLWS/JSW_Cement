//
//  MSP_OfferandPromotionTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit
protocol PromotionDelegate: class{
    func moveToNext(_ cell: MSP_OfferandPromotionTVC)
}
class MSP_OfferandPromotionTVC: UITableViewCell {

    @IBOutlet weak var viewBtn: GradientButton!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    var delegate: PromotionDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func viewButton(_ sender: Any) {
        self.delegate.moveToNext(self)
    }
    
}
