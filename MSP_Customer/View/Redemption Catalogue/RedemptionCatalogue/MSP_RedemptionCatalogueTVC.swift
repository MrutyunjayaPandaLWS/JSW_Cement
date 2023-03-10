//
//  MSP_RedemptionCatalogueTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 25/11/2022.
//

import UIKit

protocol ViewTappedDelegate: NSObject{
    func didTapView(_ cell: MSP_RedemptionCatalogueTVC)
}
class MSP_RedemptionCatalogueTVC: UITableViewCell {
    
    @IBOutlet weak var productTypeLbl: UILabel!
    @IBOutlet weak var viewBtn: GradientView!
    
    @IBOutlet weak var viewLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    
    weak var delegate: ViewTappedDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        self.viewAndEditButton.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
        viewBtn.layer.cornerRadius = 16
        viewBtn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
    }
    
    @IBAction func viewBtn(_ sender: Any) {
        self.delegate.didTapView(self)
    }
}
