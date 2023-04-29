//
//  ViewController.swift
//  MSP_Customer
//
//  Created by ADMIN on 18/11/2022.
//

import UIKit
import SDWebImage
import Firebase
import Lottie
class MSP_ProductCatalogueVC: BaseViewController, AddedToCartOrPlannerDelegate, popUpDelegate, SendDataDelegate {
    func moveToProductList(_ vc: MSP_ProductCatalogueDetailsVC) {
        self.itsComeFrom = vc.itsComeFrom
        self.selectedPtsRange = vc.selectedPtsRange
        self.categoryId = vc.categoryId
        self.VM.redemptionCatalogueArray.removeAll()
        self.startIndex = 1
    }
    
    @IBOutlet weak var selectdCategoryTitleLbl: UILabel!
    @IBOutlet weak var selectedCategoryLbl: UILabel!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var redeemablePts: UILabel!
    @IBOutlet var catalogueCollectionView: UICollectionView!
    @IBOutlet var productTableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var highToLowBtn: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var pointsRangeButton: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var totalPts: UILabel!
    
    @IBOutlet weak var goToCartBtn: GradientButton!
    @IBOutlet weak var collectionViewTopSPace: NSLayoutConstraint!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var VM = RedemptionsCatalogueListViewModel()
    var searchText = ""
    var categoryId = -1
    //let pointBalance = UserDefaults.standard.value(forKey: "RedeemablePointBalance")
    var pointBalance = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    //let pointBalance = UserDefaults.standard.value(forKey: "RedeemablePointBalance")
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var productCategoryListArray = [ProductCateogryModels]()
    var selectedCatalogueID = 0
    var totalCartValue = 0
    var selectedPlannerID = 0
    var fromSideMenu = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var selectedPtsRange = ""
    var selectedPtsRange1 = "All Points"
    var filterByRangeArray = ["All Points", "Under 1000 pts", "1000 - 4999 pts", "5000 - 24999 pts", "25000 & Above pts"]
    var filterByRangeValuesArray = [FilterByPointRangeModels]()
    var sortedBy = 0
    var itsFrom = "Search"
    var parameters : JSON?
    var noofelements = 0
    var startIndex = 1
    var searchTab = 1
    var categoriesId = 0
    var noOfRows = 0
    var itsComeFrom = ""
    var selectedCategoryName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        print(self.pointBalance)
        self.VM.redemptionCategoryArray.removeAll()
        self.VM.redemptionCatalogueArray.removeAll()
        self.redeemablePts.text = "\(pointBalance)"
        self.searchTab = 1
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        self.catalogueCollectionView.delegate = self
        self.catalogueCollectionView.dataSource = self
        self.collectionViewHeight.constant = 0
        self.tableViewTopConstraint.constant = 5
        self.searchView.isHidden = false
        self.searchViewHeight.constant = 45
        self.noDataFound.isHidden = true
        self.subView.isHidden = true
        self.highToLowBtn.isHidden = true
        self.collectionViewTopSPace.constant = 55
        self.highToLowBtn.setTitle("Low To High", for: .normal)
        self.selectedCategoryLbl.isHidden = true
        self.selectdCategoryTitleLbl.isHidden = true
//        self.redemptionCategoryList()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true

        self.VM.redemptionCataloguesArray.removeAll()
        self.redemptionCategoryList()
       
