//
//  MSP_DefaultAddressVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 19/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_DefaultAddressVC: BaseViewController, SendUpdatedAddressDelegate, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func updatedAddressDetails(_ vc: MSP_EditAddressVC) {
        self.selectedname = vc.selectedname
        self.selectedemail = vc.selectedemail
        self.selectedmobile = vc.selectedmobile
        self.selectedState = vc.selectedState
        self.selectedStateID = vc.selectedStateID
        self.selectedCity = vc.selectedCity
        self.selectedCityID = vc.selectedCityID
        self.selectedaddress = vc.selectedaddress
        self.selectedpincode = vc.selectedpincode
        self.selectedCountryId = 15
        self.selectedCountry = "India"
        self.contractorName = vc.selectedname
        self.customerAddressTV.text = "\(selectedname),\n\(self.selectedmobile),\n\(self.selectedaddress),\n\(self.selectedCity),\n\(self.selectedState),\n\(self.selectedCountry),\n\(self.selectedemail),\n\(self.selectedpincode)"
    }
    
    @IBOutlet var customerNameLabel: UILabel!
    @IBOutlet var totalPoints: UILabel!
    @IBOutlet var proceedToCheckoutButton: GradientButton!
    @IBOutlet weak var customerAddressTV: UITextView!
    
    @IBOutlet weak var orderListTableView: UITableView!
    @IBOutlet weak var cartCountLbl: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var notificaitonCountLbl: UILabel!
    
    @IBOutlet var cartListingView: UIView!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    var VM1 = HistoryNotificationsViewModel()
    var VM = DefaultAddressModels()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var pointBalance = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    
    var selectedname = ""
    var selectedemail = ""
    var selectedmobile = ""
    var selectedState = ""
    var selectedStateID = -1
    var selectedCity = ""
    var selectedCityID = -1
    var selectedaddress = ""
    var selectedpincode = ""
    var selectedCountryId = -1
    var selectedCountry = ""
    var totalPoint = 0
