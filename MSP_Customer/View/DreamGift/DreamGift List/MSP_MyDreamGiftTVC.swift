//
//  MSP_MyDreamGiftTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 21/11/2022.
//

import UIKit
protocol AddOrRemoveGiftDelegate{
    func redeemGift(_ cell: MSP_MyDreamGiftTVC)
    func removeGift(_ cell: MSP_MyDreamGiftTVC)
    func removeBtnData(_ cell: MSP_MyDreamGiftTVC)
}


class MSP_MyDreamGiftTVC: UITableViewCell {

    @IBOutlet weak var priceImage: UIImageView!
    @IBOutlet weak var priceImgLeadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var tdsvalue: UILabel!
        //@IBOutlet weak var dreamGiftTitle: UILabel!
  //  @IBOutlet weak var removeBTN: UIButton!
    @IBOutlet weak var giftName: UILabel!
        @IBOutlet weak var giftCreatedDate: UILabel!
        @IBOutlet weak var desiredDate: UILabel!
        @IBOutlet weak var progressView: UIProgressView!
        @IBOutlet weak var pointsRequired: UILabel!
        @IBOutlet weak var redeemButton: UIButton!
        @IBOutlet weak var progressViewLeadingConstraint: NSLayoutConstraint!
        @IBOutlet weak var percentageValue: UILabel!
    @IBOutlet weak var removeGiftBTN: UIButton!
    @IBOutlet var tdsPointsStack: UIStackView!
    @IBOutlet var tdsApplicablePointsStack: UIStackView!
    @IBOutlet var removeOutBtn: UIButton!
    //    @IBOutlet weak var createdDate: UILabel!
//    @IBOutlet weak var expiredDate: UILabel!
//    @IBOutlet weak var ptsRequired: UILabel!
        var delegate: AddOrRemoveGiftDelegate!

        override func awakeFromNib() {
            super.awakeFromNib()
            self.selectionStyle = .none
            //self.dreamGiftTitle.roundCorners(corners: [.bottomRight], radius: 20)
            progressView.layer.cornerRadius = 3.0
            self.priceImage.isHidden = true
            
            //self.tdsPointsStack.isHidden = true
            self.tdsApplicablePointsStack.isHidden = false
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        @IBAction func redeemBTN(_ sender: Any) {
            self.delegate.redeemGift(self)
        }
    @IBAction func removeGift(_ sender: Any) {
        self.delegate.removeGift(self)
    }
    
    @IBAction func removeActBtn(_ sender: Any) {
        self.delegate.removeBtnData(self)
    }
    
    }
