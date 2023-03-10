//
//  MSP_MyDreamGiftVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 21/11/2022.
//

import UIKit
import SDWebImage
import Alamofire
import Firebase
import Lottie

class MSP_MyDreamGiftVC: BaseViewController, AddOrRemoveGiftDelegate, popUpDelegate {
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    @IBOutlet weak var notificationLbl: UILabel!
    @IBOutlet weak var myDreamGiftTableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var totalRedeemedPoints = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    
    var selectedDreamGiftId = ""
    var fromSideMenu = ""
    var selectedGiftStatusID = 0
    var dreamGiftRedemptionId = 0
    var VM1 = HistoryNotificationsViewModel()
    var VM = DreamGiftListingViewModel()
    
    
    var totalPoint = 0
    var dreamGiftID = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.myDreamGiftTableView.separatorStyle = .none
        self.myDreamGiftTableView.register(UINib(nibName: "MSP_MyDreamGiftTVC", bundle: nil), forCellReuseIdentifier: "MSP_MyDreamGiftTVC")
        myDreamGiftTableView.delegate = self
        myDreamGiftTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(afterRemovedProducts), name: Notification.Name.dreamGiftRemoved, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(giftAddedIntoCart), name: Notification.Name.giftAddedIntoCart, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
    //åå    self.notificationListApi()
        self.dreamGiftListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Dream Gift")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    @objc func afterRemovedProducts(){
        dreamGiftListApi ()
        self.myDreamGiftTableView.reloadData()
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
    
    
    func redeemGift(_ cell: MSP_MyDreamGiftTVC) {
        guard let tappedIndexPath = myDreamGiftTableView.indexPath(for: cell) else {return}
        if cell.redeemButton.tag == tappedIndexPath.row{
            
                self.totalPoint = self.VM.myDreamGiftListArray[tappedIndexPath.row].pointsRequired ?? 0
                self.dreamGiftID = self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftId ?? 0
                self.giftName = self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftName ?? ""
                self.contractorName = self.VM.myDreamGiftListArray[tappedIndexPath.row].contractorName ?? ""
                self.giftStatusId = self.VM.myDreamGiftListArray[tappedIndexPath.row].giftStatusId ?? 0
            if self.verifiedStatus != 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
                self.loaderView.isHidden = true
                self.stopLoading()
                
            }else{

                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DefaultAddressVC") as! MSP_DefaultAddressVC
                vc.redemptionTypeId = 3
                vc.isComingFrom = "DreemGift"
                vc.totalPoint = self.totalPoint
                vc.dreamGiftID = self.dreamGiftID
                vc.giftName = self.giftName
                vc.contractorName = self.contractorName
                vc.giftStatusId = self.giftStatusId

                self.navigationController?.pushViewController(vc, animated: true)
            }

        }
    }
    func removeGift(_ cell: MSP_MyDreamGiftTVC) {
        guard let tappedIndexPath = myDreamGiftTableView.indexPath(for: cell) else {return}
        if cell.removeGiftBTN.tag == tappedIndexPath.row{
            self.selectedDreamGiftId = "\(self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftId ?? 0)"
            self.selectedGiftStatusID = self.VM.myDreamGiftListArray[tappedIndexPath.row].giftStatusId ?? 0
            self.removeDreamGift()
            self.myDreamGiftTableView.reloadData()
        }
    }
    func removeBtnData(_ cell: MSP_MyDreamGiftTVC) {
        guard let tappedIndexPath = myDreamGiftTableView.indexPath(for: cell) else {return}
        if cell.removeGiftBTN.tag == tappedIndexPath.row{
            self.selectedDreamGiftId = "\(self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftId ?? 0)"
            self.selectedGiftStatusID = self.VM.myDreamGiftListArray[tappedIndexPath.row].giftStatusId ?? 0
            self.removeDreamGift()
            self.myDreamGiftTableView.reloadData()
        }
    }
 
    
    //APi:-
    func dreamGiftListApi(){
       

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
                self.loaderView.isHidden = true
                self.myDreamGiftTableView.isHidden = false
                self.noDataFound.isHidden = true
                self.myDreamGiftTableView.reloadData()
            }else{
                self.myDreamGiftTableView.isHidden = true
                self.noDataFound.isHidden = false
                self.loaderView.isHidden = true

            }
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
                        vc!.descriptionInfo = "Dream Gift has been removed successfully"
                    
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.dreamGiftListApi()
                }
                
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                        vc!.descriptionInfo = "Dream Gift has been removed failed"
                     
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.dreamGiftListApi()
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
            self.VM1.notificationListArray = response?.lstPushHistoryJson ?? []
            print(self.VM1.notificationListArray.count)
            if self.VM1.notificationListArray.count > 0{
                self.notificationLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notificationLbl.isHidden = true
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
                self.loaderView.isHidden = true
                self.stopLoading()
                if sortedValues[0] == "1"{

                    
                    if self.verifiedStatus != 1{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                        self.loaderView.isHidden = true
                        self.stopLoading()
                        
                    }else{

                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DefaultAddressVC") as! MSP_DefaultAddressVC
                        vc.redemptionTypeId = 3
                        vc.isComingFrom = "DreemGift"
                        vc.totalPoint = self.totalPoint
                        vc.dreamGiftID = self.dreamGiftID
                        vc.giftName = self.giftName
                        vc.contractorName = self.contractorName
                        vc.giftStatusId = self.giftStatusId

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
extension MSP_MyDreamGiftVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.myDreamGiftListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_MyDreamGiftTVC") as? MSP_MyDreamGiftTVC
        cell?.delegate = self
        cell?.giftName.text = self.VM.myDreamGiftListArray[indexPath.row].dreamGiftName ?? ""
      //  cell?.tdsvalue.text = "\(self.VM.myDreamGiftListArray[indexPath.row].TdsPoints ?? 0.0)"

       // cell?.dreamGiftTitle.text = self.VM.myDreamGiftListArray[indexPath.row].giftType ?? ""
        let createdDate = (self.VM.myDreamGiftListArray[indexPath.row].jCreatedDate ?? "").split(separator: " ")
        let convertedFormat = convertDateFormater(String(createdDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        cell?.giftCreatedDate.text = convertedFormat
        
        let desiredDate = (self.VM.myDreamGiftListArray[indexPath.row].jDesiredDate ?? "").split(separator: " ")
        let desiredDateFormat = convertDateFormater(String(desiredDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        cell?.desiredDate.text = desiredDateFormat
        cell?.pointsRequired.text = "\(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)"
        let balance = Double(self.VM.myDreamGiftListArray[indexPath.row].pointsBalance ?? 0)
        let pointRequired = Double(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)
        //let remeablePoints = VM.myDreamGiftListArray[indexPath.row].
       // let tdsvalue = self.VM.myDreamGiftListArray[indexPath.row].TdsPoints ?? 0.0
      //  print(pointRequired+tdsvalue,"data")
        print(balance,"Balance")
        
        
//        if self.VM.myDreamGiftListArray[indexPath.row].is_Redeemable ?? -2 != 1{
//            cell?.redeemButton.isEnabled = false
//            cell?.redeemButton.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
//        }else{
//            cell?.redeemButton.isEnabled = true
//            cell?.redeemButton.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
//            }
        
        cell?.redeemButton.tag = indexPath.row
        cell?.removeGiftBTN.tag = indexPath.row
        print(pointRequired,"pointsReq")
        print(balance, "Balance")
        
//        print(pointRequired,"pointsReq")
//        if pointRequired < balance{
//            let percentage = CGFloat(balance/pointRequired)
//            cell?.percentageValue.text = "100%"
//            cell?.progressView.progress = Float(percentage)
//        }else{
//
//            let percentage = CGFloat(balance/pointRequired)
//            let final = CGFloat(percentage) * 100
//            cell?.percentageValue.text = "\(Int(final))%"
//            cell?.progressView.progress = Float(percentage)
//        }
        print(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)
        print(Int(exactly: self.totalRedeemedPoints))
        
        if self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0 <= Int(exactly: self.totalRedeemedPoints)!{
            let totalRedeemableValue = Double(self.totalRedeemedPoints)
            let percentage = CGFloat(totalRedeemableValue / pointRequired)
            cell?.percentageValue.text = "100%"
            cell?.progressView.progress = Float(percentage)
            cell?.redeemButton.isEnabled = true
            cell?.redeemButton.setTitleColor(.white, for: .normal)
            cell?.redeemButton.backgroundColor = #colorLiteral(red: 0.8913556933, green: 0.1619326174, blue: 0.1404572427, alpha: 1)
        }else{
            let totalRedeemableValue = Double(self.totalRedeemedPoints)
            let percentage = CGFloat(totalRedeemableValue / pointRequired)
            let final = CGFloat(percentage) * 100
            cell?.percentageValue.text = "\(Int(final))%"
            cell?.progressView.progress = Float(percentage)
            cell?.redeemButton.isEnabled = false
            cell?.redeemButton.setTitleColor(.white, for: .normal)
            cell?.redeemButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
        }
       
        
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyDreamGiftDetailsVC") as? MSP_MyDreamGiftDetailsVC
        vc?.giftName = self.VM.myDreamGiftListArray[indexPath.row].dreamGiftName ?? ""
       // vc?.tdsvalue = self.VM.myDreamGiftListArray[indexPath.row].TdsPoints ?? 0.0
        vc?.giftType = self.VM.myDreamGiftListArray[indexPath.row].giftType ?? ""
        let createdDate = (self.VM.myDreamGiftListArray[indexPath.row].jCreatedDate ?? "").split(separator: " ")
        let convertedFormat = convertDateFormater(String(createdDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        vc?.addedDate = convertedFormat
        
        let desiredDate = (self.VM.myDreamGiftListArray[indexPath.row].jDesiredDate ?? "").split(separator: " ")
        let desiredDateFormat = convertDateFormater(String(desiredDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        vc?.expiredDate = desiredDateFormat
        vc?.pointsRequires = self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0
        vc?.avgEarningPoints = "\(self.VM.myDreamGiftListArray[indexPath.row].avgEarningPoints ?? 0)"
        vc?.pointsBalance = Int(exactly: totalRedeemedPoints)!
        vc?.selectedDreamGiftId = "\(self.VM.myDreamGiftListArray[indexPath.row].dreamGiftId ?? 0)"
        vc?.selectedGiftStatusID = self.VM.myDreamGiftListArray[indexPath.row].giftStatusId ?? 0
        vc?.contractorName = self.VM.myDreamGiftListArray[indexPath.row].contractorName ?? ""
      //  vc?.isRedeemable = self.VM.myDreamGiftListArray[indexPath.row].is_Redeemable ?? 0
        self.navigationController?.pushViewController((vc)!, animated: true)
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
