//
//  MSP_WishlistListingVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 22/11/2022.
//

import UIKit
import SDWebImage
import Firebase
import Lottie
class MSP_WishlistListingVC: BaseViewController, RedemptionPlannerDelegate, popUpDelegate{

    
    
  //  @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var WishlistTableView: UITableView!
    @IBOutlet var emptyWhishListView: UIView!
    //@IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var notificationCountLbl: UILabel!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
    @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    
    var VM = RedemptionPlannerListViewModel()
    var pointBalance = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var selectedPlannerID = 0
    var totalCartValue = 0
    var catalogueID = 0
    var fromSideMenu = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.WishlistTableView.delegate = self
        self.WishlistTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(checkVerificationStatus), name: Notification.Name.verificationStatus, object: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.loaderView.isHidden = true
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Wishlist Listing")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        
        self.plannerListing()
        self.myCartList()
       // self.notificationListApi()
    }

    @objc func checkVerificationStatus(){
           DispatchQueue.main.async{
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
               vc!.delegate = self
               vc!.titleInfo = ""
               vc!.itsComeFrom = "AccountVerification"
               vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
               vc!.modalPresentationStyle = .overCurrentContext
               vc!.modalTransitionStyle = .crossDissolve
               self.present(vc!, animated: true, completion: nil)
           }
       }
    @IBAction func backBtn(_ sender: Any) {
//        if self.fromSideMenu == "SideMenu"{
//            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
//            self.navigationController?.popViewController(animated: true)
//        }else{
        self.navigationController?.popToRootViewController(animated: true)
//        }
    }
