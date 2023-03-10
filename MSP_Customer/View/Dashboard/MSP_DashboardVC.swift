//
//  MSP_DashboardVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 28/11/22.
//

import UIKit
import SlideMenuControllerSwift
import Alamofire
import ImageSlideshow
import SDWebImage
import Kingfisher
import CoreData
import Firebase
import Photos
import Lottie
import QCropper
class MSP_DashboardVC: BaseViewController, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    

    @IBOutlet weak var accountTypeName: UILabel!
    @IBOutlet var offersEmptyImg: UIImageView!
    
    @IBOutlet weak var dealerImage: UIImageView!
    @IBOutlet weak var retailerImage: UIImageView!
    @IBOutlet weak var offersandPromotionView: ImageSlideshow!
    @IBOutlet weak var bannerEmptyImg: UIImageView!
    @IBOutlet var customerNameLbl: UILabel!
    @IBOutlet var customerIDLbl: UILabel!
    @IBOutlet var customerCatagoryLbl: UILabel!
    @IBOutlet var customerProfileImage: UIImageView!
    @IBOutlet var totalPointsLbl: UILabel!
    @IBOutlet var customerGradeLbl: UILabel!
    @IBOutlet var customerGradeImage: UIImageView!
    @IBOutlet var bannerView: ImageSlideshow!
    
    @IBOutlet var notificationCountLbl: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
    @IBOutlet weak var loaderView: UIView!
    
    @IBOutlet weak var tierVieew: UIView!
    
    @IBOutlet weak var maintenanceLbl: UILabel!
    @IBOutlet weak var maintenanceView: UIView!
    
    private var animationView11: AnimationView?
    let picker = UIImagePickerController()
    var strBase64 = ""
    var fileType = ""
    var strdata1 = ""
    //@IBOutlet var bottomTabView: UIView!
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var vm = DashBoardViewModel()
    var isCalled = false
    var sourceArray = [AlamofireSource]()
    var sourceArray1 = [AlamofireSource]()
    var bannerImagesArray = [ObjImageGalleryList]()
    var offersandPromotionsArray = [LstPromotionJsonList]()
    var vm1 = RedemptionPlannerListViewModel()
    let pageIndicator = UIPageControl()
    var youTubeURL = ""
    var offersImageView = ["dsdsd"]
    var callOnce = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maintenanceView.isHidden = true
        self.callOnce = 1
        self.picker.delegate = self
        self.retailerImage.isHidden = false
        self.dealerImage.isHidden = true
        self.vm.VC = self
        self.vm1.VC1 = self
        self.bannerEmptyImg.isHidden = true
        self.retailerImage.image = UIImage(named: "tool_logo")
        
        pageIndicator.currentPageIndicatorTintColor = UIColor.red
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        NotificationCenter.default.addObserver(self, selector: #selector(checkVerificationStatus), name: Notification.Name.verificationStatus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deactivateAccount), name: Notification.Name.deactivatedAcc, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkUserStatus), name: Notification.Name.userIsActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToDashoardApi), name: Notification.Name.goToDashBoardAPI, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(moveToDashBoard), name: Notification.Name.sendDashboard, object: nil)
        self.customerProfileImage.layer.cornerRadius = self.customerProfileImage.frame.width / 2
        self.customerProfileImage.clipsToBounds = true
        
        //Analytics.setScreen(MSP_DashboardVC)
       
//        self.loaderView.isHidden = false
//        self.playAnimation()
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
//
//        })

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
        self.slideMenuController()?.closeLeft()
        self.maintenanceAPI()
        self.isUpdateAvailable()
       
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Dashboard")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
//        setNeedsStatusBarAppearanceUpdate()
    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .lightContent
//    }
    

    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    override func viewDidLayoutSubviews() {
        slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.89)
        SlideMenuOptions.contentViewScale = 1
    }
    @objc func checkUserStatus(){
        self.userStatusApi()
    }
    @objc func goToDashoardApi() {
        self.dashboardAPI()
    }
