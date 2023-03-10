//
//  DreamGiftDetailsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class DreamGiftDetailsViewModel{
    weak var VC1: MSP_MyDreamGiftVC?
    weak var VC: MSP_MyDreamGiftDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var myDreamGiftDetailsArray = [LstDreamGift1]()
    var myDreamGiftListArray = [LstDreamGift]()
   
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
    func myDreamGiftLists(parameters: JSON, completion: @escaping (MyDreamGiftModels?) -> ()){
        DispatchQueue.main.async {
              self.VC1?.startLoading()
              self.VC1?.loaderView.isHidden = false
              self.VC1?.playAnimation()
         }
        self.requestAPIs.myDreamGiftList(parameters: parameters) { (result, error) in
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
                    self.VC1?.loaderView.isHidden = true
                    self.VC1?.stopLoading()
                }

        }
    }
    
    }
    func removeDreamGift(parameters: JSON, completion: @escaping (RemoveGiftModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.removeDreamGifts(parameters: parameters) { (result, error) in
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
    
    func myDreamGiftDetails(parameters: JSON, completion: @escaping (DetailsGiftModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
//              self.VC?.loaderView.isHidden = false
//              self.VC?.playAnimation()
         }
        self.requestAPIs.myDreamGiftDetails(parameters: parameters) { (result, error) in
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
    
}
