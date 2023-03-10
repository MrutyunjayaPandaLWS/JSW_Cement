//
//  MyEarningsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class MyEarningsViewModel{

    weak var VC: MSP_MyEarningsVC?
    var requestAPIs = RestAPI_Requests()
    var myEarningListArray = [CustomerBasicInfoListJson1]()
    var myEarningListsArray = [CustomerBasicInfoListJson1]()
    
    func myEarningListAPi(parameters: JSON, completion: @escaping (MyEarningModels?) -> ()){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
               
            
                }
        self.requestAPIs.myEarningListApi(parameters: parameters) { (result, error) in
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
