//
//  CatalogueDetailsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class CatalogueDetailsViewModel{
    weak var VC: MSP_ProductCatalogueDetailsVC?
    var requestAPIs = RestAPI_Requests()

    var redemptionCatalogueArray = [ObjCatalogueList]()
    var productsArray = [ObjCatalogueList]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    var myPlannerListArray = [ObjCatalogueList2]()
    
    func redemptionCatalogue(parameters: JSON, completion: @escaping (RedemptionCatalogueModels?) -> ()){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
                }
        self.requestAPIs.redemptionCatalogueListing(parameters: parameters) { (result, error) in
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
    
    func addToCart(parameters: JSON, completion: @escaping (AddToCartModels?) -> ()){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
                }
        self.requestAPIs.addToCartApi(parameters: parameters) { (result, error) in
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
    
    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?) -> ()){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
                }
        self.requestAPIs.myCartList(parameters: parameters) { (result, error) in
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
    
    func addToPlanners(parameters: JSON, completion: @escaping (AddToPlannerModel?) -> ()){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
                }
        self.requestAPIs.addToPlannerApi(parameters: parameters) { (result, error) in
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
    
    func plannerListingApi(parameters: JSON, completion: @escaping (PlannerListModels?) -> ()){
        DispatchQueue.main.async {
                    self.VC?.startLoading()
                    self.VC?.loaderView.isHidden = false
                    self.VC?.playAnimation()
                }
        self.requestAPIs.plannerListApi(parameters: parameters) { (result, error) in
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
