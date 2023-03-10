//
//  MyCart_TVC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 14/03/22.
//

import UIKit
protocol MyCartDelegate{
    
    func increaseCount(_ cell: MyCart_TVC)
    func decreaseCount(_ cell: MyCart_TVC)
    func removeProduct(_ cell: MyCart_TVC)
}

class MyCart_TVC: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var catagoryName: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var countTF: UITextField!
    @IBOutlet weak var minusBTN: UIButton!
    @IBOutlet weak var plusBTN: UIButton!
    @IBOutlet weak var removeProductBTN: UIView!
    
    var delegate: MyCartDelegate!
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.countTF.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func plusButton(_ sender: Any) {
        if self.verifiedStatus != 1{
            if self.checkAccountStatus == "1"{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }else{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }
            
        }else{
        self.delegate.increaseCount(self)
        }
    }
    @IBAction func minusButton(_ sender: Any) {
            self.delegate.decreaseCount(self)
        
    }
    @IBAction func removeBTN(_ sender: Any) {
        self.delegate.removeProduct(self)
    }
    @IBAction func detailsBtn(_ sender: Any) {
    }
}
