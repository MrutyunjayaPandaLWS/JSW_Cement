//
//  MSP_ClaimPointsTVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit
protocol SendDetailsDelegate1: NSObject{
    func qtyValue(_ cell: MSP_ClaimPointsDetailsTVC)
    func remarksValue(_ cell: MSP_ClaimPointsDetailsTVC)
    func qtyKgValue(_ cell: MSP_ClaimPointsDetailsTVC)
}
class MSP_ClaimPointsDetailsTVC: UITableViewCell, UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var remarksTF: UITextField!
    @IBOutlet weak var productNameTitle: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var qtyTF: UITextField!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet var qtyKGTF: UITextField!
    
    weak var delegate: SendDetailsDelegate1!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.qtyTF.delegate = self
       // self.remarksTF.delegate = self
        self.qtyTF.setLeftPaddingPoints(12)
        self.qtyKGTF.setLeftPaddingPoints(12)
        self.remarksTF.setLeftPaddingPoints(12)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func enteredQTYEditingDidEnd(_ sender: Any) {
        self.delegate.qtyValue(self)
    }
    
    @IBAction func enterRemarksEditingDidEnd(_ sender: Any) {
        self.delegate.remarksValue(self)
    }
    
    @IBAction func qtyActKGTF(_ sender: Any) {
        self.delegate.qtyKgValue(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let maxLength = 1212121212
        let currentString: NSString = (qtyTF.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
