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
    
    func redemptionCateogry(parameters: JSON){
        DispatchQueue.main.async {
              self.VC?.startLoading()
              self.VC?.loaderView.isHidden = false
              self.VC?.playAnimation()
         }
        self.requestAPIs.redemptionCateogryListing(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                       self.redemptionCategoryArray = result?.objCatalogueCategoryListJson ?? []
                        print(self.redemptionCategoryArray.count)
                            if self.redemptionCategoryArray.count != 0 {
                                DispatchQueue.main.async {
                                    self.VC?.loaderView.isHidden = true
                                    self.VC?.stopLoading()
                                    self.VC?.noDataFound.isHidden = true
                                    self.VC?.catalogueCollectionView.isHidden = false
                                    self.VC?.productCategoryListArray.removeAll()
                                    self.VC?.productCategoryListArray.append((ProductCateogryModels(productCategoryId: "-1", productCategorName: "All", isSelected: 0)))
                                    for item in self.redemptionCategoryArray{
                                        self.VC?.productCategoryListArray.append(ProductCateogryModels(productCategoryId: "\(item.catogoryId ?? 0)", productCategorName: item.catogoryName ?? "", isSelected: 0))
                                    }
                                    
                                    print(self.VC?.productCategoryListArray.count, "asdfkldsafjdasf")
                                    
                                    self.VC?.catalogueCollectionView.reloadData()
                                    self.VC?.redemptionCatalogueList(startIndex: 1)
                                    self.VC?.loaderView.isHidden = true
                                    self.VC?.stopLoading()
                                }
                               
                            }else{
                                DispatchQueue.main.async {
                                    self.VC?.noDataFound.isHidden = false
                                    self.VC?.loaderView.isHidden = true
                                    self.VC?.stopLoading()
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
                            

                            self.VC?.noofelements = tempListingArray.count
                            self.redemptionCatalogueArray =  self.redemptionCatalogueArray + tempListingArray
                            self.redemptionCataloguesArray = self.redemptionCatalogueArray
                            print(self.VC?.noofelements,"TempQueryList")
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
