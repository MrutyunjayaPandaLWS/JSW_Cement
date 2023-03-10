//
//  LodgeListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class LodgeListViewModel{
    
    weak var VC: MSP_LodgeQueryVC?
    var requestAPIs = RestAPI_Requests()
    var queryListingArray = [ObjCustomerAllQueryJsonList]()
    
    var queryListsArray = [ObjCustomerAllQueryJsonList]()
    
    
    func queryListingApi(parameters: JSON, completion: @escaping (QueryListingModels?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
//            self.VC?.loaderView.isHidden = false
//            self.VC?.playAnimation()
        }
        self.requestAPIs.queryListingApi(parameters: parameters) { (result, error) in
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
