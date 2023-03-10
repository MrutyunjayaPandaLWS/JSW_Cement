//
//  PrivacyPolicyViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

protocol PrivacyPolicyDelegate: AnyObject {
    func acceptDidTap(_ vc: PrivacyPolicyViewController)
}

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet var privacyPolicyTV: UITextView!
    @IBOutlet weak var header: GradientButton!
    @IBOutlet weak var decline: GradientButton!
    @IBOutlet weak var accept: GradientButton!
    var delegate: PrivacyPolicyDelegate!
    var boolResult:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndConditions()
        privacyPolicyTV.textAlignment = .justified
    }
    func termsAndConditions(){
            self.header.setTitle("Privacy Policy", for: .normal)
            self.decline.setTitle("Decline", for: .normal)
            self.accept.setTitle("Accept", for: .normal)
            self.privacyPolicyTV.text = """
1. The points can be redeemed on some CenturyPly products (refer to the points table or ask CPIL representative for details). New products, if added, will be intimated.
             
2. Enrolling for this Program by submitting the duly filled and signed enrolment form to the Century Executive is mandatory and will be deemed as acceptance of these terms and conditions. The reward points accumulation shall start only after member registration into CenturyProClub.
                       
3. There is no upper limit on the accumulation of the reward points and the accumulation is correlated to the purchase of Century products.
             
4. Gifts under the Program cannot be exchanged with credit note or in cash. CPIL will not be responsible for respective product warranty/functionality. Warranty/guarantee will be as per the rules of the manufacturing company.
             
5. All types of cars/two-wheelers/vehicles (in case they are part of the gift items) are ex-showroom basis. Taxes, insurance, documentation charges or difference in showroom prices and other expenses for accessories will have to be borne by the member. The ex-showroom price is subject to a maximum of value equivalent of points. The decision regarding the quantum of reimbursement of ex-showroom price solely rests with CPIL.
             
6. The company may change, amend, alter, reduce or withdraw the Program at any time, without giving any reason or prior notice. In the event of withdrawal of the Program by the company, the members will have to mandatorily redeem the accumulated reward points within a period of 1 (one) year from the date of withdrawal of the Program and opt for a gift from the eligible gift options.
             
7. The company will not be liable for any loss or damage, whether direct or indirect, caused to members due to withdrawal or change in the Program.
             
8. CPIL would do best to deliver the same item as shown in the catalogue. However, in extreme cases, when the product is not available or the model has been withdrawn, the Company reserves the right to substitute the same with some other gift of equivalent value, at its sole discretion.
             
9. Gifts to be given may not be as per the exact pictures or models shown, but will be replaced by those in similar points range, available during the time of redemption.
             
10. Images of gifts shown in the Program document are only for representation purposes and the actual colour/brand/model of the same may vary in case of non-availability. The company’s decision in this regard shall be final and binding on the members and no dispute will be entertained in this regard.
             
11. The gift(s) will be delivered within 30 working days from the date of approval. However, the company will not be responsible for delay in delivery of gift due to non-availability of stock or for any other reason beyond its control.
             
12. CPIL reserves the right to change points mentioned against each item at any point of time of the scheme. For example, CPIL may decide to increase the points for any item if price for the item increases. However CPIL will not decrease the points in case the price for the item decreases.
             
13. In case of any conflict or illegitimate claims, the company’s decision will be final and binding. All disputes related to the same will be resolved through arbitration as per the jurisdiction of Kolkata courts.
             
14. Scan of material in the dealer location to be invalid.
             
15. Special priced product to be ineligible for Proclub banking.
             
I agree to receive SMSs, emails, phone calls or Whatsapp messages, related to the  program, or related to Century Plyboards (India) Ltd., from time-to-time.
"""
        
    }
    
    @IBAction func declineButton(_ sender: Any) {
        self.boolResult = false
        self.delegate?.acceptDidTap(self)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MSP_LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    @IBAction func acceptButton(_ sender: Any) {
        self.boolResult = true
        self.delegate?.acceptDidTap(self)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MSP_LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

}
