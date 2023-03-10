//
//  File.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 06/12/22.
//

import Foundation
class PointStatemntModelCLassVM {
    weak var VC: MSP_PointStatementVC?
    var requestAPIs = RestAPI_Requests()
    var parameters = [String: Any]()
    var parameter: JSON?
    var myPointsStatementArray = [LstRewardTransJsonDetails1]()
    
    
    func pointStatementAPI(parameters: JSON, completion: @escaping (PointStatementModels?) -> ()) {
        DispatchQueue.main.async {
              self.VC?.startLoading()
//              self.VC?.loaderView.isHidden = false
//              self.VC?.playAnimation()
         }
        self.requestAPIs.pointStatementAPI(parameters: parameters) { (result, error) in
            if error == nil {
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
