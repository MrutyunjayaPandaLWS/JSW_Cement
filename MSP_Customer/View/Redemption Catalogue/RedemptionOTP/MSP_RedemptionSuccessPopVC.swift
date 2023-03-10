//
//  MSP_RedemptionSuccessPopVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 07/12/2022.
//

import UIKit

class MSP_RedemptionSuccessPopVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
                self.dismiss(animated: true){
                    NotificationCenter.default.post(name: .sendDashboard, object: nil)
                }
        
        
      // NotificationCenter.default.post(name: .sendDashboard, object: nil)
    }

}
