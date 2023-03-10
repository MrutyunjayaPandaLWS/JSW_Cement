//
//  GeneralInfoVM.swift
//  MSP_Customer
//
//  Created by ADMIN on 03/12/2022.
//

import UIKit

class GeneralInfoVM: popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    weak var VC: MSP_GeneralInformationVC?
    var requestAPIs = RestAPI_Requests()
    var parameters = [String: Any]()
    var parameter: JSON?
    func registrationSubmissionApi(paramters: JSON){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
                }
        self.requestAPIs.registrationSubmissionApi(parameters: paramters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        let response = String(result?.returnMessage ?? "").split(separator: "~")
                        if response.count != 0{
                            if response[0] == "1"{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.itsComeFrom = "Registration"
                                    vc!.itsFrom = self.VC?.itsComeFrom ?? ""
                                    vc!.descriptionInfo = "Your details have been submitted successfully. Our team will contact you shortly for verification"
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.VC?.present(vc!, animated: true, completion: nil)
                                    
                                }
                            }else{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.itsComeFrom = "Registration"
                                    vc!.itsFrom = self.VC?.itsComeFrom ?? ""
                                    vc!.descriptionInfo = "Registration failed.Try after some time"
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.VC?.present(vc!, animated: true, completion: nil)
                                }
                            }
                        }
                        
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
