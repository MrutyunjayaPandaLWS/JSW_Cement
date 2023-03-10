//
//  PancardViewModel.swift
//  CenturyPly_JSON
//
//  Created by admin on 26/10/22.
//

import UIKit
import SDWebImage

class PancardViewModel{
    
    
    weak var VC: PancardViewController?
    var requestAPIs = RestAPI_Requests()
    var resultData:PanModels?
    
    func pancarddetailsApi(parameters: JSON){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
                }
        self.requestAPIs.getpaneApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        if result?.lstPanDetails?.count != 0 {
                            if result?.lstPanDetails![0].result ?? "-1" == "1"{
                                self.VC?.dobLabel.text = "Date of Birth : \(result?.lstPanDetails![0].dOB ?? "")"
                                self.VC?.nameofPerson.text = "Person Name : \(result?.lstPanDetails![0].panName ?? "")"
                                self.VC?.pannumber.text = "Pan Number : \(result?.lstPanDetails![0].panId ?? "")"
                                self.VC?.panNumberTF.text = "\(result?.lstPanDetails![0].panId ?? "")"
                                
                                if result?.lstPanDetails![0].panImage ?? "" == ""{
                                    //self.VC?.panImage.image = UIImage(named: "sample-pan-card")
                                    self.VC?.imagePanCons.constant = 0
                                }else{
                                    let x = (result?.lstPanDetails![0].panImage ?? "").split(separator: "~")
                                    if x.count != 0{
                                        let totalImgURL = PROMO_IMG + (x[0])
                                        self.VC?.panImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "sample-pan-card"))
                                    }
                                }
                                print(result?.lstPanDetails![0].isVerified ?? "-1")
                                if result?.lstPanDetails![0].isVerified ?? "-1" == "0"{
                                    self.VC?.SuccessshadowView.isHidden = false
                                    self.VC?.successmeassage.text = "Customer PAN Details have been submitted for verification!"
                                    self.VC?.dobLabel.isHidden = true
                                    self.VC?.nameofPerson.isHidden = false
                                    self.VC?.panattachmet.isHidden = false
                                    self.VC?.panattachment.isHidden = false
                                    self.VC?.pannumber.isHidden = false
                                    self.VC?.validateButtonn.isHidden = false
                                    self.VC?.panImage.isHidden = true
                                    self.VC?.saveButton.isHidden = false
                                    self.VC?.borderview.isHidden = false
                                    self.VC?.validateButtonn.isEnabled = false
                                    self.VC?.validateButtonn.setTitle("Verify", for: .normal)
                                }else if result?.lstPanDetails![0].isVerified ?? "-1" == "1"{
                                    self.VC?.SuccessshadowView.isHidden = false
                                    self.VC?.successmeassage.text = "Customer PAN Details has been verified!"
                                    self.VC?.dobLabel.isHidden = true
                                    self.VC?.nameofPerson.isHidden = false
                                    self.VC?.panattachmet.isHidden = false
                                    self.VC?.panattachment.isHidden = false
                                    self.VC?.pannumber.isHidden = false
                                    self.VC?.validateButtonn.isHidden = false
                                    self.VC?.panImage.isHidden = true
                                    self.VC?.saveButton.isHidden = false
                                    self.VC?.borderview.isHidden = false
                                    self.VC?.validateButtonn.isEnabled = false
                                }else if result?.lstPanDetails![0].isVerified ?? "-1" == "3"{
                                    self.VC?.validateButtonn.setTitle("Verify", for: .normal)
                                    self.VC?.panNumberTF.text = ""
                                    self.VC?.dobLabel.isHidden = true
                                    self.VC?.nameofPerson.isHidden = true
                                    self.VC?.panattachmet.isHidden = true
                                    self.VC?.panattachment.isHidden = true
                                    self.VC?.pannumber.isHidden = true
                                    self.VC?.validateButtonn.isHidden = false
                                    self.VC?.panImage.isHidden = true
                                    self.VC?.saveButton.isHidden = true
                                    self.VC?.borderview.isHidden = true
                                }
                            }
                        }
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
    
