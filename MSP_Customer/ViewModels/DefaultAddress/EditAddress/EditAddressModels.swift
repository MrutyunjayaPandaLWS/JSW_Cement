//
//  File.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 12/12/22.
//

import Foundation

class EditAddressModels {
    weak var VC: MSP_EditAddressVC?
    var requestAPIs = RestAPI_Requests()
    var productsArray = [ObjCatalogueList]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    var notificationListArray = [LstPushHistoryJson]()
    
    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?) -> ()){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation()
        self.requestAPIs.myCartList(parameters: parameters) { (result, error) in
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
