//
//  ForgotPasswordViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class ForgotPasswordViewModel: popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
    
    weak var VC: MSP_ForgotPasswordVC?
    var requestAPIs = RestAPI_Requests()
    
    
//    func forgotPasswordAPI(parameters: JSON, completion: @escaping (ForgotPasswordModels?) -> ()) {
//        DispatchQueue.main.async {
//            self.VC?.startLoading()
//            self.VC?.loaderView.isHidden = false
//            self.VC?.playAnimation()
//        }
//        self.requestAPIs.forgotPassword_API(parameters: parameters) { (result, error) in
//            print(result,"dfdfd")
//            if error == nil {
//                if result != nil {
//                    DispatchQueue.main.async {
//                        completion(result)
//                        self.VC?.loaderView.isHidden = true
//                        self.VC?.stopLoading()
//                    }
//                } else {
//                    print("No Response")
//                    DispatchQueue.main.async {
//                        self.VC?.loaderView.isHidden = true
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_Login \(error)")
//                DispatchQueue.main.async {
//                    self.VC?.loaderView.isHidden = true
//                    self.VC?.stopLoading()
//                }
//            }
//        }
//    }
    func forgotPasswordAPI(paramters: JSON){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.VC?.startLoading()
            self.VC?.loaderView.isHidden = false
            self.VC?.playAnimation()
        })
        let url = URL(string: forgotPassURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "TOKEN") ?? "")", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                 print(str, "- Mobile Number Exists")
                if str ?? "" == "true"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.itsComeFrom = "LoginPage"
                        vc!.descriptionInfo = "New password sent to the registered mobile number!"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.VC?.present(vc!, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.async{
                       
                        self.VC?.forgotPasswordTF.text = ""
    
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                        self.VC?.isSuccess = 0
                            vc!.descriptionInfo = "Please enter registered number"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                        self.VC?.present(vc!, animated: true, completion: nil)
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        }
                   
                       
                }
                 }catch{
                     self.VC?.loaderView.isHidden = true
                     self.VC?.stopLoading()
                     print("parsing Error")
            }
        })
        task.resume()
    }
    
    
    
    
    
    func membershipIDVerification(parameters: JSON, completion: @escaping (MemberVerificationModels?) -> ()) {
        DispatchQueue.main.async {
            self.VC?.startLoading()
            self.VC?.loaderView.isHidden = false
            self.VC?.playAnimation()
        }
        self.requestAPIs.membershipIDVerification_API(parameters: parameters) { (result, error) in
            if error == nil {
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
}
