//
//  MSP_MyRedemptionVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 21/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_MyRedemptionVC: BaseViewController, DateSelectedDelegate, popUpDelegate, DropDownDelegate{
    func redemptionStatusDidTap(_ vc: MSP_DropDownVC) {
        self.selectedStatusName = vc.selectedRedemptionStatus
        self.selectStatusLbl.text = vc.selectedRedemptionStatus
        self.selectedStatusId = vc.seletedRedemptionStatusId
    }
    
    func stateDidTap(_ vc: MSP_DropDownVC) {}
    func cityDidTap(_ vc: MSP_DropDownVC) {}
    func preferredLanguageDidTap(_ vc: MSP_DropDownVC) {}
    func genderDidTap(_ vc: MSP_DropDownVC) {}
    func titleDidTap(_ vc: MSP_DropDownVC) {}
    func dealerDipTap(_ vc: MSP_DropDownVC) {}
    func statusDipTap(_ vc: MSP_DropDownVC) {}
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    func acceptDate(_ vc: MSP_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromDateLbl.text = vc.selectedDate
        }else{
            self.selectedToDate = vc.selectedDate
            self.toDateLbl.text = vc.selectedDate
        }
    }
    
    func declineDate(_ vc: MSP_DOBVC) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var myRedemptionTableView: UITableView!
    @IBOutlet var filterView: UIView!
    @IBOutlet var filterFromDateBtn: UIButton!
    @IBOutlet var filterToDateBtn: UIButton!
    @IBOutlet var filterStatusBtn: UIButton!
    @IBOutlet weak var redemptionFilterOutBtn: UIButton!
    
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var selectStatusLbl: UILabel!
    @IBOutlet weak var myRedemptionfilterView: UIView!
    
    @IBOutlet weak var backOutBTN: UIButton!
    @IBOutlet weak var headerLBL: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    var selectedFromDate = ""
    var selectedToDate = ""
    var VM = MyRedemptionsListViewModel()
    var VM1 = HistoryNotificationsViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var fromSideMenu = ""
    var startDate = ""
    var endDate = ""
    var selectedStatusId = -1
    var selectedStatusName = ""
    var noofelements = 0
    var startindexint = 1
    var itsFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.myRedemptionfilterView.isHidden = false
        self.myRedemptionTableView.register(UINib(nibName: "MSP_MyRedemptionTVC", bundle: nil), forCellReuseIdentifier: "MSP_MyRedemptionTVC")
        self.myRedemptionTableView.separatorStyle = .none
        self.myRedemptionTableView.delegate = self
        self.myRedemptionTableView.dataSource = self
       
        self.myRedemptionTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 110,right: 0)
        if ((tabBarController?.shouldPerformSegue(withIdentifier: "comingFrom", sender: .none)) != nil){
            self.backOutBTN.isHidden = true
            self.headerLBL.textAlignment = .center
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      //  self.notificationListApi()
        self.VM.myRedemptionList.removeAll()
        self.filterView.isHidden = true
        self.loaderView.isHidden = true
        self.startindexint = 1
        selectedFromDate = ""
        selectedToDate = ""
        selectedStatusId = -1
        self.VM.myRedemptionListArray.removeAll()
        self.myRedemptionListApi(startIndex: self.startindexint)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Redemption")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    @IBAction func backBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterCancelBtn(_ sender: Any) {
        self.selectStatusLbl.text = "Select Status"
        self.fromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
        self.selectedFromDate = ""
        self.selectedToDate = ""
        self.selectedStatusId = -1
        self.VM.myRedemptionList.removeAll()
        self.startindexint = 1
        self.myRedemptionListApi(startIndex: self.startindexint)
        self.filterView.isHidden = true
    }
    @IBAction func redemptionFilterBtn(_ sender: Any){
        self.filterView.isHidden = false
    }
    
    
    @IBAction func filterSubmitBtn(_ sender: Any) {
        if self.fromDateLbl.text == "From Date" && self.toDateLbl.text == "To Date" &&  self.selectStatusLbl.text == "Select Status" {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please select date range or status"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.fromDateLbl.text == "From Date" && self.toDateLbl.text == "To Date" &&  self.selectStatusLbl.text != "Select Status" {
            DispatchQueue.main.async{
                self.VM.myRedemptionList.removeAll()
                self.startindexint = 1
                self.itsFrom = "Filter"
                self.myRedemptionListApi(startIndex: self.startindexint)
                    self.filterView.isHidden = true
            }
        }else if self.fromDateLbl.text != "From Date" && self.toDateLbl.text == "To Date" {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select To Date"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if self.fromDateLbl.text == "From Date" && self.toDateLbl.text != "To Date" {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select From Date"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else{
            if self.selectedFromDate > self.selectedToDate{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "To date shouldn't greater than from date"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                self.VM.myRedemptionList.removeAll()
                self.startindexint = 1
                self.itsFrom = "Filter"
                self.myRedemptionListApi(startIndex: self.startindexint)
                    self.filterView.isHidden = true
            }
            
        }
    }
    
    @IBAction func selectStatusActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
        vc!.delegate = self
        vc!.isComeFrom = 8
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func filterToDateBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "2"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func filterFromDateBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
   // {"ActionType":"52","ActorId":"79375","NoOfRows":8,"ObjCatalogueDetails":{"JFromDate":"","JToDate":"","SelectedStatus":"-1"},"StartIndex":1}
    
    func myRedemptionListApi(startIndex: Int){
        //self.VM.myRedemptionList.removeAll()
        let parameters = [
                "ActionType": "52",
                "ActorId": "\(self.userID)",
                "NoOfRows": 20,
                "StartIndex": startIndex,
                "ObjCatalogueDetails": [
                    "JFromDate": "\(self.selectedFromDate)",
                    "JToDate": "\(self.selectedToDate)",
                    "SelectedStatus": "\(self.selectedStatusId)"
                ]
        ] as [String: Any]
        print(parameters)
        self.VM.myRedemptionLists(parameters: parameters) { response in
            self.loaderView.isHidden = true
            let redemptionCatalogeListing = response?.objCatalogueRedemReqList ?? []
            if redemptionCatalogeListing.isEmpty == false{
                self.VM.myRedemptionList = self.VM.myRedemptionList + redemptionCatalogeListing
                self.noofelements = self.VM.myRedemptionList.count
                print(self.noofelements,"No of elements count")
                self.loaderView.isHidden = true
                print(self.VM.myRedemptionList.count, "sadfjlkasdjflksadf")
                if self.VM.myRedemptionList.count != 0{
                   
                        self.myRedemptionTableView.isHidden = false
                        self.noDataFoundLbl.isHidden = true
                        self.myRedemptionTableView.reloadData()
                        self.myRedemptionfilterView.isHidden = false
                }else{
                    self.myRedemptionTableView.isHidden = true
                    self.noDataFoundLbl.isHidden = false
                    self.myRedemptionfilterView.isHidden = false
                }
            }else{
                if self.itsFrom == "Filter"{
                    self.myRedemptionTableView.isHidden = true
                    self.noDataFoundLbl.isHidden = false
                    self.myRedemptionfilterView.isHidden = false
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


extension MSP_MyRedemptionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.myRedemptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_MyRedemptionTVC") as? MSP_MyRedemptionTVC
        cell?.selectionStyle = .none
        
            cell?.productNameLbl.text = VM.myRedemptionList[indexPath.row].productName ?? ""
            cell?.qtyLbl.text = "\(VM.myRedemptionList[indexPath.row].quantity ?? 0)"
            
            let receivedDate = (self.VM.myRedemptionList[indexPath.row].jRedemptionDate ?? "").split(separator: " ")
            let dateFormatted = convertDateFormater(String(receivedDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
            cell?.dateLbl.text = "\(dateFormatted)"
            cell?.refNoLbl.text = "\(self.VM.myRedemptionList[indexPath.row].redemptionRefno ?? "0")"
            cell?.pointsLbl.text = "\(self.VM.myRedemptionList[indexPath.row].redemptionPoints ?? 0)"
            cell?.categoryLbl.text = "\(self.VM.myRedemptionList[indexPath.row].catalogueType ?? "-")"
                    
        var statusDtata = VM.myRedemptionList[indexPath.row].status ?? 0
        //cell.statusLbl.setTitle("\(VM.myRedemptionList[indexPath.row].status ?? 0)", for: .normal)
        if statusDtata == 0{
            cell?.statusLbl.text = "Pending"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.6431372549, blue: 0.01960784314, alpha: 1)
        }else if statusDtata == 1{
            cell?.statusLbl.text = "Approved"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 2{
            cell?.statusLbl.text = "Processed"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 3{
            cell?.statusLbl.text = "Cancelled"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.8, green: 0.05882352941, blue: 0.07843137255, alpha: 1)
        }else if statusDtata == 4{
            cell?.statusLbl.text = "Delivered"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.02745098039, green: 0.6431372549, blue: 0.3529411765, alpha: 1)
        }else if statusDtata == 5{
            cell?.statusLbl.text = "Rejected"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.8, green: 0.05882352941, blue: 0.07843137255, alpha: 1)
        }else if statusDtata == 7{
            cell?.statusLbl.text = "Returned"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 8{
            cell?.statusLbl.text = "Redispatched"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 9{
            cell?.statusLbl.text = "OnHold"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.6431372549, blue: 0.01960784314, alpha: 1)
        }else if statusDtata == 10{
            cell?.statusLbl.text = "Dispatched"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 11{
            cell?.statusLbl.text = "Out for Delivery"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 12{
            cell?.statusLbl.text = "Address Verified"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 13{
            cell?.statusLbl.text = "Posted for Approval"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 14{
            cell?.statusLbl.text = "Vendor Alloted"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 15{
            cell?.statusLbl.text = "Vendor Rejected"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.8, green: 0.05882352941, blue: 0.07843137255, alpha: 1)
        }else if statusDtata == 16{
            cell?.statusLbl.text = "Posted for approval 2"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 17{
            cell?.statusLbl.text = "Cancel Request"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 18{
            cell?.statusLbl.text = "Redemption Verified"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 19{
            cell?.statusLbl.text = "Delivery Confirmed"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 20{
            cell?.statusLbl.text = "Return Requested"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 21{
            cell?.statusLbl.text = "Return Pickup Schedule"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 22{
            cell?.statusLbl.text = "Picked Up"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 23{
            cell?.statusLbl.text = "Return Received"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 24{
            cell?.statusLbl.text = "In Transit"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else if statusDtata == 25{
            cell?.statusLbl.text = "Recieved"
            cell?.statusView.backgroundColor =  #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }else{
            cell?.statusLbl.text = "Recieved"
            cell?.statusView.backgroundColor = #colorLiteral(red: 0.3607843137, green: 0.3843137255, blue: 0.8392156863, alpha: 1)
        }
        return cell!
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let redemptionType = self.VM.myRedemptionList[indexPath.row].redemptionType
        if redemptionType != 3 && redemptionType != 4 && redemptionType != 5{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FG_MyRedemptionDetailsVC") as? FG_MyRedemptionDetailsVC
            vc?.redepmtionId = "\(self.VM.myRedemptionList[indexPath.row].redemptionId ?? 0)"
            vc?.productRefno = "\(self.VM.myRedemptionList[indexPath.row].redemptionRefno ?? "")"
            navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == myRedemptionTableView {
            if indexPath.row == self.VM.myRedemptionList.count - 1{
                if self.noofelements == 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.myRedemptionListApi(startIndex: self.startindexint)
                    
                }else if self.noofelements > 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.myRedemptionListApi(startIndex: self.startindexint)
                    
                }else if noofelements < 20{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }
    }
}
