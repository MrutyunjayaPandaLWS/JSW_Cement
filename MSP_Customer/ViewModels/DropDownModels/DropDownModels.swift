//
//  DropDownModels.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 19/04/2022.
//

import UIKit

class DropDownModels{
    
    weak var VC: MSP_DropDownVC?
    var requestAPIs = RestAPI_Requests()
    var stateArray = [StateList]()
    var districtArray = [LstDistrict]()
    var cityArray = [CityList]()
    var preferredLanguageArray = [LstAttributesDetails1]()
    var myClaimsPointsDelarArray = [LstAttributesDetails]()
    var myRedemptionListArray = [LstAttributesDetails3]()
    func statelisting(parameters:JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.state_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.stateArray = (result?.stateList ?? [])
                        print(self.stateArray.count)
                        if self.stateArray.count == 0{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }else{
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.dropDownTableView.reloadData()
                            self.VC?.noDataFoundLbl.isHidden = true
                        }
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
    
    func citylisting(parameters:JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.city_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.cityArray = (result?.cityList ?? [])
                        if self.cityArray.count == 0{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }else{
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.dropDownTableView.reloadData()
                            self.VC?.noDataFoundLbl.isHidden = true
                        }
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
    
    func districtlisting(parameters:JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.district_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.districtArray = (result?.lstDistrict)!
                        self.VC?.dropDownTableView.reloadData()
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        if self.districtArray.count == 0{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }else{
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                        }
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
    func preferredLanguageApi(parameters:JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.preferredLanagueApi(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.preferredLanguageArray = (result?.lstAttributesDetails ?? [])
                        if self.preferredLanguageArray.count == 0{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }else{
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.dropDownTableView.reloadData()
                            self.VC?.noDataFoundLbl.isHidden = true
                        }
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
    func claimPointsDelarAPI(parameters: JSON, completion: @escaping (DealerListModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
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
    
    
    func myRedemptionListApi(parameters:JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.myRedemptionStausListApi(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.myRedemptionListArray = (result?.lstAttributesDetails ?? [])
                        if self.myRedemptionListArray.count == 0{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }else{
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.dropDownTableView.reloadData()
                            self.VC?.noDataFoundLbl.isHidden = true
                        }
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
}