//    @IBAction func notificationBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    //Delegaet:-
    func producDetails(_ cell: MSP_WishListTVC) {
        
        guard let tappedIndex = WishlistTableView.indexPath(for: cell) else{return}
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistDetailsVC") as! MSP_WishlistDetailsVC
        vc.productImage = self.VM.myPlannerListArray[tappedIndex.row].productImage ?? ""
//        vc.tdspercentage1 = Double(self.VM.myPlannerListArray[tappedIndex.row].tDSPercentage ?? 0)
//        print(vc.tdspercentage1,"%%Points")
      //  vc.applicabletds = Double(self.VM.myPlannerListArray[tappedIndex.row].applicableTds ?? 0)
        vc.productName = self.VM.myPlannerListArray[tappedIndex.row].productName ?? ""
        vc.productPoints = self.VM.myPlannerListArray[tappedIndex.row].pointsRequired ?? 0
        vc.selectedPlannerID = self.VM.myPlannerListArray[tappedIndex.row].redemptionPlannerId ?? 0
        vc.selectedCatalogueID = self.VM.myPlannerListArray[tappedIndex.row].catalogueId ?? 0
        vc.averageLesserDate = self.VM.myPlannerListArray[tappedIndex.row].avgLesserExpDate ?? ""
        vc.redeemableAverageEarning = self.VM.myPlannerListArray[tappedIndex.row].redeemableAverageEarning ?? ""
        vc.dateOfSubmission = self.VM.myPlannerListArray[tappedIndex.row].achievementDateMonthWize ?? ""
        //vc.isRedeem = self.VM.myPlannerListArray[tappedIndex.row].is_Redeemable ?? 0
        let calcValue =  ((self.VM.myPlannerListArray[tappedIndex.row].pointsRequired ?? 0) - (Int(pointBalance) ?? 0))
        print(calcValue)
        vc.requiredPoints = calcValue
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func removeProduct(_ cell: MSP_WishListTVC) {
        guard let tappedIndex = WishlistTableView.indexPath(for: cell) else{return}
        if cell.removeProductBTN.tag == tappedIndex.row{
            self.selectedPlannerID = self.VM.myPlannerListArray[tappedIndex.row].redemptionPlannerId ?? -1
            self.removeProductInPlanner()
        }
        
    }
    func productRedeem(_ cell: MSP_WishListTVC) {
        self.selectedPlannerID = -1
        guard let tappedIndex = WishlistTableView.indexPath(for: cell) else{return}
        if cell.productRedeemBTN.tag == tappedIndex.row{
            let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.myPlannerListArray[tappedIndex.row].catalogueId ?? 0}
            if filterCategory.count > 0{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Product is already added in the Redeem list"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                if self.totalCartValue < Int(self.pointBalance) ?? 0 {
                    let calcValue = self.totalCartValue + Int(self.VM.myPlannerListArray[tappedIndex.row].pointsRequired!) + Int(self.VM.myPlannerListArray[tappedIndex.row].applicableTds ?? 0.0)
                    if calcValue <= Int(self.pointBalance) ?? 0{
                        self.selectedPlannerID = self.VM.myPlannerListArray[tappedIndex.row].catalogueId ?? 0
                        if self.verifiedStatus != 1{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                            
                        }else{
                            self.addToCartApi()
                        }

                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                                vc!.descriptionInfo = "Insufficent Point Balance"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }
                }else{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                            vc!.descriptionInfo = "Insufficent Point Balance"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
             
            }
            
            
            self.WishlistTableView.reloadData()
        }
    }
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
    @IBAction func addToCatalogeBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ProductCatalogueVC") as! MSP_ProductCatalogueVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notificationActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //Api:-
    
    func plannerListing(){
        self.VM.myCartListArray.removeAll()
        let parameters = [
            "ActionType": "6",
            "ActorId": "\(userID)"
        ] as [String : Any]
        print(parameters)
        self.VM.plannerListingApi(parameters: parameters) { response in
            self.VM.myPlannerListArray = response?.objCatalogueList ?? []
            print(self.VM.myPlannerListArray.count, "Planner List Cout")
            
              
                if self.VM.myPlannerListArray.count != 0 {
                    DispatchQueue.main.async {
                        self.loaderView.isHidden = true
                        self.stopLoading()
                        self.WishlistTableView.isHidden = false
                        self.emptyWhishListView.isHidden = true
                        //self.noDataFoundLbl.isHidden = true
                        self.WishlistTableView.reloadData()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.loaderView.isHidden = true
                        self.stopLoading()
                        self.WishlistTableView.isHidden = true
                        self.emptyWhishListView.isHidden = false
                       //self.noDataFoundLbl.isHidden = false
                    }
                }
                
            }
        
    }
    
    func addToCartApi(){
        let parameters = [
            "ActionType": "1",
              "ActorId": "\(userID)",
              "CatalogueSaveCartDetailListRequest": [
                  [
                      "CatalogueId": "\(selectedPlannerID)",
                      "DeliveryType": "1",
                      "NoOfQuantity": "1"
                  ]
              ],
              "LoyaltyID": "\(loyaltyId)",
              "MerchantId": "1"
        ] as [String: Any]
        print(parameters)
        self.VM.addToCart(parameters: parameters) { response in
          print(response?.returnValue ?? 0, "Added TO Cart")
            
            if response?.returnValue == 1{
                DispatchQueue.main.async{
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyCartVC") as! MSP_MyCartVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                        vc!.descriptionInfo = "Something went wrong please try again later."
                   
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
            DispatchQueue.main.async {
                self.loaderView.isHidden = true
                self.stopLoading()
            }
            
        }
        
    }
    func removeProductInPlanner(){
        let parameters = [
            "ActionType": 17,
            "ActorId": "\(userID)",
            "RedemptionPlannerId": "\(selectedPlannerID)"
        ] as [String: Any]
        print(parameters)
        self.VM.removePlannedProduct(parameters: parameters) { response in
//            let result = response?.returnValue ?? 0
//            print(result)
            if response?.returnValue == 1{
                self.plannerListing()
                self.loaderView.isHidden = true
                self.stopLoading()
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                        vc!.descriptionInfo = "Something went wrong please try again later."
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }
            
        }
    }
    
    func myCartList(){
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myCartList(parameters: parameters) { response in
            self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
            print(self.VM.myCartListArray.count)
            
            DispatchQueue.main.async {
                for data in self.VM.myCartListArray{
                    self.totalCartValue = Int(data.sumOfTotalPointsRequired ?? 0)
                    print(self.totalCartValue, "TotalValue")
                }
                

                self.WishlistTableView.reloadData()
                self.loaderView.isHidden = true
                self.stopLoading()
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
            self.VM1.notificationListArray = response?.lstPushHistoryJson ?? []
            print(self.VM1.notificationListArray.count)
            if self.VM1.notificationListArray.count > 0{
                self.notificationCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notificationCountLbl.isHidden = true
            }
            if self.VM1.notificationListArray.count != 0 {
                DispatchQueue.main.async {
//                    self.notificationListTableView.isHidden = false
//                    self.noDataFoundLbl.isHidden = true
//                    self.notificationListTableView.reloadData()
                }
            }else{
//                self.noDataFoundLbl.isHidden = false
//                self.notificationListTableView.isHidden = true
                
            }
        }
        
    }
    
    func verifyAdhaarExistencyApi(){
        
        let parameter = [
            "ActionType": 154,
            "ActorId": self.userID
        ] as [String: Any]
        print(parameter)
        self.VM.adhaarNumberExistsApi(parameters: parameter) { response in
            
            let result = response?.lstAttributesDetails ?? []
            
            if result.count != 0 {
                let sortedValues = String(result[0].attributeValue ?? "").split(separator: ":")
                print(sortedValues[0], "asdfsadfas")
                print(self.verifiedStatus)
                if sortedValues[0] == "1"{
                    if self.verifiedStatus != 1{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                        
                    }else{
                        self.addToCartApi()
                    }
                    
                }else{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        
                        vc!.descriptionInfo = "\(sortedValues[1])"
                        
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                        self.loaderView.isHidden = true
                        self.stopLoading()
                    }
                }
            }
        }
    }
}
extension MSP_WishlistListingVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myPlannerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_WishListTVC") as! MSP_WishListTVC
        cell.delegate = self
        cell.selectionStyle = .none
        let receivedImage = self.VM.myPlannerListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
     //   cell.categoryLbl.text = VM.myPlannerListArray[indexPath.row].catogoryName ?? ""
        cell.productNameLabel.text  = self.VM.myPlannerListArray[indexPath.row].productName ?? ""
        cell.desireDateLabel.text = self.VM.myPlannerListArray[indexPath.row].achievementDateMonthWize ?? ""
        cell.pointsLabel.text = "\(Double(self.VM.myPlannerListArray[indexPath.row].pointsRequired ?? 0))"
        cell.removeProductBTN.tag = indexPath.row
        cell.details.tag = indexPath.row
        cell.productRedeemBTN.tag = indexPath.row
        
        if (self.VM.myPlannerListArray[indexPath.row].pointsRequired ?? 0) > Int(pointBalance) {
            //cell.productRedeemBTN.isEnabled = false
            cell.productRedeemBTN.backgroundColor = .lightGray
        }else{
              //  cell.productRedeemBTN.isEnabled = true
            cell.productRedeemBTN.backgroundColor = .red
            }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
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
