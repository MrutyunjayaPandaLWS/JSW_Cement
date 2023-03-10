//
//  SideMenuViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class SideMenuViewModel: popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    weak var VC: MSP_SideMenuViewController?
    var requestAPIs = RestAPI_Requests()
    weak var VC1: MSP_DashboardVC?
    
    func dashboardAPICall(parameters: JSON, completion: @escaping (DashboardModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.dashboard_API(parameters: parameters) { (result, error) in
            if error == nil {
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
    
    
    //Image Submission
    func imageSubmissionAPI(base64: String) {
        let parameters = [
            "ActorId": "\(userID)",
            "ObjCustomerJson": [
                "DisplayImage": "\(base64)",
                "LoyaltyId": "\(loyaltyId)"
            ]
        ]as [String : Any]
        print(parameters,"imageAPI")
        self.requestAPIs.imageSavingAPI(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "", "ReturnMessage")
                        if result?.returnMessage ?? "" == "1"{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                //vc!.isComeFrom = "ProfileImageUpdate"
                                vc!.descriptionInfo = "Profile image updated successfully"
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
                            NotificationCenter.default.post(name: .goToDashBoardAPI, object: nil)
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                //vc!.isComeFrom = "ProfileImageUpdate"
                                vc!.descriptionInfo = "Profile image update Failed"
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
                        }
                        self.VC?.stopLoading()
                    }
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
    //deleteAccountApi
    
    func deleteAccount(parameters: JSON, completion: @escaping (DeleteAccountModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.deleteAccountApi(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.stopLoading()
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
