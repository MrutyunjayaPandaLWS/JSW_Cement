//
//  CreateNewQueryViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class CreateNewQueryViewModel{
    weak var VC: MSP_CreateNewQueryVC?
    var requestAPIs = RestAPI_Requests()
    

    func helpTopicList(parameters: JSON, completion: @escaping (HelpTopicModel?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
//            self.VC?.loaderView.isHidden = false
//            self.VC?.playAnimation()
        }
        self.requestAPIs.helpTopicListingApi(parameters: parameters) { (result, error) in
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

 func newQuerySubmission(parameters: JSON, completion: @escaping (NewQuerySubmission?) -> ()){
     DispatchQueue.main.async {
         self.VC?.startLoading()
         self.VC?.loaderView.isHidden = true
     }
     self.requestAPIs.newQuerySubmissionApi(parameters: parameters) { (result, error) in
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