//    func pancardVerifyApi(parameters: JSON){
//        self.VC?.startLoading()
//        self.requestAPIs.panVerifyApi(parameters: parameters) { (result, error) in
//            if error == nil{
//                if result != nil {
//                    DispatchQueue.main.async {
//                        if result?.objPanDetailsRetrieverequest?.isPanValid ?? -1 == 1{
//                            self.VC?.dobLabel.text = "Date of Birth : \(result?.objPanDetailsRetrieverequest?.dateOfBirth ?? "")"
//                            self.VC?.nameofPerson.text = "Person Name : \(result?.objPanDetailsRetrieverequest?.firstName ?? "") \(result?.objPanDetailsRetrieverequest?.lastName ?? "")"
//                            self.VC?.pannumber.text = "Pan Number : \(result?.objPanDetailsRetrieverequest?.panNumber ?? "")"
//                            self.resultData = result
//                            self.VC?.dobLabel.isHidden = true
//                            self.VC?.nameofPerson.isHidden = false
//                            self.VC?.panattachmet.isHidden = false
//                            self.VC?.panattachment.isHidden = false
//                            self.VC?.pannumber.isHidden = false
//                            self.VC?.validateButtonn.isHidden = false
//                            self.VC?.panImage.isHidden = false
//                            self.VC?.saveButton.isHidden = false
//                            self.VC?.borderview.isHidden = false
//                            self.VC?.validateButtonn.isEnabled = false
//                            self.VC?.validateButtonn.setTitle("Verify", for: .normal)
//                            self.VC?.validateButtonn.backgroundColor = UIColor.gray
//                            if result?.objPanDetailsRetrieverequest?.panImage ?? "" == ""{
//                            //self.VC?.panImage.image = UIImage(named: "sample-pan-card"
//                                self.VC?.imagePanCons.constant = 0
//
//                            }else{
//                                let totalImgURL = productCatalogueImgURL + (result?.objPanDetailsRetrieverequest?.panImage ?? "")
//                                self.VC?.panImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "sample-pan-card"))
//                            }
//                        }else {
//                            self.VC?.alertTypeWithoutAction(alertheading: "", alertMessage: "Please enter the valid PAN Number", buttonTitle: "Ok")
//                            self.VC?.dobLabel.isHidden = true
//                            self.VC?.nameofPerson.isHidden = true
//                            self.VC?.panattachmet.isHidden = true
//                            self.VC?.panattachment.isHidden = true
//                            self.VC?.pannumber.isHidden = true
//                            //self.VC?.validateButtonn.isHidden = true
//                            self.VC?.panImage.isHidden = true
//                            self.VC?.saveButton.isHidden = true
//                            self.VC?.borderview.isHidden = true
//                            self.VC?.panImage.image = UIImage(named: "sample-pan-card")
//                            self.VC?.validateButtonn.isEnabled = true
//                            self.VC?.validateButtonn.setTitle("Verify", for: .normal)
//                        }
//                        print("No Response")
//                        DispatchQueue.main.async {
//                            self.VC?.stopLoading()
//                        }
//                    }
//                } else {
//                    print("No Response")
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_Login \(error)")
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//
//        }
//    }
//
//    }
    
//    func pancardSaveApi(parameters: JSON){
//        self.VC?.startLoading()
//        print(parameters)
//        self.requestAPIs.pansaveApi(parameters: parameters) { (result, error) in
//            if error == nil{
//                if result != nil {
//                    DispatchQueue.main.async {
//                        print(result?.returnMessage ?? "")
//                        self.VC?.stopLoading()
//                        let resultvalue = result?.returnMessage ?? ""
//                        print(resultvalue,"Pan")
//                        let splitted = resultvalue.split(separator: ":")
//                        print(splitted.count)
//                        
//                        if splitted.count != 0{
//                            if splitted[0] == "1"{
//                                print("success")
//                                self.VC?.SuccessshadowView.isHidden = false
//                                //self.VC?.successmeassage.text = "Pancard saved successfully"
//                                self.VC?.successmeassage.text = "Customer PAN details have been submitted for verification!"
//                            }else if splitted[0] == "2"{
//                                self.VC?.SuccessshadowView.isHidden = false
//                                //self.VC?.successmeassage.text = "Customer PAN details have been verified!"
//                                self.VC?.successmeassage.text = "Customer PAN details have been submitted for verification!"
//                            }else{
//                                self.VC?.SuccessshadowView.isHidden = false
//                                self.VC?.successmeassage.text = "Saving Pancard failed. try after sometime"
//                            }
//                        }
//                        let parameterJSON = [
//                            "ActorId":"\(self.VC?.userID ?? "")",
//                               "ActionType":"4",
//                            "LoyaltyId":"\(self.VC?.loyaltyId ?? "")"
//                        ]
//                        print(parameterJSON)
//                        self.pancarddetailsApi(parameters: parameterJSON)
//                    }
//                } else {
//                    print("No Response")
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                        
//                    }
//                }
//            }else{
//                print("ERROR_Login \(error)")
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//
//        }
//    }
//    
//    }

}
