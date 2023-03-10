//
//  OffersListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class OffersListViewModel{
    
    weak var VC: MSP_OffersandPromotionsVC?
    var requestAPIs = RestAPI_Requests()
    var offersandPromotionsArray = [LstPromotionJsonList]()

    
    func offersandPromotions(parameters: JSON, completion: @escaping (OffersandPromotionsVM?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
//              self.VC?.loaderView.isHidden = false
//              self.VC?.playAnimation()
         }

        self.requestAPIs.offersandPromotions(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }

        }
    }
    
    }
}
