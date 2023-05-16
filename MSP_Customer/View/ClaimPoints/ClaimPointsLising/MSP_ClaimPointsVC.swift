//
//  MSP_ClaimPointsVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit
import SDWebImage
import CoreData
import Firebase
import Lottie
class MSP_ClaimPointsVC: BaseViewController, DropDownDelegate, SendDetailsDelegate, popUpDelegate, DateSelectedDelegate, DealerDropdownlistDelagate {
    func declineDate(_ vc: MSP_DOBVC) {}
    func selectedDealer(item: SelectDealerDropDownVC) {
        self.selectDealerlbl.text = item.selectedDealerName
        self.selectedDealerId = item.selectedDealerId
        print(item.selectedDealerId)
    }
    
    func acceptDate(_ vc: MSP_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.searchPointsArrayTF.text = vc.selectedDate
        }
    }
    func statusDipTap(_ vc: MSP_DropDownVC) {}
    func redemptionStatusDidTap(_ vc: MSP_DropDownVC) {}
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func qtyValue(_ cell: MSP_ClaimPointsTVC) {
        guard let tappedIndexPath = self.claimPointListTableView.indexPath(for: cell) else{return}
        
        
        
        if cell.qtyTF.tag == self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1 {
            print(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1, "Product Id")
            let finalValues = cell.remarksTF.text ?? ""
            let finalValue = cell.qtyTF.text ?? ""
            cell.qtyTF.text = finalValue
            
            if finalValue  == "0" || finalValue == "0.0" || finalValue == "0.00" || finalValue == "0.000" || finalValue == "00.0" || finalValue == "0.0" || finalValue == "00" || finalValue == "000" || finalValue == "0000" || finalValue == "00000" || finalValue == "000000" || finalValue == "000000" || finalValue == "00000000"{
                self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                cell.qtyTF.text = ""
                
                for data in self.claimPointsDetailsArray{
                    if Int(data.productId ?? "0")! == self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? 0{
                        data.productName = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].productName ?? "")"
                        data.productCode = ""
                        data.productId = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1)"
                        data.qunantity = cell.qtyTF.text ?? ""
                        data.quantityKG = ""
                        data.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        }
                    }
                
            }else if finalValue == "" || finalValue == " " || finalValue == "  " || finalValue == "   "{
                self.view.makeToast("Enter quantity", duration: 2.0, position: .bottom)
                cell.qtyTF.text = ""
                for data in self.claimPointsDetailsArray{
                    if Int(data.productId ?? "0")! == self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? 0{
                        data.productName = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].productName ?? "")"
                        data.productCode = ""
                        data.productId = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1)"
                        data.qunantity = cell.qtyTF.text ?? ""
                        data.quantityKG = ""
                        data.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                        }
                    }
            }else if finalValue != "" && finalValue != "0" && finalValue != " " && finalValue != "-1" && finalValue != "00" && finalValue != "000" && finalValue != "0000"  && finalValue != "0000" && finalValue != "00000" && finalValue != "000000" && finalValue != "0000000" && finalValue != "00000000" && finalValue != "000000000" && finalValue != "0000000000" {
                
                let calcValue = Int(finalValue)! - 1
                print(calcValue)
                if calcValue >= 0{
                    
                    let filterArray = self.claimPointsDetailsArray.filter{$0.productId ?? "" == "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1)"}
                    if filterArray.count == 0{
                        let selectedQty = ClaimPointsArray(context: persistanceservice.context)
                        selectedQty.productName = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].productName ?? "")"
                        selectedQty.productCode = ""
                        selectedQty.productId = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1)"
                        selectedQty.qunantity = cell.qtyTF.text ?? ""
                        selectedQty.quantityKG = ""
                        selectedQty.remarks = "\(finalValues)"
                        persistanceservice.saveContext()
                        self.fetchCartDetails()
                    }else{
                        for data in self.claimPointsDetailsArray{
                            if Int(data.productId ?? "0")! == self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? 0{
                                data.productName = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].productName ?? "")"
                                data.productCode = ""
                                data.productId = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1)"
                                data.qunantity = cell.qtyTF.text ?? ""
                                data.quantityKG = ""
                                data.remarks = "\(finalValues)"
                                persistanceservice.saveContext()
                                self.fetchCartDetails()
                                }
                            }
                    }
                           
                }else{
                    self.view.makeToast("Enter valid quantity", duration: 2.0, position: .bottom)
                    cell.qtyTF.text = ""
                    }
            }else{
                self.view.makeToast("Something went wrong! Try again later...", duration: 2.0, position: .bottom)
            }
        }
    }
    
    func remarksValue(_ cell: MSP_ClaimPointsTVC) {
        guard let tappedIndexPath = self.claimPointListTableView.indexPath(for: cell) else{return}
        if cell.remarksTF.tag == self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1{
            let finalValues = cell.remarksTF.text ?? ""
           // cell.remarksTF.text = finalValues
            
            
            for data in self.claimPointsDetailsArray{
                if self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? 0 == Int(data.productId!) ?? -1{
                    if data.qunantity ?? "" == "" && data.qunantity ?? "" == "0" && data.qunantity ?? "" == " " && data.quantityKG ?? "" == "" && data.quantityKG ?? "" == "0" && data.quantityKG ?? "" == " "{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Enter quantiy"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                            
                        }
                    }else{
                        if data.productId ?? "" == "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1)" && data.qunantity ?? "" != ""{
                            print(finalValues, "Entered Remarks")
                            data.productId = "\(self.VM.myClaimsPointsArray[tappedIndexPath.row].cat_Id1 ?? -1)"
                            data.remarks = finalValues
                            print(data.remarks,"ksjdksj")
                            //data.qunantity = cell.qtyTF.text ?? ""
                            print(data.qunantity,"ererrer")
                            //data.quantityKG = cell.qtyKGTF.text ?? ""
                            print(data.quantityKG,"dfdf")
                            persistanceservice.saveContext()
                        
                            self.fetchCartDetails()
                        }
                    }
                }

            }
            
            
        }
        self.claimPointListTableView.reloadData()
    }
    
    func dealerDipTap(_ vc: MSP_DropDownVC) {
        self.selectDealerlbl.text = vc.selectedDealerName
        self.selectedDealerId = vc.selectedDealerId
        print(vc.selectedDealerId)
    }
    
    func stateDidTap(_ vc: MSP_DropDownVC) {}
    func cityDidTap(_ vc: MSP_DropDownVC) {}
    func preferredLanguageDidTap(_ vc: MSP_DropDownVC) {}
    func genderDidTap(_ vc: MSP_DropDownVC) {}
    func titleDidTap(_ vc: MSP_DropDownVC) {}
    
    
    @IBOutlet var selectDealerView: UIView!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var selectDealerlbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet var selectDelarLbl: UILabel!
    @IBOutlet weak var submitBtn: GradientButton!
    @IBOutlet weak var claimPointListTableView: UITableView!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
    @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    @IBOutlet var searchPointsArrayTF: UITextField!
    @IBOutlet var searchview: UIView!
    var fromSideMenu = ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var claimPointsDetailsArray = [ClaimPointsArray]()
    var VM1 = HistoryNotificationsViewModel()
    var VM = MSP_ClaimPointsModel()
    var selectedDealerId = -1
    var enteredQty = 0
    var enteredRemarks = ""
    var enteredProductCode = ""
    var newproductArray: [[String:Any]] = []
    var productCode = [String]()
    var quantity = [String]()
    var remarks = [String]()
    var quantityKG = [String]()
    var afterFilteredValue = [String]()
    
    var quantityValue = ""
    var quantityKGValues = ""
    var finalCalcValuess = ""
    var selectedFromDate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.clearTable()
        self.submitBtn.isHidden = true
        self.loaderView.isHidden = true
        self.noDataFoundLbl.isHidden = true
       // self.submitBtn.isHidden = false
        self.claimPointListTableView.register(UINib(nibName: "MSP_ClaimPointsTVC", bundle: nil), forCellReuseIdentifier: "MSP_ClaimPointsTVC")
        self.claimPointListTableView.delegate = self
        self.claimPointListTableView.dataSource = self
        self.claimPointListTableView.estimatedRowHeight = 70
        self.claimPointListTableView.rowHeight = UITableView.automaticDimension
        self.claimPointListTableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(sendToClaimStatus), name: Notification.Name.sendToClaimStatusVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToDashoardApi), name: Notification.Name.goToDashBoardAPI, object: nil)
        
  
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
        clearTable()
        fetchCartDetails()
         self.selectedDealerId = -1
        self.selectDealerlbl.text = "Select Dealer"
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            //self.notificationListApi()
            self.claimPointsApi()
                })
   
    }
    
    @objc func goToDashoardApi() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func sendToClaimStatus() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_ClaimStatusVC") as! MSP_ClaimStatusVC
        //vc.isComingFrom = "ClaimPoints"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func selectDate(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func selectDealerBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectDealerDropDownVC") as? SelectDealerDropDownVC
        vc!.delegate = self
