//
//  MSP_ProductCatalogueDetailsVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 18/11/2022.
//

import UIKit
import ImageSlideshow
import Firebase
import Lottie

protocol SendDataDelegate: AnyObject{
    func moveToProductList(_ vc: MSP_ProductCatalogueDetailsVC)
}
class MSP_ProductCatalogueDetailsVC: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    @IBOutlet weak var whisListCountlbl: UILabel!
    @IBOutlet weak var productImageSlideShow: ImageSlideshow!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var categoryTypeLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet weak var addToCart: GradientButton!
    @IBOutlet weak var addToPlanner: GradientButton!
    @IBOutlet weak var addedToPlannerBTN: GradientButton!
    @IBOutlet weak var addedToCart: GradientButton!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var termsandConditions: UILabel!
    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var favoriteImg: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var totalPts: UILabel!
    @IBOutlet weak var tdsApplicablePercent: UILabel!
    @IBOutlet weak var tdsPointsLbl: UILabel!
    @IBOutlet weak var addBTNStackView: UIStackView!
    
    @IBOutlet var tdsPointsStack: UIStackView!
    @IBOutlet var tdsApplicableStack: UIStackView!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    var itsComeFrom = "Details"
    
    var delegate: SendDataDelegate?
    var productImage = ""
    var prodRefNo = ""
    var productCategory = ""
    var productName = ""
    var productPoints = ""
    var tdspercentage1 = 0.0
    var applicabletds = 0.0
    var productDetails = ""
    var termsandContions = ""
    var quantity = 0
    var categoryId = 0
    var catalogueId = 0
    var isComeFrom = ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var totalCartValue = 0
    var isPlanner: Bool?
    var selectedCatalogueID = 0
    var VM = CatalogueDetailsViewModel()
    var VM1 = HistoryNotificationsViewModel()
    var selectedPtsRange = ""
    var dreamRedeemData = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        categoryTypeLabel.text = productCategory
        //productRefNo.text = prodRefNo
        self.favoriteImg.isHidden = true