//    var totalPoints = 0
    
    var dreamGiftID = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    var redemptionTypeId = 0
    var isComingFrom = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.orderListTableView.delegate = self
        self.orderListTableView.dataSource = self
        self.profileDetailsAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(afterDismissed), name: Notification.Name.dismissCurrentVC, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: Notification.Name.goToMain, object: nil)
        if isComingFrom == "DreemGift"{
            self.cartListingView.isHidden = true
            self.orderListTableView.isHidden = true
        }else{
            self.orderListTableView.isHidden = false
            self.cartListingView.isHidden = false
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        print(self.dreamGiftID)
        print(self.totalPoint)
        self.loaderView.isHidden = true
        if self.dreamGiftID != 0 {
            self.totalPoints.text = "\(Double(self.totalPoint))"
        }else{
            self.myCartListAPI()
        }
     //   self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Default Address")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    @objc func goToMain(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func afterDismissed(){
        self.profileDetailsAPI()
        
        if isComingFrom == "DreemGift"{
            self.cartListingView.isHidden = true
        }else{
            self.myCartListAPI()
        }
        
    }
    
    @IBAction func editAddressBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_EditAddressVC") as! MSP_EditAddressVC
        vc.delegate = self
        vc.selectedname = self.VM.defaultAddressArray[0].firstName ?? "-"
        vc.selectedemail = self.VM.defaultAddressArray[0].email ?? "-"
        vc.selectedmobile = self.VM.defaultAddressArray[0].mobile ?? "-"
        vc.selectedState = self.VM.defaultAddressArray[0].stateName ?? "-"
        vc.selectedStateID = self.VM.defaultAddressArray[0].stateId ?? 0
        vc.selectedCity = self.VM.defaultAddressArray[0].cityName ?? "-"
        vc.selectedCityID = self.VM.defaultAddressArray[0].cityId ?? 0
        vc.selectedaddress = self.VM.defaultAddressArray[0].address1 ?? "-"
        vc.selectedpincode = self.VM.defaultAddressArray[0].zip ?? "-"
        vc.selectedCountryId = self.VM.defaultAddressArray[0].countryId ?? 0
        vc.selectedCountry = self.VM.defaultAddressArray[0].countryName ?? "-"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func processBtn(_ sender: Any) {

        DispatchQueue.main.async {
            self.startLoading()
            self.loaderView.isHidden = false
                self.playAnimation()
        }
        if self.verifiedStatus != 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            
        }else if self.verifiedStatus == 1{
            if selectedStateID == -1 || selectedCityID == -1 || selectedaddress == "" || selectedpincode == "" || selectedmobile == ""{
                DispatchQueue.main.async{
                    self.loaderView.isHidden = true
                    self.stopLoading()
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                        vc!.descriptionInfo = "Shipping address requires: State,City,Address,Pin code and Mobile Number,details,Click on 'Edit' to edit and add details"
                   
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                print(self.totalPoint)
                print(self.pointBalance)
                if self.totalPoint <= Int(self.pointBalance) {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_RedemptionSubmissionVC") as? MSP_RedemptionSubmissionVC
                    vc!.stateID = self.selectedStateID
                    vc!.cityID = self.selectedCityID
                    
                    vc!.stateName = self.selectedState
                    vc!.cityName = self.selectedCity
                    vc!.pincode = self.selectedpincode
                    vc!.address1 = self.selectedaddress
                    vc!.customerName = self.selectedname
                    vc!.mobile = self.selectedmobile
                    vc!.emailId = self.selectedemail
                    vc!.countryId = 15
                    vc!.countryName = "India"
                    vc!.redeemedPoints = self.totalPoint
                    vc!.dreamGiftId = self.dreamGiftID
                    vc!.giftPts = self.totalPoint
                    vc!.giftName = self.giftName
                    vc!.contractorName = self.contractorName
                    vc!.giftStatusId = self.giftStatusId
                    vc!.redemptionTypeId = self.redemptionTypeId
                    print(self.redemptionTypeId, "RedemptionTypeId")
                    print(self.dreamGiftID, "dreamGiftID")
                    
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    DispatchQueue.main.async{
                        self.loaderView.isHidden = true
                        self.stopLoading()
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                            vc!.descriptionInfo = "Insufficient Point Balance"
                       
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
                
            }
            
        }
    }
    
    @IBAction func cartBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyCartVC") as! MSP_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func profileDetailsAPI(){
        let parameterJSON = [
            "ActionType": "6",
            "CustomerId": "\(userID)"
        ] as [String: Any]
        print(parameterJSON)
        self.VM.defaultAddressAPi(parameters: parameterJSON)
    }
    
    
    func myCartListAPI(){
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyID)"
        ] as [String: Any]
        print(parameters)
        self.VM.cartAddressAPI(parameters: parameters)
        
    }
    
    func notificationListApi(){
        let parameters = [
            "ActionType": 0,
            "ActorId": "\(userID)",
            "LoyaltyId": self.loyaltyID
        ] as [String: Any]
        print(parameters)
        self.VM1.notificationListApi(parameters: parameters) { response in
            self.VM1.notificationListArray = response?.lstPushHistoryJson ?? []
            print(self.VM1.notificationListArray.count)
            if self.VM1.notificationListArray.count > 0{
                self.notificaitonCountLbl.isHidden = true
                self.notificaitonCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notificaitonCountLbl.isHidden = true
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
extension MSP_DefaultAddressVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isComingFrom == "DreemGift"{
            return 0
        }else{
            return VM.myCartListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTVC") as! MyOrderTVC
        cell.selectionStyle = .none
        cell.productName.text = VM.myCartListArray[indexPath.row].productName ?? "-"
        cell.catagoryName.text = VM.myCartListArray[indexPath.row].categoryName ?? "-"
        cell.pointsLabel.text = "\(Double(VM.myCartListArray[indexPath.row].pointsRequired ?? 0))"
        //cell.productImageView.image = VM.myCartListArray[indexPath.row].
        let receivedImage = self.VM.myCartListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
