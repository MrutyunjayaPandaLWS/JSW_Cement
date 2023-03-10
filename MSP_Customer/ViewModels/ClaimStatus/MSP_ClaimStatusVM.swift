//
//  GMS_ClaimStatusVM.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 30/11/22.
//

import UIKit

class MSP_ClaimStatusVM {
    
    weak var VC: MSP_ClaimStatusVC?
    var requestAPIs = RestAPI_Requests()
    var claimStatusArray = [CustomerBasicInfoListJson]()
    var claimStatus = [Any]()
    
    func claimStatusApi(parameters: JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
            self.claimStatusArray.removeAll()
         }
        
        self.requestAPIs.claimStatusApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    let claimStatusListing = result?.customerBasicInfoListJson ?? []
                    DispatchQueue.main.async {
                        if claimStatusListing.isEmpty == false{
                            self.claimStatusArray += claimStatusListing
                            self.VC?.noofelements = self.claimStatusArray.count
                            print(self.claimStatusArray.count,"Claim Status")
                                self.VC?.loaderView.isHidden = true
                                self.VC?.stopLoading()
                                
                                if self.claimStatusArray.count != 0{
                                    
                                    self.VC?.claimsTableView.isHidden = false
                                    self.VC?.noDataLbl.isHidden = true
                                    self.VC?.claimsTableView.reloadData()
                                    
                                }else{
                                    
                                    self.VC?.noDataLbl.isHidden = false
                                    self.VC?.claimsTableView.isHidden = true
                                    self.VC?.filterScreenView.isHidden = false
                                }
                        }else{
                            if self.VC!.itsFrom == "Filter"{
                                    self.VC?.noDataLbl.isHidden = false
                                    self.VC?.claimsTableView.isHidden = true
                                    self.VC?.filterScreenView.isHidden = false
                            }else{
                                self.VC?.noDataLbl.isHidden = false
                                self.VC?.claimsTableView.isHidden = true
                                self.VC?.filterScreenView.isHidden = false
                            }

                        }
                    }

                  
                }else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR \(error)")
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
        }
    }
    
    }
    
}