//        tdsPointsLbl.text = "\(applicabletds)"
//        tdsApplicablePercent.text = "\(tdspercentage1)%"
        print(verifiedStatus,"jkhsduihsi")
        tdsPointsStack.isHidden = true
        tdsApplicableStack.isHidden = true
        
        productNameLabel.text = productName
        pointsLabel.text = "\(Double(productPoints) ?? 0.0)"
        self.descriptions.text = productDetails
        self.termsandConditions.text = termsandContions
        //        qtyValue.text = "\(quantity)"
        //        descriptionLabel.text = productDetails
        //        termsAndCondtionsLabel.text = termsandContions
        let receivedImage = productImage
        print(receivedImage)
        let totalImgURL = productCatalogueImgURL + receivedImage
        productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loaderView.isHidden = true
        if self.subView.isHidden == false{
            self.subView.isHidden = true
        }
        self.notificationListApi()
        self.myCartList()
        plannerListing1()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Product Catalogue Details")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    @IBAction func backBtn(_ sender: Any) {
        print(self.itsComeFrom)
        self.delegate?.moveToProductList(self)
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
    @IBAction func makeItFavoritebtn(_ sender: Any) {
      
    }
    @IBAction func addToCartBtn(_ sender: Any) {
        if self.subView.isHidden == false{
            self.subView.isHidden = true
        }else{
            self.subView.isHidden = true
        }
        if self.dreamRedeemData != 1{
            
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please submit your identity proof"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
               // NotificationCenter.default.post(name: .verificationStatus, object: nil)
            
        }else{
            //            if self.totalCartValue <= Int(pointBalance)!{
            //                let calcValues = self.totalCartValue + Int(self.productPoints)!
            //                print(calcValues)
            if Int(productPoints) ?? 0 <= Int(pointBalance) ?? 0 {
            //if Int(productPoints) ?? 0 <= Int(pointBalance) ?? 0 {
                addToCartApi()
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
    }
    
    @IBAction func addToPlannerBtn(_ sender: Any) {
        self.addedToPlanner()
        //self.addedToPlanner()
    }
    @IBAction func addedToCartBtn(_ sender: Any) {
    }
    
    @IBAction func goToCartButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyCartVC") as! MSP_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    //Api:-
    
    func myCartList(){
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myCartList(parameters: parameters) { response in
            self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
            print(self.VM.myCartListArray.count)
            if self.VM.myCartListArray.count > 0 {
                self.countLabel.isHidden = false
                self.countLabel.text = "\(self.VM.myCartListArray.count)"
            }else{
                self.countLabel.isHidden = true
            }
            DispatchQueue.main.async {
                
                if self.VM.myCartListArray.count != 0{
                    for data in self.VM.myCartListArray{
                        self.totalCartValue = Int(data.sumOfTotalPointsRequired ?? 0.0)
                        print(self.totalCartValue, "TotalValue")
                        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.catalogueId}
                        print(filterCategory.count)
                        if filterCategory.count > 0 {
                            self.addedToCart.isHidden = false
                            self.addToPlanner.isHidden = true
                            self.addToCart.isHidden = true
                            self.addedToPlannerBTN.isHidden = true
                        }else{
                            print(Int(self.productPoints) ?? 0, "Value1")
                            print(Int(self.pointBalance) ?? 0, "Value 2")
                            print("\(self.applicabletds)", "Value 3")
                            
                            // if (Int(self.productPoints)! + Int(self.applicabletds)) < Int(self.pointBalance)!{
                            if Int(self.productPoints) ?? 0 <= Int(self.pointBalance) ?? 0 {
                                self.addedToCart.isHidden = true
                                self.addToPlanner.isHidden = true
                                self.addToCart.isHidden = false
                                self.addedToPlannerBTN.isHidden = true
                            }else{
                                self.addedToCart.isHidden = true
                                self.addToPlanner.isHidden = false
                                self.addToCart.isHidden = true
                                self.addedToPlannerBTN.isHidden = true
                                
                                self.plannerListing()
                            }
                        }
                    }
                }else{
                    print(self.productPoints)
                    print(self.pointBalance, "asdfashjdfasdfasdf")
                    //if (Int(self.productPoints)! + Int(self.applicabletds)) < Int(self.pointBalance)!{
                    if Int(self.productPoints) ?? 0 <= Int(self.pointBalance) ?? 0 {
                        self.addedToCart.isHidden = true
                        self.addToPlanner.isHidden = true
                        self.addToCart.isHidden = false
                        self.addedToPlannerBTN.isHidden = true
                    }else{
                        self.addedToCart.isHidden = true
                        self.addToPlanner.isHidden = false
                        self.addToCart.isHidden = true
                        self.addedToPlannerBTN.isHidden = true
                        self.plannerListing()
                    }
                }
                self.loaderView.isHidden = true
                self.stopLoading()
            }
        }
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
            
            print(response?.returnValue ?? 0, "Add To Cart")
            
            if response?.returnValue == 1{
                self.myCartList()
                DispatchQueue.main.async{
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
    
    func plannerListing1(){
        let parameters = [
            "ActionType": "6",
            "ActorId": "\(userID)"
        ] as [String : Any]
        self.VM.plannerListingApi1(parameters: parameters)
    }
    
    func plannerListing(){
        let parameters = [
            "ActionType": "6",
            "ActorId": "\(userID)"
        ] as [String : Any]
        print(parameters)
        self.VM.plannerListingApi(parameters: parameters) { response in
            self.VM.myPlannerListArray = response?.objCatalogueList ?? []
            print(self.VM.myPlannerListArray.count)
            DispatchQueue.main.async {
                if self.VM.myPlannerListArray.count > 0 {
                    self.whisListCountlbl.isHidden = false
                    self.whisListCountlbl.text = "\(self.VM.myPlannerListArray.count)"
                }else{
                    self.whisListCountlbl.isHidden = true
                }
                let filterCategory = self.VM.myPlannerListArray.filter { $0.catalogueId == self.catalogueId}
                print(filterCategory.count)
                if filterCategory.count > 0 {
                    self.addedToCart.isHidden = true
                    self.addToPlanner.isHidden = true
                    self.addToCart.isHidden = true
                    self.addedToPlannerBTN.isHidden = false
                    self.favoriteButton.setImage(UIImage(named: "heart-4"), for: .normal)
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }else{
                    print(self.isPlanner, "IspLannser")
                    //if self.isPlanner == true{
                    print(self.pointBalance,"ksjd")
                    print(self.productPoints,"kjshdk")
                    print(Int(self.pointBalance) ?? 0)
                    print(Int(self.productPoints) ?? 0)
                    print(Int(Double(self.pointBalance) ?? 0))
                    
                    if Int(self.productPoints) ?? 0 <= Int(Double(self.pointBalance) ?? 0){
                        
                        self.addedToCart.isHidden = true
                        self.addToPlanner.isHidden = true
                        self.addToCart.isHidden = false
                        self.addedToPlannerBTN.isHidden = true
                        //                    }else{
                        //                        self.addBTNStackView.isHidden = true
                        //
                        //                    }
                    }else{
                        self.addedToCart.isHidden = true
                        self.addToPlanner.isHidden = false
                        self.addToCart.isHidden = true
                        self.addedToPlannerBTN.isHidden = true
                    }
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }
            
        }
        DispatchQueue.main.async {
            self.loaderView.isHidden = true
            self.stopLoading()
        }
        
    }
    
    
    func addedToPlanner(){
        let parameters = [
            "ActionType": 0,
            "ActorId": "\(userID)",
            "ObjCatalogueDetails": [
                "CatalogueId": "\(selectedCatalogueID)"
            ]
        ] as [String: Any]
        print(parameters)
        self.VM.addToPlanners(parameters: parameters) { response in
            print(response?.returnValue ?? 0, "Added To Planner")
            if response?.returnValue ?? 0 >= 1{
                self.plannerListing()
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Product has been added into Wishlist List"
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
