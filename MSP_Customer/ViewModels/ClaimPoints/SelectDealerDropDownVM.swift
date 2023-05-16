//
//  SelectDealerDropDownnVM.swift
//  MSP_Customer
//
//  Created by admin on 15/05/23.
//

import Foundation

class SelectDealerDropDownVM{
    
    var myClaimsPointsDelarArray = [LstAttributesDetails]()
    var myClaimsPointsDelarArray1 = [LstAttributesDetails]()
    weak var VC: SelectDealerDropDownVC?
    var requestAPIs = RestAPI_Requests()
    
    func claimPointsDelarAPI(parameters: JSON, completion: @escaping (DealerListModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
         }
        self.requestAPIs.claimPointsDelarAPI(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }
}
