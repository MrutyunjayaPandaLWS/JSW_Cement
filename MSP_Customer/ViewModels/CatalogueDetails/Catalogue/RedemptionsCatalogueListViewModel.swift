//
//  RedemptionsCatalogueListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class RedemptionsCatalogueListViewModel{
    
    weak var VC: MSP_ProductCatalogueVC?
    var requestAPIs = RestAPI_Requests()
    var redemptionCategoryArray = [ObjCatalogueCategoryListJson]()
    var redemptionCatalogueArray = [ObjCatalogueList]()
    var redemptionCataloguesArray = [ObjCatalogueList]()
    var productsArray = [ObjCatalogueList]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    var myPlannerListArray = [ObjCatalogueList2]()
    var notificationListArray = [LstPushHistoryJson]()
    
    func redemptionCateogry(parameters: JSON, completion: @escaping (RedemptionCategoryModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.redemptionCateogryListing(parameters: parameters) { (result, error) in
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
    
    func redemptionCatalogue(parameters: JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
            
         }
        
        self.requestAPIs.redemptionCatalogueListing(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                       
                        //print(result, "Results ")
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        let tempListingArray = result?.objCatalogueList ?? []
//                        if self.VC?.noOfRows != 20{
//                            self.redemptionCatalogueArray.removeAll()
//                        }
//                        print("Its Come From", self.VC!.itsComeFrom)
                        
                        if  tempListingArray.isEmpty == false{
                            

                                self.VC!.noofelements = tempListingArray.count
                            self.redemptionCatalogueArray =  self.redemptionCatalogueArray + tempListingArray
                            self.redemptionCataloguesArray = self.redemptionCatalogueArray
                            print(self.VC!.noofelements,"TempQueryList")
                            print(self.redemptionCatalogueArray.count, "Product Catalogue List Count")
                            self.productsArray = self.redemptionCatalogueArray
                            //}
                              
                          
                            if self.redemptionCatalogueArray.count == 0{
                                self.VC!.productTableView.isHidden = true
                                self.VC!.noDataFound.isHidden = false
                                self.VC!.productTableView.reloadData()
                                self.VC?.loaderView.isHidden = true
                                self.VC!.stopLoading()
                            }else{
                                self.VC!.productTableView.isHidden = false
                                self.VC!.noDataFound.isHidden = true
                                self.VC!.productTableView.reloadData()
                                self.VC?.loaderView.isHidden = true
                                self.VC!.stopLoading()
                            }
                        }else{
                            if self.VC!.itsFrom != "Pagination"{
                                self.VC!.productTableView.isHidden = true
                                self.VC!.noDataFound.isHidden = false
                                self.VC!.productTableView.reloadData()
                                self.VC?.loaderView.isHidden = true
                                self.VC!.stopLoading()
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
    
    
    
    func notificationListApi(parameters: JSON, completion: @escaping (NotificationModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.notificationList(parameters: parameters) { (result, error) in
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
class ProductCateogryModels : NSObject{
    var productCategoryId:String!
    var productCategorName:String!
    var isSelected: Int!
    init(productCategoryId: String, productCategorName: String, isSelected: Int!){
        self.productCategoryId = productCategoryId
        self.productCategorName = productCategorName
        self.isSelected = isSelected
    }
}

class FilterByPointRangeModels : NSObject{
    var productCategoryId:String!
    var productCategorName:String!
    var isSelected: Int!
    init(productCategoryId: String, productCategorName: String, isSelected: Int!){
        self.productCategoryId = productCategoryId
        self.productCategorName = productCategorName
        self.isSelected = isSelected
    }
}
