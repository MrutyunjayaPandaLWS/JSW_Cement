//
//  MSP_ClaimPointsPopUpVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit

class MSP_ClaimPointsPopUpVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func okbtn(_ sender: Any) {
        self.dismiss(animated: true){
//            self.navigationController?.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: .goToDashBoardAPI, object: nil)
        }
    }
    
    @IBAction func claimStatusBtn(_ sender: Any) {
        //self.dismiss(animated: true){
//            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ClaimStatusVC") as! MSP_ClaimStatusVC
//            self.navigationController?.pushViewController(vc, animated: true)
        //}
        self.dismiss(animated: true){
            NotificationCenter.default.post(name: .sendToClaimStatusVC, object: nil)
        }
    }
}
