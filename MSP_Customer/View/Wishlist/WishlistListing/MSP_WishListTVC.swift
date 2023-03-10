//
//  MSP_WishListTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 22/11/2022.
//

import UIKit

protocol RedemptionPlannerDelegate{
    func removeProduct(_ cell: MSP_WishListTVC)
    func producDetails(_ cell: MSP_WishListTVC)
    func productRedeem(_ cell: MSP_WishListTVC)
}

class MSP_WishListTVC: UITableViewCell {

    @IBOutlet weak var productRedeemBTN: UIButton!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var desireDateHeadingLabel: UILabel!
    @IBOutlet var desireDateLabel: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet weak var productDetailsBTN: UIButton!
    @IBOutlet weak var removeProductBTN: UIButton!
    @IBOutlet weak var details: UIButton!
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var delegate: RedemptionPlannerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    @IBAction func detailsButton(_ sender: Any) {
        self.delegate.producDetails(self)
    }
    
    @IBAction func redeemButton(_ sender: Any) {
        if self.verifiedStatus != 1{
            
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
        }else{
            self.delegate.productRedeem(self)
        }
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.delegate.removeProduct(self)
    }
}