//    @objc func moveToDashBoard(){
//        self.navigationController?.popToRootViewController(animated: true)
//    }
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
    @objc func deactivateAccount(){
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
        DispatchQueue.main.async {
            self.clearTable()
            if #available(iOS 13.0, *) {
                let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }
        }
    }
    
    @IBAction func claimPointsBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_ClaimPointsVC") as! MSP_ClaimPointsVC
        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func claimStatusBTN(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_ClaimStatusVC") as! MSP_ClaimStatusVC
        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func helplineBTN(_ sender: Any) {
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_LodgeQueryVC") as! MSP_LodgeQueryVC
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_Support") as! MSP_Support
        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func redemptionCatalogeBTN(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_RedemptionCatalgoueVC") as! MSP_RedemptionCatalgoueVC
        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func myDreamGiftBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_MyDreamGiftVC") as! MSP_MyDreamGiftVC
        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func myWishlistBTN(_ sender: Any) {
        print(vm1.myPlannerListArray.count,"PlannerCount")
        if vm1.myPlannerListArray.count > 0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
            vc.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
            vc.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func sideMenuBtn(_ sender: Any) {
        self.openLeft()
    }
    
    @IBAction func notificationBellBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func offersandPromotionsBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_OffersandPromotionsVC") as! MSP_OffersandPromotionsVC
        vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func takeProfilePic(_ sender: Any){
       // self.closeLeft()
        let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            self.closeLeft()
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
            self.openRight()
        })
        
    }
    
    func tokendata(){
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
            let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                        print(parseddata.access_token ?? "")
                        UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                    DispatchQueue.main.async {
                        if self.callOnce == 1{
                            self.offersandPromotionsApi()
                            self.bannerImagesAPI()
                            self.callOnce = 0
                        }
                        self.dashboardAPI()
                    }
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
        }
    
    
    func ImageSetups2(){
        self.sourceArray.removeAll()
        if self.offersandPromotionsArray.count > 0 {
            for image in self.offersandPromotionsArray {
                let imageURL = image.proImage ?? ""
                let splittedImageURL = imageURL.dropFirst(2)
                let receivedImageURLs = PROMO_IMG + splittedImageURL
                print(receivedImageURLs, "asdfasdfadhslfkadjsfjkladlsfjklads")
                let replaceString = "\(receivedImageURLs)".replacingOccurrences(of: " ", with: "%20")
                self.sourceArray.append(AlamofireSource(urlString: "\(replaceString)", placeholder: UIImage(named: "defaultImage"))!)
            }
            offersandPromotionView.setImageInputs(self.sourceArray)
            offersandPromotionView.slideshowInterval = 3.0
            offersandPromotionView.zoomEnabled = true
            offersandPromotionView.contentScaleMode = .scaleToFill
        }else{
            offersandPromotionView.setImageInputs([
                ImageSource(image: UIImage(named: "defaultImage")!)
            ])
        }
    }
    @objc func didTap1() {
        if self.offersandPromotionsArray.count > 0 {
            
            offersandPromotionView.presentFullScreenController(from: self)
        }
    }
    
    
    
    // Api:-
    
    
    func dashboardAPI() {
        DispatchQueue.main.async {
            self.startLoading()
        }
        let parameters = [
            "ActorId":"\(userID)"
        ]
        print(parameters)
        self.vm.dashboardAPICall(parameters: parameters) { response in
            if response?.activeStatus == false {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    //self.isActive = false
                    vc!.itsComeFrom = "DeactivateAccount"
                    vc!.descriptionInfo = "Your account is deactivated please check with the administrator"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.loaderView.isHidden = true
                    self.stopLoading()
                    
                }
            } else {
                DispatchQueue.main.async {
                    print(response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "")
                    UserDefaults.standard.setValue(response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "", forKey: "LoyaltyID")
                    print(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)
                    UserDefaults.standard.setValue(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0, forKey: "RedeemablePointBalance")
                    UserDefaults.standard.setValue(response?.lstCustomerFeedBackJsonApi?[0].firstName, forKey: "FirstName")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].merchantMobile ?? "", forKey: "MerchantMobile")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "CustomerMobile")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].merchantEmail ?? "", forKey: "MerchantEmail")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].customerEmail ?? "", forKey: "CustomerEmail")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? 0, forKey: "VerifiedStatus")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? 0, forKey: "CustomerTypeId")
                    print(response?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? 0)
                    UserDefaults.standard.set(response?.objCustomerDashboardList?[0].memberSince ?? "", forKey: "MemberSince")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].languageId ?? 0, forKey: "LanguageId")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].cashBack ?? 0, forKey: "CashBack")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].referralCode ?? 0, forKey: "ReferralCode")
                    //self.totalPointsLbl.text = String(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)
                    let imageurl = "\(response?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "")".dropFirst(1)
                    let imageData = imageurl.split(separator: "~")
                    if imageData.count >= 2 {
                        print(imageData[1],"jdsnjkdn")
                        let totalImgURL = PROMO_IMG1 + (imageData[1])
                        print(totalImgURL, "Total Image URL")
                        self.customerProfileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "icons8-life-cycle-96"))
                    }else{
                        let totalImgURL = PROMO_IMG1 + imageurl
                        print(totalImgURL, "Total Image URL")
                        self.customerProfileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "icons8-life-cycle-96"))
                    }
                    
                    self.customerNameLbl.text = response?.lstCustomerFeedBackJsonApi?[0].firstName ?? "-"
                    self.customerIDLbl.text = response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "-"
                    self.accountTypeName.text = response?.lstCustomerFeedBackJsonApi?[0].customerType ?? "-"
