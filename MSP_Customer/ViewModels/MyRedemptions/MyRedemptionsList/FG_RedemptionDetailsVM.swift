//
//  FG_RedemptionDetailsVM.swift
//  Fleet_Guard(Samriddhi)
//
//  Created by admin on 14/04/23.
//

import Foundation
import UIKit
import Kingfisher

class FG_RedemptionDetailsVM{
    weak var VC: FG_MyRedemptionDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var redemptionDetails = [RedemptionCatalogueList]()
    var orderStatusArrayList = [RedemptionDetailsOrderStatus]()
    
//    MARK: - REDEMPTION DETAILS API
    func redemptionDetailsApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        requestAPIs.redemptionDetailsApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.redemptionDetails = result?.objCatalogueList ?? []
                    if self.redemptionDetails.count != 0{
                        DispatchQueue.main.async {
                            self.VC?.categoryNameLbl.text = "Category : \(self.redemptionDetails[0].catogoryName ?? "_")"
                            self.VC?.productName.text = "\(self.redemptionDetails[0].productName ?? "__")"
                            self.VC?.redemptionRefno.text = "\(self.redemptionDetails[0].redemptionRefno ?? "_")"
                            self.VC?.pointsBalLbl.text = "\(self.redemptionDetails[0].pointsRequired ?? 0)"
                            self.VC?.quantityLbl.text = "\(self.redemptionDetails[0].noOfQuantity ?? 0)"
                            self.VC?.descriptionDetailsLbl.text = "\(self.redemptionDetails[0].productDesc ?? "")"
                            self.VC?.termAndConditionLbl.text = "\(self.redemptionDetails[0].termsCondition ?? "")"
                            let proImage = self.redemptionDetails[0].productImage ?? ""
                            if proImage.count != 0{
                                self.VC?.productImage.kf.setImage(with: URL(string: "\(productCatalogueImgURL)\(proImage)")  , placeholder: UIImage(named: "appLogo"))
                            }else{
                                self.VC?.productImage.image = UIImage(named: "appLogo")
                            }
                            
                            self.VC?.orderStatusApi()
                            self.VC?.stopLoading()
                        }
                    }else{
                        print("redemprion Details - Data not found")
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                        }
                    }
                    
                }else{
                    print("redemprion Details - Data not found")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                print("redemptionDetails error", error?.localizedDescription)
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
//     MARK: - OREDR STATUS LIST API
    func orderStatusListApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.orderStatusArrayList.removeAll()
    requestAPIs.redemptionDetailsOrderStatusApi(parameters: parameter) { result, error in
        
        if error == nil{
            if result != nil{
                self.orderStatusArrayList = result?.objCatalogueList ?? []
                if self.orderStatusArrayList.count != 0{
                    DispatchQueue.main.async {
                        self.VC?.OrderStatusTitleLbl.isHidden = false
                        self.VC?.emptyMessage.isHidden = true
                        self.VC?.orderStatusTV.reloadData()
                        self.VC?.stopLoading()
                    }
                }else{
                    self.VC?.emptyMessage.isHidden = false
                    self.VC?.OrderStatusTitleLbl.isHidden = true
                    self.VC?.emptyMessage.text = "No status found"
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("Redemption Details order status - No Data found")
                DispatchQueue.main.async {
                    self.VC?.OrderStatusTitleLbl.isHidden = true
                    self.VC?.stopLoading()
                }
            }
        }else{
            print("Redemption Details order status list error",error?.localizedDescription)
            DispatchQueue.main.async {
                self.VC?.stopLoading()
            }
        }
        
        }
    }
}
