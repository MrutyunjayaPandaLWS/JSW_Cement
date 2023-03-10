//
//  JSW_ChangePasswordVM.swift
//  MSP_Customer
//
//  Created by ADMIN on 09/03/2023.
//

import Foundation
import UIKit

class JSW_ChangePasswordVM: popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    weak var VC:JSW_ChangePasswordVC?
    var requestAPIs = RestAPI_Requests()
    
    func forgetPasswordSubmissionApi(parameter: JSON){

        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.updatePasswordApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    print(result?.returnMessage ?? "", "Change Password Status")
                    if result?.returnMessage ?? "" == "1"{
                        DispatchQueue.main.async{
                            self.VC?.stopLoading()
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.itsComeFrom = "ChangePassword"
                            vc!.descriptionInfo = "Your password has been updated successfully!"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.VC?.present(vc!, animated: true, completion: nil)
                            
                        }
                    }else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.itsComeFrom = "ChangePassword"
                        vc!.descriptionInfo = "Your password wasn't updated"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.VC?.present(vc!, animated: true, completion: nil)
                        }
                }else{
                    print(error)
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
}
