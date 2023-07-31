//
//  File.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 06/12/22.
//

import Foundation

class DefaultAddressModels{
    weak var VC: MSP_DefaultAddressVC?
    var requestAPIs = RestAPI_Requests()
    var defaultAddressArray = [LstCustomerJson]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    var totalCartValue = 0
    
    func defaultAddressAPi(parameters:JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation()
        self.requestAPIs.myProfile(parameters: parameters) { (response, error) in
            if error == nil {
                if response != nil{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        self.defaultAddressArray = response?.lstCustomerJson ?? []
                        self.VC?.customerAddressTV.text = "\(self.defaultAddressArray[0].firstName ?? "-"),\n\(self.defaultAddressArray[0].mobile ?? "-"),\n\(self.defaultAddressArray[0].address1 ?? "-"),\n\(self.defaultAddressArray[0].cityName ?? "-"),\n\(self.defaultAddressArray[0].stateName ?? "-"),\n\(self.defaultAddressArray[0].countryName ?? "-"),\n\(self.defaultAddressArray[0].zip ?? "-")"
                        self.VC?.selectedname = self.defaultAddressArray[0].firstName ?? "-"
                        self.VC?.selectedemail = self.defaultAddressArray[0].email ?? "-"
                        self.VC?.selectedmobile = self.defaultAddressArray[0].mobile ?? "-"
                        self.VC?.selectedState = self.defaultAddressArray[0].stateName ?? "-"
                        self.VC?.selectedStateID = self.defaultAddressArray[0].stateId ?? 0
                        self.VC?.selectedCity = self.defaultAddressArray[0].districtName ?? "-"
                        self.VC?.selectedCityID = self.defaultAddressArray[0].districtId ?? 0
                        self.VC?.selectedaddress = self.defaultAddressArray[0].address1 ?? "-"
                        self.VC?.selectedpincode = self.defaultAddressArray[0].zip ?? "-"
                        self.VC?.selectedCountryId = self.defaultAddressArray[0].countryId ?? 0
                        self.VC?.selectedCountry = self.defaultAddressArray[0].countryName ?? "-"
                        
                    }
                }else{
                    DispatchQueue.main.sync {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.sync {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
            }
            
        }
    }
    
    
    func cartAddressAPI(parameters:JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation()
        self.requestAPIs.myCartList(parameters: parameters) { (response, error) in
            if error == nil {
                if response != nil{
                    DispatchQueue.main.async {
                            self.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
                            print(self.myCartListArray.count,"CartCount")
                        if self.myCartListArray.count > 0 {
                            //self.VC?.cartCountLbl.isHidden = false
                            self.VC?.cartCountLbl.text = "\(self.myCartListArray.count)"
                        }else{
                            self.VC?.cartCountLbl.isHidden = true
                        }
                                for data in self.myCartListArray{
                                    self.totalCartValue = Int(data.sumOfTotalPointsRequired ?? 0.0)
                                    print(self.totalCartValue, "TotalValue")
                                }
                                self.VC?.totalPoints.text = "\(Double(self.totalCartValue))"
                                self.VC?.orderListTableView.reloadData()
                                self.VC?.loaderView.isHidden = true
                                self.VC?.stopLoading()
                    }
                }
            }
        }
    }
    
    
    func adhaarNumberExistsApi(parameters: JSON, completion: @escaping (AdhaarCardExistsModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.adhaarCardExistApi(parameters: parameters) { (result, error) in
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

    
}
