//
//  MSP_MyDreamGiftDetailsVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 21/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_MyDreamGiftDetailsVC: BaseViewController, popUpDelegate {

    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var noticationCountLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var dreamGiftNameLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var desiredDateLbl: UILabel!
    @IBOutlet weak var pointsReqLbl: UILabel!
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    @IBOutlet weak var averagePointsLbl1: UILabel!
    @IBOutlet weak var averagePointsLbl2: UILabel!
    @IBOutlet weak var averagePointsLbl3: UILabel!
    @IBOutlet weak var expectedRedemptionLbl1: UILabel!
    @IBOutlet weak var expectedRedemptionLbl2: UILabel!
    @IBOutlet weak var expectedRedemptionLbl3: UILabel!
    
  //  @IBOutlet var stackTDSPts: UIStackView!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var totalRedeemedPoints = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    var contractorName = ""
    var VM = DreamGiftDetailsViewModel()
    var selectedDreamGiftId = ""
    var VM1 = HistoryNotificationsViewModel()
    
    
    var giftType = ""
    var giftImage = ""
    var giftName = ""
    var addedDate = ""
    var tdsvalue = 0.0
    var expiredDate = ""
    var pointsRequires = 0
    var pointsBalance = 0
    var avgEarningPoints = ""
    var dreamGiftRedemptionId = 0
    var selectedGiftStatusID = 0
    var isRedeemable = 0
    var totalPts = 0
    var desiredDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
//        self.loaderView.isHidden = true
        
        self.loaderView.isHidden = false
        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.giftDetailsAPi()
                })
        
       
//        self.stackTDSPts.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(removeGiftDetails), name: Notification.Name.removeDreamGiftDetails, object: nil)
        let receivedImage = giftImage
        print(receivedImage)
        self.dreamGiftNameLbl.text = self.giftName
        self.createdDateLbl.text = self.addedDate
        self.desiredDateLbl.text = self.expiredDate
        productImage.layer.cornerRadius = 8
        productImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let totalImgURL = productCatalogueImgURL + receivedImage
        print(totalImgURL,"TotalImg")
        productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "group_7376"))
        
        if pointsRequires <= pointsBalance{
//            print(pointsRequired,"pointsRequired")
//            print(pointsBalance,"PointBalance")
            print(tdsvalue,"TDs")
            self.infoLbl.text = "Congratulations! you are eligible to win this existing Dream Gift"
            
            self.redeemBtn.isEnabled = true
            self.redeemBtn.backgroundColor = #colorLiteral(red: 0.8913556933, green: 0.1619326174, blue: 0.1404572427, alpha: 1)
            //            self.redeemBTN.backgroundColor = UIColor(red: 199/255, green: 34/255, blue: 4/255, alpha: 0.5)
//            self.redeemBtn.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }else{
            self.infoLbl.text = "Congratulations! You are almost near to win this existing Dream Gift."
            
            redeemBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.redeemBtn.isEnabled = false
            //            self.redeemBTN.backgroundColor = UIColor(red: 212/255, green: 74/255, blue: 35/255, alpha: 1.0)
//            redeemBtn.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
     //   self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "MyDreamGift Details")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    @objc func removeGiftDetails(){
            self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notificationBtn(_ sender: Any) {
    }
    
    @IBAction func redeemBtn(_ sender: Any) {
        print(verifiedStatus,"ljsdkhjkhi")
        
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
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DefaultAddressVC") as! MSP_DefaultAddressVC
            vc.redemptionTypeId = 3
            vc.totalPoint = self.pointsRequires
            vc.dreamGiftID = Int(self.selectedDreamGiftId) ?? 0
            vc.giftName = self.giftName
            vc.contractorName = self.contractorName
            vc.giftStatusId = self.selectedGiftStatusID
            self.navigationController?.pushViewController(vc, animated: true)
        }

        
        
    }
    
    @IBAction func removeBtn(_ sender: Any) {
        removeDreamGift()
    }
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    
    func giftDetailsAPi(){
        let parameters = [
            "ActionType": "243",
            "ActorId": "\(self.userID)",
            "DreamGiftId": "\(selectedDreamGiftId)",
            "LoyaltyId": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myDreamGiftDetails(parameters: parameters) { response in
            print(response?.lstDreamGift?[0].earlyExpectedDate ?? "")
            self.averagePointsLbl1.text = "\(response?.lstDreamGift?[0].pointsRequiredPerMonth ?? "")"
            self.averagePointsLbl2.text = "\(response?.lstDreamGift?[0].monthsRequiredToAchieve ?? 0)"
            
            let splitData = response?.lstDreamGift?[0].jDesiredDate ?? ""
            let separateData = splitData.split(separator: " ")
            print(separateData[0],"sjhdj")
            self.averagePointsLbl3.text = "\(separateData[0])"
            self.expectedRedemptionLbl1.text = "\(response?.lstDreamGift?[0].pointsRequiredPerDay ?? "")"
            self.expectedRedemptionLbl2.text = "\(response?.lstDreamGift?[0].daysRequiredToAchieve ?? 0)"
            self.expectedRedemptionLbl3.text =  "\(separateData[0])"
            
            self.pointsReqLbl.text = "\(response?.lstDreamGift?[0].pointsRequired ?? 0)"
            
        }
    }
    
    func removeDreamGift(){
        let parameters = [
                "ActionType": 4,
                "ActorId": "\(userID)",
                "DreamGiftId": "\(selectedDreamGiftId)",
                "GiftStatusId": 4
        ] as [String: Any]
        print(parameters)
        self.VM.removeDreamGift(parameters: parameters) { response in
            let result = response?.returnValue ?? 0
            print(result)
            if result == 1 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "RemoveDream"
                    vc!.descriptionInfo = "Dream Gift has been removed successfully"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
                
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "RemoveDream"
                    vc!.descriptionInfo = "Dream Gift has been removed failed"
                   
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    

    func dreamGiftListApi(){
        DispatchQueue.main.async {
          self.startLoading()
                self.loaderView.isHidden = false
                self.playAnimation()
        }

        self.VM.myDreamGiftListArray.removeAll()
        let parameters = [
            "ActionType": "1",
            "ActorId": "\(self.userID)",
               "LoyaltyId": "\(loyaltyId)",
                "Status": "2"
        ] as [String: Any]
        print(parameters)
        self.VM.myDreamGiftLists(parameters: parameters) { response in
            self.VM.myDreamGiftListArray = response?.lstDreamGift ?? []
            if self.VM.myDreamGiftListArray.count != 0{
                //self.myDreamGiftTableView.isHidden = false
//                self.noDataFound.isHidden = true
               // self.VM.myDreamGiftTableView.reloadData()
                
                
            }else{
//                self.myDreamGiftTableView.isHidden = true
//                self.noDataFound.isHidden = false
                //self.myDreamGiftTableView.reloadData()

            }
            DispatchQueue.main.async{
                self.loaderView.isHidden = true
                self.stopLoading()
            }
        }
        DispatchQueue.main.async{
            self.loaderView.isHidden = true
            self.stopLoading()
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
                self.noticationCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.noticationCountLbl.isHidden = true
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
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DefaultAddressVC") as! MSP_DefaultAddressVC
                        vc.redemptionTypeId = 3
                        vc.totalPoint = self.pointsRequires
                        vc.dreamGiftID = Int(self.selectedDreamGiftId) ?? 0
                        vc.giftName = self.giftName
                        vc.contractorName = self.contractorName
                        vc.giftStatusId = self.selectedGiftStatusID
                        self.navigationController?.pushViewController(vc, animated: true)
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