//        vc!.isComeFrom = 6
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        print(selectedDealerId,"ID")
        print(claimPointsDetailsArray.count,"claimsCount")
        if self.selectedDealerId == -1 || self.selectDealerlbl.text == "Select Dealer"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select any dealer..."
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
                
            }
        }else if self.selectedFromDate == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please select purchase date..."
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
                
            }
        }else if self.claimPointsDetailsArray.count == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter quantiy"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
                
            }
        }else if self.claimPointsDetailsArray.count != 0{
                self.claimPointsSubmissionApi()
            }
        }
    
    @IBAction func searchByEditingTFAct(_ sender: Any) {
        if self.searchPointsArrayTF.text!.count != 0 || self.searchPointsArrayTF.text ?? "" != ""{
            if self.VM.myClaimsPointsArray.count > 0 {
                let arr = self.VM.myClaimsPointsArray.filter{ ($0.productName!.localizedCaseInsensitiveContains(self.searchPointsArrayTF.text!))}
                print(arr.count,"dsds")
                if self.searchPointsArrayTF.text! != ""{
                    if arr.count > 0 {
                        self.VM.myClaimsPointsArray.removeAll(keepingCapacity: true)
                        print(VM.myClaimsPointsArray.count,"jshdhs")
                        self.VM.myClaimsPointsArray = arr
                        self.claimPointListTableView.reloadData()
                        self.claimPointListTableView.isHidden = false
                        noDataFoundLbl.isHidden = true
                    }else {
                        self.VM.myClaimsPointsArray = self.VM.myClaimsPointsArray
                        self.claimPointListTableView.reloadData()
                        self.claimPointListTableView.isHidden = true
                        noDataFoundLbl.isHidden = false
                    }
                }else{
                    self.VM.myClaimsPointsArray = self.VM.myClaimsPointsArray
                    self.claimPointListTableView.reloadData()
                    claimPointListTableView.isHidden = true
                    noDataFoundLbl.isHidden = false
                }
                let searchText = self.searchPointsArrayTF.text!
                if searchText.count > 0 || self.VM.myClaimsPointsArray.count == self.VM.myClaimsPointsArray.count {
                   // self.VM.myClaimsPointsArray.removeAll()
                    self.claimPointListTableView.reloadData()
                   // self.claimPointsApi()
                }
            }
        }else{
            self.VM.myClaimsPointsArray.removeAll()
            self.claimPointListTableView.reloadData()
            //self.itsFrom = "Category"
            self.claimPointsApi()
            noDataFoundLbl.isHidden = true
        }
        
        
    }
    func claimPointsApi(){
        self.VM.myClaimsPointsArray.removeAll()
        let parameters = [
            "ActorId": "\(userID)",
            "ProductDetails": [
                "ActionType" : "19"
            ]
        ] as [String : Any]
        print(parameters)
        self.VM.claimPointsAPI(parameters: parameters) { response in
            self.VM.myClaimsPointsArray = response?.lsrProductDetails ?? []
            print(self.VM.myClaimsPointsArray.count, "Planner List Cout")
            DispatchQueue.main.async {
                if self.VM.myClaimsPointsArray.count != 0 {
                    self.claimPointListTableView.isHidden = false
                    self.noDataFoundLbl.isHidden = true
                    self.claimPointListTableView.reloadData()
                    
                }else{
                    self.claimPointListTableView.isHidden = true
                    self.noDataFoundLbl.isHidden = false
                }
                self.loaderView.isHidden = true
                self.stopLoading()
            }
        }
    }
    
    func totalValues(){
        self.newproductArray.removeAll()
        for data in self.claimPointsDetailsArray{
            print(data.qunantity!)
            if Int(data.qunantity ?? "") ?? 0 > 0 {
                let collectedValues:[String:Any] = [
                    "Cat1": "\(data.productId ?? "")",
                    "Quantity": "\(data.qunantity ?? "")",
                    "Remarks": "\(data.remarks ?? "")"
                ]
                self.newproductArray.append(collectedValues)
            }
                
        }
    }
    
    func claimPointsSubmissionApi(){
        self.totalValues()
        let parameters = [
            "ActorId": "\(self.userID)",
            "ProductSaveDetailList": self.newproductArray as [[String: Any]],
            "RitailerId": self.selectedDealerId,
            "SourceDevice": 1,
            "TranDate": "\(self.selectedFromDate)"
        ]as [String : Any]
        print(parameters)
        self.VM.claimPointsSubmissionApi(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.loaderView.isHidden = true
                self.stopLoading()
                print(response?.returnMessage ?? "", "Return Message")
                if response?.returnMessage ?? "" == "1"{
                    
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ClaimPointsPopUpVC") as! MSP_ClaimPointsPopUpVC
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                }else{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.itsComeFrom = "ClaimPointsSubmission"
                        vc!.descriptionInfo = "Claim points submission failed. Try again later!"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                        
                    }
                }
                
            }
        }
    }
    
    func notificationListApi(){
        let parameters = [
            "ActionType": 0,
            "ActorId": "\(userID)",
            "LoyaltyId": self.loyaltyId
        ] as [String: Any]
        print(parameters)
        self.VM1.notificationListApi(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.loaderView.isHidden = true
                self.stopLoading()
                self.VM1.notificationListArray = response?.lstPushHistoryJson ?? []
                print(self.VM1.notificationListArray.count)
                
                
                if self.VM1.notificationListArray.count > 0{
                    self.countLbl.text = "\(self.VM1.notificationListArray.count)"
                }else{
                    self.countLbl.isHidden = true
                }
                
            }
        }
        
    }
    
    

 
    func playAnimation(){
                   animationView11 = .init(name: "Loader_v4")
                     animationView11!.frame = loaderAnimatedView.bounds
                     // 3. Set animation content mode
                     animationView11!.contentMode = .scaleAspectFit
                     // 4. Set animation loop mode
                     animationView11!.loopMode = .loop
                     // 5. Adjust animation speed
                     animationView11!.animationSpeed = 0.5
                    loaderAnimatedView.addSubview(animationView11!)
                     // 6. Play animation
                     animationView11!.play()

               }
    
}
extension MSP_ClaimPointsVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.myClaimsPointsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_ClaimPointsTVC") as? MSP_ClaimPointsTVC
        cell?.delegate = self
        cell?.selectionStyle = .none
        cell?.productNameLbl.text = VM.myClaimsPointsArray[indexPath.row].cat_Name1 ?? "-"
        print(self.VM.myClaimsPointsArray[indexPath.row].cat_Name1 ?? "", "Product Name ds;fkhdfklghdj;v")
        cell?.qtyTF.tag = VM.myClaimsPointsArray[indexPath.row].cat_Id1 ?? -1
        //cell?.qtyKGTF.tag = VM.myClaimsPointsArray[indexPath.row].cat_Id1 ?? -1
        cell?.remarksTF.tag = VM.myClaimsPointsArray[indexPath.row].cat_Id1 ?? -1
      
        
               cell?.qtyTF.text = ""
               cell?.remarksTF.text = ""
             //  cell?.qtyKGTF.text = ""
        for selectedArray in claimPointsDetailsArray{
            if self.claimPointsDetailsArray.count != 0 {
                print("\(VM.myClaimsPointsArray[indexPath.row].cat_Id1 ?? -1)")
                print("\(selectedArray.productId ?? "-1")")
                if selectedArray.productId! == "\(VM.myClaimsPointsArray[indexPath.row].cat_Id1 ?? -1)"{
                    cell?.qtyTF.text = selectedArray.qunantity
                    cell?.remarksTF.text = selectedArray.remarks
                   // cell?.qtyKGTF.text = selectedArray.quantityKG
                }
            }

        }
        
        
        let imageUrl = String(self.VM.myClaimsPointsArray[indexPath.row].cat_Image1 ?? "").dropFirst(1)
      //  cell?.productImage.sd_setImage(with: URL(string: "\(PROMO_IMG1)\(receivedImage)"), placeholderImage: UIImage(named: "appLogo"))
      //  let imageUrl = VM.myClaimsPointsArray[indexPath.row].brandImg ?? ""
        if imageUrl != " " || imageUrl != "" || imageUrl != nil{
            let totalImgURL = PROMO_IMG1 + imageUrl
            let productImage = totalImgURL.replacingOccurrences(of: " ", with: "%20")
            cell?.productImage.sd_setImage(with: URL(string: productImage), placeholderImage: UIImage(named: "appLogo"))
        }else{
            cell?.productImage.image = UIImage(named: "MSP-logo (1)")
        }
        
        
        return cell!
    }
    func fetchCartDetails(){
        self.claimPointsDetailsArray.removeAll()
        let fetchRequest:NSFetchRequest<ClaimPointsArray> = ClaimPointsArray.fetchRequest()
        do{
            self.claimPointsDetailsArray = try persistanceservice.context.fetch(fetchRequest)
            print(self.claimPointsDetailsArray.count, "Saved Data")
            if self.claimPointsDetailsArray.count == 0{
                self.submitBtn.isHidden = true
                
            }else{
                self.submitBtn.isHidden = false
            }
            self.claimPointListTableView.reloadData()
        }catch{
            print("error while fetching data")
        }
        
    }
    func clearTable(){
        
        let context = persistanceservice.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ClaimPointsArray")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}
