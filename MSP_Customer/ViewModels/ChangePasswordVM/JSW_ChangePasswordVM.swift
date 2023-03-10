//
//  JSW_ChangePasswordVM.swift
//  MSP_Customer
//
//  Created by ADMIN on 09/03/2023.
//

import Foundation
import UIKit

class JSW_ChangePasswordVM{
    weak var VC:JSW_ChangePasswordVC?
    var requestAPIs = RestAPI_Requests()
    
    func forgetPasswordSubmissionApi(parameter: JSON){

        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
//        self.requestAPIs.forgetPasswordApi(parameters: parameter) { (result, error) in
//            
//            if result == nil{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//            }else{
//                if error == nil{
//                    let loginResponse = result?.userList ?? []
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                        if loginResponse.count != 0{
//                            print(loginResponse[0].result ?? -1, "PasswordUpdate")
//                            if loginResponse[0].result ?? -1 == 1{
//                                UserDefaults.standard.set(false, forKey: "UpdatePassword")
//                                UserDefaults.standard.synchronize()
//                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
//                                vc.modalTransitionStyle = .coverVertical
//                                vc.modalPresentationStyle = .overFullScreen
//                                self.VC!.present(vc, animated: true)
//                            }else if loginResponse[0].result ?? -1 == -1{
//                                self.VC!.view.makeToast("Invalid UserName!", duration: 2.0, position: .bottom)
//                            }
//                            
//                        }else{
//                            self.VC!.view.makeToast("Something went wrong. Try again later!", duration: 2.0, position: .bottom)
//                        }
//                    
//                    }
//                }else{
//                    print(error)
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }
//        }
    }
}