        self.plannerListing()
        self.myCartList()
     //   self.notificationListApi()
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Product Catalogue")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        
        //        if self.itsFrom == "Category"{
        //            self.searchButton.backgroundColor = .lightGray
        //            self.categoryButton.backgroundColor = .red
        //            self.pointsRangeButton.backgroundColor = .lightGray
        //            self.collectionViewTopSPace.constant = 10
        //            self.collectionViewHeight.constant = 60
        //            self.catalogueCollectionView.isHidden = false
        //            self.tableViewTopConstraint.constant = 5
        //            self.highToLowBtn.isHidden = true
        //            self.searchView.isHidden = true
        //            self.searchViewHeight.constant = 0
        //            self.redemptionCategoryList()
        //        }else if self.itsFrom == "PtsRange"{
        //            self.filterByRangeValuesArray.removeAll()
        //            self.searchButton.backgroundColor = .lightGray
        //            self.categoryButton.backgroundColor = .lightGray
        //            self.pointsRangeButton.backgroundColor = .red
        //            self.collectionViewHeight.constant = 60
        //            self.catalogueCollectionView.isHidden = false
        //            self.tableViewTopConstraint.constant = 50
        //            self.collectionViewTopSPace.constant = 10
        //            self.highToLowBtn.isHidden = false
        //            self.searchView.isHidden = true
        //            self.searchViewHeight.constant = 0
        //            self.VM.redemptionCategoryArray.removeAll()
        //            self.productCategoryListArray.removeAll()
        //            self.catalogueCollectionView.reloadData()
        //            self.redemptionCatalogueList()
        //        }else if self.itsFrom == "Search"{
        //            self.searchButton.backgroundColor = .red
        //            self.categoryButton.backgroundColor = .lightGray
        //            self.pointsRangeButton.backgroundColor = .lightGray
        //            self.collectionViewHeight.constant = 0
        //            self.catalogueCollectionView.isHidden = true
        //            self.tableViewTopConstraint.constant = 5
        //            self.highToLowBtn.isHidden = true
        //            self.searchView.isHidden = false
        //            self.searchViewHeight.constant = 45
        //            self.collectionViewTopSPace.constant = 55
        //            self.redemptionCatalogueList()
        //        }
    }
    
    
  
    @IBAction func goToCartBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyCartVC") as! MSP_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cartViewBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyCartVC") as! MSP_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notificationBtn(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func highToLowButton(_ sender: Any) {
        
        if self.sortedBy == 1{
            self.sortedBy = 0
            self.highToLowBtn.setTitle("High To Low", for: .normal)
        }else{
            self.sortedBy = 1
            self.highToLowBtn.setTitle("Low To High", for: .normal)
        }
        self.VM.redemptionCatalogueArray.removeAll()
        self.startIndex = 1
        self.redemptionCatalogueList(startIndex: self.startIndex)
    }
    @IBAction func searchBtn(_ sender: Any) {
        self.searchButton.backgroundColor = .red
        self.categoryButton.backgroundColor = .lightGray
        self.pointsRangeButton.backgroundColor = .lightGray
        self.collectionViewHeight.constant = 0
        self.catalogueCollectionView.isHidden = true
        self.tableViewTopConstraint.constant = 5
        self.highToLowBtn.isHidden = true
        self.searchView.isHidden = false
        self.searchViewHeight.constant = 45
        self.collectionViewTopSPace.constant = 55
        self.itsFrom = "Search"
        self.searchTF.text = ""
        self.startIndex = 1
        self.searchTab = 1
        self.categoriesId = 0
        self.sortedBy = 0
        self.highToLowBtn.setTitle("Low To High", for: .normal)
        self.VM.redemptionCategoryArray.removeAll()
        self.VM.redemptionCatalogueArray.removeAll()
        self.redemptionCatalogueList(startIndex: self.startIndex)
    }
    @IBAction func categoryBtn(_ sender: Any) {
        //self.VM.redemptionCatalogueArray.removeAll()
//        if self.searchTab == 1{
//            self.categoryId = -1
//            self.selectedPtsRange = ""
//            self.searchTab = 0
//
//            self.startIndex = 1
//        }
        self.highToLowBtn.setTitle("Low To High", for: .normal)
        self.itsFrom = "Category"
        self.selectedPtsRange1 = "All Points"
        self.selectedPtsRange = ""
        //self.filterByRangeArray.removeAll()
        self.VM.redemptionCategoryArray.removeAll()
        self.VM.redemptionCatalogueArray.removeAll()
//        self.filterByRangeArray.removeAll()
        self.searchButton.backgroundColor = .lightGray
        self.categoryButton.backgroundColor = .red
        self.pointsRangeButton.backgroundColor = .lightGray
        self.collectionViewTopSPace.constant = 10
        self.collectionViewHeight.constant = 50
        self.catalogueCollectionView.isHidden = false
        self.tableViewTopConstraint.constant = 5
        self.highToLowBtn.isHidden = true
        self.searchView.isHidden = true
        self.searchViewHeight.constant = 0
        self.categoriesId = 1
        self.startIndex = 1
        self.searchTab = 0
        self.redemptionCategoryList()
        //self.redemptionCatalogueList(startIndex: 1)
    }
    
    @IBAction func pointRangeBtn(_ sender: Any) {
        self.selectedCategoryLbl.isHidden = true
        self.selectdCategoryTitleLbl.isHidden = true
        if self.selectedCategoryName != "All"{
            self.selectedCategoryLbl.isHidden = false
            self.selectdCategoryTitleLbl.isHidden = false
            self.selectdCategoryTitleLbl.text = self.selectedCategoryName
        }else{
            self.selectedCategoryLbl.isHidden = true
            self.selectdCategoryTitleLbl.isHidden = true
        }
       
        self.filterByRangeValuesArray.removeAll()
        self.searchButton.backgroundColor = .lightGray
        self.categoryButton.backgroundColor = .lightGray
        self.pointsRangeButton.backgroundColor = .red
        self.collectionViewHeight.constant = 60
        self.catalogueCollectionView.isHidden = false
        self.tableViewTopConstraint.constant = 50
        self.collectionViewTopSPace.constant = 10
        self.highToLowBtn.isHidden = false
        self.searchView.isHidden = true
        self.searchViewHeight.constant = 0
        self.itsFrom = "PtsRange"
        self.startIndex = 1
        self.VM.redemptionCategoryArray.removeAll()
       // self.productCategoryListArray.removeAll()
        self.VM.redemptionCatalogueArray.removeAll()
        self.catalogueCollectionView.reloadData()
        self.categoriesId = 2
        self.searchTab = 0
        self.redemptionCatalogueList(startIndex: 1)
    }
    
    @IBAction func searchByEditingChanged(_ sender: Any) {
        
        if self.searchTF.text!.count != 0 || self.searchTF.text ?? "" != ""{
            if self.VM.redemptionCatalogueArray.count > 0 {
                let arr = self.VM.redemptionCatalogueArray.filter{ ($0.productName!.localizedCaseInsensitiveContains(self.searchTF.text!))}
                print(arr.count,"skdjhkdsjh")
                if self.searchTF.text! != ""{
                    if arr.count > 0 {
                        self.VM.redemptionCatalogueArray.removeAll(keepingCapacity: true)
                        print(VM.redemptionCatalogueArray.count,"jshdhs")
                        self.VM.redemptionCatalogueArray = arr
                        self.productTableView.reloadData()
                        self.productTableView.isHidden = false
                        self.noDataFound.isHidden = true
                    }else {
                        self.VM.redemptionCatalogueArray = self.VM.productsArray
                        self.productTableView.reloadData()
                        self.productTableView.isHidden = true
                        self.noDataFound.isHidden = false
                    }
                }else{
                    self.VM.redemptionCatalogueArray = self.VM.productsArray
                    self.productTableView.reloadData()
                    productTableView.isHidden = false
                    noDataFound.isHidden = true
                }
                let searchText = self.searchTF.text!
                if searchText.count > 0 || self.VM.redemptionCatalogueArray.count == self.VM.productsArray.count {
                    self.productTableView.reloadData()
                }
            }
        }else{
            self.itsFrom = "Search"
            self.VM.redemptionCatalogueArray.removeAll()
            self.startIndex = 0
            self.searchTab = 1
            self.redemptionCatalogueList(startIndex: self.startIndex)
            noDataFound.isHidden = true
            self.productTableView.reloadData()
        }
    }
    //Delegate:-
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func addToCart(_ cell: Products_TVC) {
        guard let tappedIndex = productTableView.indexPath(for: cell) else{return}
        if cell.addToCartButton.tag == tappedIndex.row{
            print(self.pointBalance, "Point Balance")
            print(self.totalCartValue, "totalCartValue")
            let filterArray = self.VM.myCartListArray.filter{$0.catalogueId == self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0}
            
            if filterArray.count > 0{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Already! Product has been added into cart"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                if self.totalCartValue < Int(self.pointBalance) ?? 0 {
                    let calcValue = self.totalCartValue + Int(self.VM.redemptionCatalogueArray[tappedIndex.row].pointsRequired!)
                    if calcValue <= Int(self.pointBalance) ?? 0{
                        self.selectedCatalogueID = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
                        if self.verifiedStatus != 1{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "You are not allowed to redeem. Please contact your adminstration"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            if self.VM.redemptionCatalogueArray[tappedIndex.row].is_Redeemable ?? 0 == 1{
                                addToCartApi()
                            }else{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.descriptionInfo = "You are not allowed to redeem. Please contact your adminstration"
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.present(vc!, animated: true, completion: nil)
                                }
                            }
                            
                        }
                       
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Insufficient redeemable balance!"
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
                        vc!.descriptionInfo = "Insufficient redeemable balance!"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
            }
          
            self.productTableView.reloadData()
        }
        
    }
    func detailsDidTap(_ cell: Products_TVC) {
        guard let tappedIndex = productTableView.indexPath(for: cell) else{return}
        if cell.detailsButton.tag == tappedIndex.row{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ProductCatalogueDetailsVC") as! MSP_ProductCatalogueDetailsVC
            vc.isComeFrom = "Catalogue"
            vc.delegate = self
            vc.productImage = self.VM.redemptionCatalogueArray[tappedIndex.row].productImage ?? ""
            vc.prodRefNo = self.VM.redemptionCatalogueArray[tappedIndex.row].redemptionRefno ?? ""
            vc.productCategory = self.VM.redemptionCatalogueArray[tappedIndex.row].catogoryName ?? ""
            vc.productName = self.VM.redemptionCatalogueArray[tappedIndex.row].productName ?? ""
            vc.productPoints = "\(self.VM.redemptionCatalogueArray[tappedIndex.row].pointsRequired ?? 0)"
            vc.productDetails = self.VM.redemptionCatalogueArray[tappedIndex.row].productDesc ?? ""
            vc.termsandContions = self.VM.redemptionCatalogueArray[tappedIndex.row].termsCondition ?? ""
            vc.selectedCatalogueID = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
            vc.catalogueId = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
            vc.selectedPtsRange = self.selectedPtsRange
            vc.categoryId = self.categoryId
            //                vc.tdspercentage1 = self.VM.redemptionCatalogueArray[indexPath.row].TDSPercentage ?? 0.0
            //                vc.applicabletds = self.VM.redemptionCatalogueArray[indexPath.row].ApplicableTds ?? 0.0
            vc.isPlanner = self.VM.redemptionCatalogueArray[tappedIndex.row].isPlanner
            print(self.VM.redemptionCatalogueArray[tappedIndex.row].isPlanner!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func addToPlanner(_ cell: Products_TVC) {
        guard let tappedIndex = productTableView.indexPath(for: cell) else{return}
        self.selectedPlannerID = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
        cell.wishPlannerOutBTN.setImage(UIImage(named: "heart-4"), for: .normal)
        self.addedToPlanner()
        self.productTableView.reloadData()
    }
    
    func redemptionCatalogueList(startIndex: Int){
        self.parameters?.removeAll()
        
        print(self.itsFrom, "Its Come From")
        
        if self.searchTab == 1{
            if self.itsFrom == "Search"{
                   self.VM.redemptionCatalogueArray.removeAll()
                self.startIndex = 0
                self.noOfRows = 0
            }
         
            self.parameters = [
                "ActionType": "6",
                "ActorId": "\(self.userID)",
                "ObjCatalogueDetails": [
                    "MerchantId": 1,
                    "CatogoryId": -1,
                    "MultipleRedIds":"" // use this tag to send points range
                ],
                "SearchText": "\(self.searchTF.text ?? "")",
                "Sort": self.sortedBy, // send 1 or zero here from low to high or high to low sorting
                "Domain": "JSW", // Domain is mandatory to send
                "NoOfRows": self.noOfRows,
                "StartIndex": startIndex
                
            ] as [String: Any]
            print(parameters!, "sdfasdfsadfsdafdsaf")
        }else{
//            if itsComeFrom == "Details" {
//                self.VM.redemptionCatalogueArray.removeAll()
//            }
            self.parameters = [
                "ActionType": "6",
                "ActorId": "\(self.userID)",
                "ObjCatalogueDetails": [
                    "MerchantId": 1,
                    "CatogoryId": self.categoryId,
                    "MultipleRedIds":self.selectedPtsRange // use this tag to send points range
                ],
                "SearchText": "\(self.searchTF.text ?? "")",
                "Sort": self.sortedBy, // send 1 or zero here from low to high or high to low sorting
                "Domain": "JSW", // Domain is mandatory to send
                "NoOfRows": 20,
                "StartIndex": startIndex
                
            ] as [String: Any]
            print(parameters!, "FilterBy text")
        }
        
        self.VM.redemptionCatalogue(parameters: self.parameters!)
       // self.itsComeFrom = ""
        self.productTableView.reloadData()
    }
    
    func addToCartApi(){
        let parameters = [
            "ActionType": "1",
            "ActorId": "\(userID)",
            "CatalogueSaveCartDetailListRequest": [
                [
                    "CatalogueId": "\(selectedCatalogueID)",
                    "DeliveryType": "1",
                    "NoOfQuantity": "1"
                ]
            ],
            "LoyaltyID": "\(loyaltyId)",
            "MerchantId": "1"
        ] as [String: Any]
        print(parameters)
        self.VM.addToCart(parameters: parameters) { response in
            if response?.returnValue == 1{
                DispatchQueue.main.async{
                    self.myCartList()
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Product has been added to Cart"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Something went wrong!"
                    
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
    
    func redemptionCategoryList(){
        let parameters = [
            "ActionType": "1",
            "ActorId": "\(userID)",
            "IsActive": 1
        ] as [String: Any]
        print(parameters)
        
        self.VM.redemptionCateogry(parameters: parameters)
        self.catalogueCollectionView.reloadData()
    }
    
    func myCartList(){
        self.VM.myCartListArray.removeAll()
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myCartList(parameters: parameters) { response in
            self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
            
            if self.VM.myCartListArray.count > 0 {
                self.cartCountLbl.isHidden = false
                self.cartCountLbl.text = "\(self.VM.myCartListArray.count)"
            }else{
                self.cartCountLbl.isHidden = true
            }
            
            DispatchQueue.main.async {
                for data in self.VM.myCartListArray{
                    self.totalCartValue = Int(data.sumOfTotalPointsRequired ?? 0.0)
                    print(self.totalCartValue, "Total CartValue")
                    
                }
                self.productTableView.reloadData()
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
        self.VM.notificationListApi(parameters: parameters) { response in
            self.VM.notificationListArray = response?.lstPushHistoryJson ?? []
            print(self.VM.notificationListArray.count)
            if self.VM.notificationListArray.count > 0{
                self.notificationCountLbl.text = "\(self.VM.notificationListArray.count)"
            }else{
                self.notificationCountLbl.isHidden = true
            }
           
        }
        
    }
    
    func plannerListing(){
        self.VM.myPlannerListArray.removeAll()
        let parameters = [
            "ActionType": "6",
            "ActorId": "\(userID)"
        ] as [String : Any]
        print(parameters)
        self.VM.plannerListingApi(parameters: parameters) { response in
            self.VM.myPlannerListArray = response?.objCatalogueList ?? []
            DispatchQueue.main.async {
                self.loaderView.isHidden = true
                self.stopLoading()
                
//                if self.VM.myPlannerListArray.count > 0 {
//
//                }
            }
        }
        
    }
    func addedToPlanner(){
        let parameters = [
            "ActionType": 0,
            "ActorId": "\(userID)",
            "ObjCatalogueDetails": [
                "CatalogueId": "\(selectedPlannerID)"
            ]
        ] as [String: Any]
        print(parameters,"addToPlanner")
        self.VM.addToPlanners(parameters: parameters) { response in
            
            if response?.returnValue ?? 0 >= 1{
                self.redemptionCategoryList()
                //   self.redemptionCatalogueList()
                self.plannerListing()
                
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Product has been added to WishList"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Something went wrong!"
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
}


extension MSP_ProductCatalogueVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.redemptionCatalogueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Products_TVC", for: indexPath) as! Products_TVC
        cell.delegate = self
//        print(self.VM.redemptionCatalogueArray[indexPath.row].tdsPercentage ?? 0.0,"TDS")
//        print(self.VM.redemptionCatalogueArray[indexPath.row].applicableTds ?? 0.0,"Applicable")
        cell.productNameLabel.text = self.VM.redemptionCatalogueArray[indexPath.row].productName ?? ""
        cell.categoryTypeLabel.text = "Category / \(self.VM.redemptionCatalogueArray[indexPath.row].catogoryName ?? "")"
        cell.pointsLabel.text = "\(Double(self.VM.redemptionCatalogueArray[indexPath.row].pointsRequired ?? 0))"
        let receivedImage = self.VM.redemptionCatalogueArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        cell.addToPlanner.tag = indexPath.row
        cell.addToCartButton.tag = indexPath.row
        cell.detailsButton.tag = indexPath.row
        cell.wishPlannerOutBTN.tag = indexPath.row
        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.redemptionCatalogueArray[indexPath.row].catalogueId ?? 0 }
        let filterPlannerList = self.VM.myPlannerListArray.filter { $0.catalogueId == self.VM.redemptionCatalogueArray[indexPath.row].catalogueId ?? 0 }
        let productPoints = self.VM.redemptionCatalogueArray[indexPath.row].pointsRequired ?? 0
        if Int(self.pointBalance) >= productPoints{
         
            if filterCategory.count > 0 {
                cell.addedToCart.isHidden = false
                cell.addedToCart.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                cell.addToPlanner.isHidden = true
                cell.addToCartButton.isHidden = true
                cell.addedToPlanner.isHidden = true
                cell.wishPlannerOutBTN.isHidden = true
            }else{
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = true
                cell.addToCartButton.isHidden = false
                cell.addToCartButton.backgroundColor = #colorLiteral(red: 0.6156862745, green: 0.06274509804, blue: 0.05882352941, alpha: 1)
                cell.addedToPlanner.isHidden = true
                cell.wishPlannerOutBTN.isHidden = true
            }
        }else{
            if self.VM.redemptionCatalogueArray[indexPath.row].isPlanner! == true{
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = false
                cell.addToCartButton.isHidden = true
                cell.addedToPlanner.isHidden = true
                cell.wishPlannerOutBTN.isHidden = true
            }else{
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = true
                cell.addToCartButton.isHidden = true
                cell.addedToPlanner.isHidden = true
                cell.wishPlannerOutBTN.isHidden = true
            }
        }
        if filterPlannerList.count > 0 {
            if Int(pointBalance) > Int(productPoints) {
//                cell.addedToCart.isHidden = true
//                cell.addToPlanner.isHidden = true
//                cell.addToCartButton.isHidden = false
//                cell.addedToPlanner.isHidden = true
//                cell.wishPlannerOutBTN.isHidden = true
            }else{
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = true
                cell.addToCartButton.isHidden = true
                cell.addedToPlanner.isHidden = false
                cell.wishPlannerOutBTN.setImage(UIImage(named: "heart-4"), for: .normal)
                cell.wishPlannerOutBTN.isHidden = false
                
            }
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            if indexPath.row == self.VM.redemptionCatalogueArray.count - 1{
                if self.noofelements == 20{
                    self.startIndex = self.startIndex + 1
                    self.itsFrom = "Pagination"
                    self.redemptionCatalogueList(startIndex: self.startIndex)
                }else if self.noofelements > 20 && self.startIndex == 1{
                    self.startIndex = self.startIndex + 1
                    self.itsFrom = "Pagination"
                    self.redemptionCatalogueList(startIndex: self.startIndex)
                }else if self.noofelements < 20{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }
}
extension MSP_ProductCatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.categoriesId, "Fpsdkfjaksldf")
        if self.categoriesId == 1{
            return self.productCategoryListArray.count
        }else{
            return self.filterByRangeArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Catalogue_CVC", for: indexPath) as! Catalogue_CVC
        if self.categoriesId == 1{
            print(self.productCategoryListArray.count)
            //print(self.productCategoryListArray[indexPath.item].productCategorName ?? "")
            if self.productCategoryListArray.isEmpty == false || self.productCategoryListArray.count != 0{
                cell.catalogurLabel.text = "\(self.productCategoryListArray[indexPath.item].productCategorName ?? "")      "
                if self.categoryId == Int(self.productCategoryListArray[indexPath.item].productCategoryId!) ?? -1{
                    cell.catalogurLabel.textColor = UIColor.white
                    cell.catalogurLabel.backgroundColor = #colorLiteral(red: 0.6156862745, green: 0.06274509804, blue: 0.05882352941, alpha: 1)
                }else{
                    cell.catalogurLabel.textColor = UIColor.white
                    cell.catalogurLabel.backgroundColor = #colorLiteral(red: 0.4344037771, green: 0.4393812716, blue: 0.5076696277, alpha: 1)
                }
            }
               
        }else if self.categoriesId == 2{
            if self.filterByRangeArray.count != 0 {
                cell.catalogurLabel.textAlignment = .center
                cell.catalogurLabel.text = "  \(self.filterByRangeArray[indexPath.row])    "
                if self.selectedPtsRange1 == "\(self.filterByRangeArray[indexPath.row])"{
                    cell.catalogurLabel.textColor = UIColor.white
                    cell.catalogurLabel.backgroundColor = #colorLiteral(red: 0.6156862745, green: 0.06274509804, blue: 0.05882352941, alpha: 1)
                }else{
                    cell.catalogurLabel.textColor = UIColor.white
                    cell.catalogurLabel.backgroundColor = #colorLiteral(red: 0.4344037771, green: 0.4393812716, blue: 0.5076696277, alpha: 1)
                }
            }
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.itsFrom != "PtsRange"{
           // self.selectedPtsRange1 = "All Points"
            
            self.categoryId = Int(self.productCategoryListArray[indexPath.row].productCategoryId!) ?? -1
            self.productCategoryListArray[indexPath.item].isSelected = 1
            self.selectedCategoryName = self.productCategoryListArray[indexPath.row].productCategorName ?? ""
            // self.redemptionCatalogueList()
            self.itsFrom = "Category"
            print(self.categoryId)
            self.categoriesId = 1
            self.startIndex = 1
            self.VM.redemptionCatalogueArray.removeAll()
            self.redemptionCategoryList()
        }else{
            //self.categoryId = -1
            self.categoriesId = 2
            self.VM.redemptionCatalogueArray.removeAll()
            self.selectedPtsRange1 = "All Points"
            self.catalogueCollectionView.reloadData()
            self.selectedPtsRange1 = "\(self.filterByRangeArray[indexPath.row])"
            print(self.selectedPtsRange1)
            if self.selectedPtsRange1 == "All Points"{
                self.selectedPtsRange = "0-100000"
            }else if self.selectedPtsRange1 == "Under 1000 pts"{
                self.selectedPtsRange = "10-999"
            }else if self.selectedPtsRange1 == "1000 - 4999 pts"{
                self.selectedPtsRange = "1000-4999"
            }else if self.selectedPtsRange1 == "5000 - 24999 pts"{
                self.selectedPtsRange = "5000-24999"
            }else if self.selectedPtsRange1 == "25000 & Above pts"{
                self.selectedPtsRange = "25000 - 999999999"
            }
            
            //self.redemptionCategoryList()
            self.startIndex = 1
            self.VM.redemptionCatalogueArray.removeAll()
            self.itsFrom = "PtsRange"
            self.redemptionCatalogueList(startIndex: self.startIndex)
            
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
