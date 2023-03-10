////
////  RegistrationVM.swift
////  MSP_Customer
////
////  Created by ADMIN on 03/12/2022.
////
//
//import UIKit
//
//class RegistrationVM: popUpDelegate {
//    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
//
//
//    weak var VC: MSP_RegisterVC?
//
//    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
//    var requestAPIs = RestAPI_Requests()
//    var count = 59
//    weak var timer : Timer?
//    var otpData = ""
//    var OTPforVerification = ""
//    var parameters = [String: Any]()
//    var userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
//    var userFullName = UserDefaults.standard.string(forKey: "UserName") ?? ""
//    var parameter: JSON?
//
//
//    func verifyMobileNumberAPI(paramters: JSON){
//        DispatchQueue.main.async {
//            self.VC?.startLoading()
//            self.VC?.loaderView.isHidden = false
//            self.VC?.playAnimation()
//        }
//
//
//        let url = URL(string: checkUserExistencyURL)!
//        let session = URLSession.shared
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer \(self.VC?.token ?? "")", forHTTPHeaderField: "Authorization")
//
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//
//            guard error == nil else {
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            do{
//                let str = String(decoding: data, as: UTF8.self) as String?
//                 print(str, "- Mobile Number Exists")
//                if str ?? "" != "1"{
//                    DispatchQueue.main.async{
//                        self.VC?.loaderView.isHidden = true
//                        self.VC?.stopLoading()
//                        self.VC?.sentOtpLbl.text = "Submit OTP"
//                        self.VC?.countLbl.isHidden = false
//                        self.VC?.resendBTNView.isHidden = true
//                        self.VC?.timerLbl.isHidden = false
//                        self.VC?.txtDPOTPView.isHidden = false
//                        self.VC?.sendOTPButtonContrain.constant = 140
//                        self.VC!.submitBtnView.startColor = UIColor(red: 226/255, green: 42/255, blue: 36/255, alpha: 1.0)
//                        self.VC!.submitBtnView.endColor = UIColor(red: 126/255, green: 22/255, blue: 20/255, alpha: 1.0)
//                       self.resendOTP()
//                    }
//                }else{
//                    DispatchQueue.main.async{
//                        self.VC?.loaderView.isHidden = true
//                        self.VC?.stopLoading()
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//                        vc!.descriptionInfo = "Mobile number already registered !"
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.VC?.present(vc!, animated: true, completion: nil)
//                        self.VC?.membershipTF.text = ""
//                    }
//                }
//                 }catch{
//                     DispatchQueue.main.async {
//                         self.VC?.loaderView.isHidden = true
//                         self.VC?.stopLoading()
//                     }
//
//                     print("parsing Error")
//            }
//        })
//        task.resume()
//    }
//
//    func resendOTP(){
//        DispatchQueue.main.async {
//            let parameterJSON = [
//                    "UserName": "",
//                    "UserId": -1,
//                    "MobileNo": "\(self.VC?.membershipTF.text ?? "")",
//                    "OTPType": "Enrollment",
//                    "MerchantUserName": "\(MerchantUserName)"
//            ] as [String: Any]
//            print(parameterJSON)
//            self.OTPAPI(paramters: parameterJSON)
//            self.timer?.invalidate()
//            self.VC?.timerLbl.text = "00:59"
//            self.count = 60
//            self.VC?.txtDPOTPView.isHidden = false
//            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
//            }
//
//    }
//    func OTPAPI(paramters: JSON){
//        DispatchQueue.main.async {
//                    self.VC?.startLoading()
//                    self.VC?.loaderView.isHidden = false
//                    self.VC?.playAnimation()
//                }
//        self.requestAPIs.otp_Post_API(parameters: paramters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//
//                        self.VC?.resendBTNView.isHidden = true
//                        self.VC?.membershipTF.isEnabled = false
//                        print(result?.returnMessage ?? "", " - OTP")
//                       // self.delegate?.refreshTimerDidTap(self)
//                        self.OTPforVerification = result?.returnMessage ?? ""
//                        self.VC?.loaderView.isHidden = true
//                        self.VC?.stopLoading()
//
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.loaderView.isHidden = true
//                        self.VC?.stopLoading()
//                    }
//
//
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.VC?.loaderView.isHidden = true
//                    self.VC?.stopLoading()
//                }
//
//            }
//        }
//    }
//    @objc func update() {
//        if(self.count > 1) {
//            self.count = Int(self.count) - 1
//            self.VC?.timerLbl.text = "00:\(self.count)"
//
//        }else{
//            self.timer?.invalidate()
//            self.VC?.timerLbl.text = "00:00"
//            self.VC?.resendBTNView.isHidden = false
//        }
//    }
//}
