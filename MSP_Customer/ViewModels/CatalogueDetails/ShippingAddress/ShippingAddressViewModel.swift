//
//  ShippingAddressViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

//class ShippingAddressViewModel{
//
//    weak var VC: ShippingAddress_VC?
//    var requestAPIs = RestAPI_Requests()
//    var profilDetails = [LstCustomerJson]()
//
//
//    func myProifleDetails(parameters: JSON, completion: @escaping (MyProfileModels?) -> ()){
//        self.VC?.startLoading()
//        self.requestAPIs.myProfile(parameters: parameters) { (result, error) in
//            if error == nil{
//                if result != nil {
//                    DispatchQueue.main.async {
//                        completion(result)
//                    }
//                } else {
//                    print("No Response")
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_Login \(error)")
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//
//        }
//    }
//
//    }
//    
//
//}
