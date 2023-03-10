//
//  File.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 06/12/22.
//

import Foundation
class MySummeryModels{
    weak var VC: MSP_MySummaryVC?
    var requestAPIs = RestAPI_Requests()
    var mySummeryArray = [LstInfluencerClaimDetailsAPI]()
    
    func mySummeryAPI(parameters:JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
         }
        self.requestAPIs.mySummeryAPI(parameters: parameters) { (response, error) in
            if error == nil {
                if response != nil{
                    DispatchQueue.main.async {
                        self.mySummeryArray = response?.lstInfluencerClaimDetailsAPI ?? []
                        print(self.mySummeryArray.count,"kghdjhdu")
                            if self.mySummeryArray.count != 0{
                                self.VC?.mySummaryTableView.isHidden = false
                                self.VC?.mySummaryTableView.reloadData()
                                self.VC?.noDataFoundLbl.isHidden = true
                            }else{
                                self.VC?.mySummaryView.isHidden = true
                                self.VC?.mySummaryTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                            }
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
}
