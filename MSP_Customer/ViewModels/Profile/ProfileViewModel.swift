//
//  ProfileViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class ProfileViewModel: popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    

    weak var VC: MSP_MyProfileVC?
    var requestAPIs = RestAPI_Requests()
    
    
    func myProifleDetails(parameters: JSON, completion: @escaping (MyProfileModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
//              self.VC?.loaderView.isHidden = false
//              self.VC?.playAnimation()
         }
        self.requestAPIs.myProfile(parameters: parameters) { (result, error) in
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
    
    //Image Submission
    func imageSubmissionAPI(base64: String) {
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        let parameters = [
            "ActorId": "\(UserDefaults.standard.string(forKey: "UserID") ?? "")",
            "ObjCustomerJson": [
                "DisplayImage": "\(base64)",
                "LoyaltyId": "\(UserDefaults.standard.string(forKey: "LoyaltyID") ?? "")"
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
                                vc!.itsComeFrom = "MyProfileImage"
                                vc!.descriptionInfo = "Profile image updated successfully"
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
//                            NotificationCenter.default.post(name: .goToDashBoardAPI, object: nil)
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "MyProfileImage"
                                vc!.descriptionInfo = "Profile image update Failed"
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
                        }
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
}
