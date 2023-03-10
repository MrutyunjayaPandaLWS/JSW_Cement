//
//  MSP_PopVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 19/11/2022.
//

import UIKit

class MSP_PopVC: BaseViewController {

    @IBOutlet weak var mainView: GradientView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.mainView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