//                    if response?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? 0 == 51{
//                        self.retailerImage.isHidden = false
//                        self.dealerImage.isHidden = true
//                        self.tierVieew.isHidden = true
//                    }else if response?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? 0 == 52{
//                        self.retailerImage.isHidden = true
//                        self.dealerImage.isHidden = false
//                    }else{
//                        self.retailerImage.isHidden = true
//                        self.dealerImage.isHidden = true
//                    }
                    
                    self.totalPointsLbl.text = "Total Points: \(Int(response?.objCustomerDashboardList?[0].totalRedeemed ?? 0) ?? 0)"
                    UserDefaults.standard.set(response?.objCustomerDashboardList?[0].totalRedeemed ?? 0, forKey: "TotalRedeemedPoints")
                    self.customerGradeLbl.text = response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "-"
                    
                    // self.customerCatagoryLbl.text = response?.lstCustomerFeedBackJsonApi?[0].title ?? "-"
                    if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Bronze" {
                        self.customerGradeImage.image = UIImage(named: "grade1")
                    } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Gold" {
                        self.customerGradeImage.image = UIImage(named: "grade2")
                    } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Silver" {
                        self.customerGradeImage.image = UIImage(named: "grade3")
                    } else {
                        self.customerGradeImage.image = UIImage(named: "grade3")
                    }
                    print(response?.lstPromotionListJsonApi?.count)
                    if response?.lstPromotionListJsonApi?.count != 0{
                        
                        
                    }else{
                        //       self.offersandPromotionsImg.isHidden = false
                    }
                    if response?.objCatalogueDetailsForCustomer?.count ?? 0 != 0 {
                        if self.isCalled == false {
                            DispatchQueue.main.async{
                                //self.stopLoading()
                                //                                                            self.isCalled = true
                                //                                                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftPopUpViewController") as? DreamGiftPopUpViewController
                                //                                                            vc!.dreamGiftArray = response?.objCatalogueDetailsForCustomer ?? []
                                //                                                            vc!.modalPresentationStyle = .overCurrentContext
                                //                                                            vc!.modalTransitionStyle = .crossDissolve
                                //                                                            self.present(vc!, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
                UserDefaults.standard.synchronize()
                self.loaderView.isHidden = true
                self.notificationListApi()
                self.stopLoading()
            }
           
           
           // self.bannerImagesAPI()
        }
    }
    func offersandPromotionsApi(){
        DispatchQueue.main.async {
            self.startLoading()
            self.loaderView.isHidden = false
            self.playAnimation()
        }
        self.offersandPromotionsArray.removeAll()
        let parameters = [
            "ActionType": "99",
            "ActorId": "\(self.userID)"
        ] as [String: Any]
        print(parameters)
        self.vm.offersandPromotions(parameters: parameters) { response in
            self.offersandPromotionsArray = response?.lstPromotionJsonList ?? []
            DispatchQueue.main.async {
                if self.offersandPromotionsArray.count > 0{
                    self.offersEmptyImg.isHidden = true
                    self.ImageSetups1()
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }else{
                    self.offersEmptyImg.isHidden = false
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
                
                if self.offersandPromotionsArray.count == 0{
                        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap1))
                        self.offersandPromotionView.addGestureRecognizer(gestureRecognizer)
                }else{
                        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap1))
                        self.offersandPromotionView.addGestureRecognizer(gestureRecognizer)
                }
            }
        }
    }
    
    
    func notificationListApi(){
        DispatchQueue.main.async {
          self.startLoading()
//                self.loaderView.isHidden = false
//                self.playAnimation()
        }

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
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }else{
//                self.noDataFoundLbl.isHidden = false
//                self.notificationListTableView.isHidden = true
                self.loaderView.isHidden = true
                self.stopLoading()
            }
        }
        
    }
    
    //Check user is Active or not
    func userStatusApi(){
        let parameters = [
            "userid": "\(userID)"
        ] as [String: Any]
        print(parameters)
        self.vm.userStatus(parameters: parameters) { response in
            if response?.isActive == false {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "DeactivateAccount"
                    vc!.descriptionInfo = "Your account is deactivated please check with the administrator"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    //self.stopLoading()
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                   // self.dashboardAPI()
                    //self.bannerImagesAPI()
//                                        self.maintenanceAPI()
//                                        self.isUpdateAvailable()
                }
            }
            //self.stopLoading()
        }
        
    }
    
    
  
    func bannerImagesAPI() {
        let parameters = [
                "ActorId": "\(userID)",
                "AlbumCategoryID":"1"
            ] as [String: Any]
        print(parameters)
        self.vm.dashboardImagesAPICall(parameters: parameters){ response in
            print(response as Any, "asdfljashdfjadslkfdsalkfjjldsaljfsad")
            if response != nil {
                DispatchQueue.main.async {
                    self.bannerImagesArray = response?.objImageGalleryList ?? []
                    print(self.bannerImagesArray.count, "Banner Image Count")
                    
                    if self.bannerImagesArray.count != 0 {
                        self.ImageSetups()
                        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
                        self.bannerView.addGestureRecognizer(gestureRecognizer)
                        self.bannerView.isHidden = false
                        self.bannerEmptyImg.isHidden = true
                        
//                        let imageurl = "\(response?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "")".dropFirst(1)
//                        let totalImgURL = PROMO_IMG1 + imageurl
//                        print(totalImgURL, "Total Image URL")
//
//                        self.customerProfileImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "icons8-life-cycle-96"))
                        
                    }else{
                        self.bannerView.isHidden = true
                        self.bannerEmptyImg.isHidden = false
                    }
                }
               
                
                // self.offersandPromotionsApi()
            }else{
            print("No Resdflksjadfljkasdjflasldjf")
            }
        }
    }
    
    @objc func didTap() {
//        if bannerImagesArray.count > 0 {
////            bannerView.presentFullScreenController(from: self)
//            for image in bannerImagesArray {
//                print(image.actionImageUrl,"imageURL")
//                if let url = URL(string: "\(image.actionImageUrl ?? "")")
//                    {
//                        UIApplication.shared.openURL(url)
//                    }
//            }
//        }
        
        if self.bannerImagesArray.count > 0 {
            
            bannerView.presentFullScreenController(from: self)
        }
        
    }
    
    
    func ImageSetups(){
        sourceArray.removeAll()
        if bannerImagesArray.count > 0 {
            for image in bannerImagesArray {
                print(image.imageGalleryUrl,"ImageURL")
                let filterImage = (image.imageGalleryUrl ?? "").dropFirst()
                let images = ("\(PROMO_IMG1)\(filterImage)").replacingOccurrences(of: " ", with: "%20")
                
                sourceArray.append(AlamofireSource(urlString: images, placeholder: UIImage(named: "ic_default_img"))!)
                
            }
            bannerView.setImageInputs(sourceArray)
            bannerView.slideshowInterval = 3.0
            bannerView.zoomEnabled = false
        } else {
            self.bannerEmptyImg.isHidden = false
        }
    }

    func ImageSetups1(){
        sourceArray1.removeAll()
        if self.offersandPromotionsArray.count > 0 {
            for image in self.offersandPromotionsArray {
                
                let filterImage = (image.proImage ?? "").dropFirst(3)
                let images = ("\(PROMO_IMG1)\(filterImage)").replacingOccurrences(of: " ", with: "%20")
                
                sourceArray1.append(AlamofireSource(urlString: images, placeholder: UIImage(named: "ic_default_img"))!)
            }
            offersandPromotionView.setImageInputs(sourceArray1)
            offersandPromotionView.slideshowInterval = 3.0
            offersandPromotionView.zoomEnabled = false
        } else {
            self.bannerEmptyImg.isHidden = false
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
extension MSP_DashboardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openGallery() {
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            if newStatus ==  PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = .savedPhotosAlbum
                    self.picker.mediaTypes = ["public.image"]
                    self.present(self.picker, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)

                }
            }
        })
    }

    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {

                                self.picker.allowsEditing = false
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "NeedCameraAccess", message: "Allow", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                            }
                            alertVC.addAction(okAction)
                            alertVC.addAction(cancelAction)
                            self.present(alertVC, animated: true, completion: nil)

                        }
                    }
                }} else {
                    DispatchQueue.main.async {
                        self.noCamera()
                    }
                }
        }

    }


    func opencamera() {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker,animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "MSPneedtoaccesscameraGallery", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "Disallow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorrnodevice", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        DispatchQueue.main.async {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
//            let imageData = selectedImage.resized(withPercentage: 0.1)
//            let imageData1: NSData = imageData!.pngData()! as NSData
//            self.customerProfileImage.image = selectedImage
//            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
//            self.vm.imageSubmissionAPI(base64: self.strdata1)
//            picker.dismiss(animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                print(image)
                
                let imageData = image.resized(withPercentage: 0.1)
                let imageData1: NSData = imageData!.pngData()! as NSData
                self.customerProfileImage.image = image
                //self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
                let cropper = CropperViewController(originalImage: image)
                print(self.strdata1,"Image")
                cropper.delegate = self
                
                picker.dismiss(animated: true) {
                self.present(cropper, animated: true, completion: nil)
                  
                }
              
        }
            
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
    
    func maintenanceAPI(){
        guard let url = URL(string: "http://appupdate.arokiait.com/updates/serviceget?pid=Loyltwo3ks-Pvt-Ltd.MSP-Customer") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                                                        dataResponse, options: [])
                print(jsonResponse)
                let isMaintenanceValue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.is_maintenance") as? String)!
                let forceupdatevalue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.version_number") as? String)!
                print(isMaintenanceValue)
                if isMaintenanceValue == "1"{
                    print(isMaintenanceValue)
                    DispatchQueue.main.async {
                        self.loaderView.isHidden = true
                        self.stopLoading()
                        self.maintenanceView.isHidden = false
                    }
                }else if isMaintenanceValue == "0"{
                    print(isMaintenanceValue)
                    DispatchQueue.main.async {
                        self.maintenanceView.isHidden = true
                        self.loaderView.isHidden = true
                        self.stopLoading()
                        self.tokendata()
                       
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    func isUpdateAvailable() {
        let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        print(bundleId)
        Alamofire.request("https://itunes.apple.com/in/lookup?bundleId=\(bundleId)").responseJSON { response in
            if let json = response.result.value as? NSDictionary, let results = json["results"] as? NSArray, let entry = results.firstObject as? NSDictionary, let appStoreVersion = entry["version"] as? String,let appstoreid = entry["trackId"], let trackUrl = entry["trackViewUrl"], let installedVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                let installed = Int(installedVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(installed)
                let appStore = Int(appStoreVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(appStore)
                print(appstoreid)
                if appStore>installed {
                        let alertController = UIAlertController(title: "New update Available!", message: "Update is available to download. Downloading the latest update you will get the latest features, improvements and bug fixes of MSP Customer", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "Update Now", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)
                            
                        }
                        //                     Add the actions
                        alertController.addAction(okAction)
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        
                       
                }else{
                    print("no updates")
                    
                }
            }
        }
    }
}
extension MSP_DashboardVC: CropperViewControllerDelegate {

    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
    cropper.dismiss(animated: true, completion: nil)
 
    if let state = state,
        let image = cropper.originalImage.cropped(withCropperState: state) {
        print(image,"imageDD")
        let imageData = image.resized(withPercentage: 0.1)
        let imageData1: NSData = imageData!.pngData()! as NSData
        self.customerProfileImage.image = image
        self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        print(strdata1,"kdjgjhdsj")
        self.customerProfileImage.image = image
        self.vm.imageSubmissionAPI(base64: self.strdata1)
    } else {
        print("Something went wrong")
    }
    self.dismiss(animated: true, completion: nil)
    }
}




