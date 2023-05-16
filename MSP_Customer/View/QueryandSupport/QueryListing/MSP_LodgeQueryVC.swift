//
//  MSP_LodgeQueryVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 23/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_LodgeQueryVC: BaseViewController, DropDownDelegate, DateSelectedDelegate, popUpDelegate {
    func redemptionStatusDidTap(_ vc: MSP_DropDownVC) {
        self.selectedStatusName = vc.selectedRedemptionStatus
        self.selectStatusLbl.text = vc.selectedRedemptionStatus
        self.selectedStatusId = vc.seletedRedemptionStatusId
        
//        Pending - 1
//
//        Re-open - 2
//
//        Resolved - 3
//
//        Closed - 4
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
    

    @IBOutlet weak var filterShadowView: UIView!
    @IBOutlet weak var lodgeQueryTabelView: UITableView!
    @IBOutlet weak var notificaitonLbl: UILabel!
    
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    
    @IBOutlet weak var selectStatusLbl: UILabel!
    @IBOutlet weak var filterButton: GradientView!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    var selectedStatusName = ""
    var selectedStatusId = -1
    var selectedFromDate = ""
    var selectedToDate = ""
    var noofelements = 0
    var startindexint = 1
    
    var CustomerTicketIDchatvc = "-100"
    var CustomerTicketID = ""
    var catalogueList = ""
    var codeDataToShow = [String]()
    var storyboard1 = UIStoryboard(name: "Main", bundle: nil)
    var topicselectedID:String = ""
    var isfromStatus = 0
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    let VM = LodgeListViewModel()
    var helpTopicListingArray = [ObjHelpTopicList]()
    var fromSideMenu = ""
    var itsFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = false
        self.playAnimation()
        self.noDataFoundLbl.textColor = .white
    //    self.loaderView.isHidden = true
        self.filterShadowView.isHidden = true
        self.filterView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.VM.VC = self
        self.noDataFoundLbl.isHidden = true
        self.lodgeQueryTabelView.register(UINib(nibName: "MSP_LodgeQueryTVC", bundle: nil), forCellReuseIdentifier: "MSP_LodgeQueryTVC")
        self.lodgeQueryTabelView.delegate = self
        self.lodgeQueryTabelView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.loaderView.isHidden = true
        self.VM.queryListsArray.removeAll()
        self.VM.queryListingArray.removeAll()
      
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.queryListApi(startIndex: self.startindexint)
           // self.notificationListApi()
        })
      
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "LodgeQuery Listing")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == filterShadowView{
            self.filterShadowView.isHidden = true
        }
    }

    @IBAction func backBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func notificaitonBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func raiseTicketBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_CreateNewQueryVC") as! MSP_CreateNewQueryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        self.filterShadowView.isHidden = false
    }
    
    @IBAction func selectedStatusBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
        vc!.delegate = self
        vc!.isComeFrom = 9
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func fromDateButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func toDateBtn(_ sender: Any) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
            vc!.delegate = self
            vc!.isComeFrom = "2"
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .coverVertical
            self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func filterByStatusBtn(_ sender: Any) {
        if self.fromDateLbl.text == "From Date" && self.toDateLbl.text == "To Date" &&  self.selectStatusLbl.text == "Select Status" {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please select date range or select status or both"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.fromDateLbl.text == "From Date" && self.toDateLbl.text == "To Date" &&  self.selectStatusLbl.text != "Select Status" {
            DispatchQueue.main.async{
                self.VM.queryListingArray.removeAll()
                self.startindexint = 1
                self.itsFrom = "Filter"
                self.queryListApi(startIndex: self.startindexint)
                self.filterShadowView.isHidden = true
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
                    vc!.descriptionInfo = "To date shouldn't be smaller than from date"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                self.VM.queryListingArray.removeAll()
                self.itsFrom = "Filter"
                self.startindexint = 1
                self.queryListApi(startIndex: self.startindexint)
                self.filterShadowView.isHidden = true
            }
            
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.selectStatusLbl.text = "Select Status"
        self.fromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
        self.selectedFromDate = ""
        self.selectedToDate = ""
        self.selectedStatusId = -1
        self.VM.queryListingArray.removeAll()
        self.startindexint = 1
        self.queryListApi(startIndex: self.startindexint)
        self.filterShadowView.isHidden = true
    }

    func queryListApi(startIndex: Int){
        
//        self.VM.queryListingArray.removeAll()
        let parameters = [
            "ActionType": "1",
            "ActorId": "\(userID)",
            "HelpTopicID": "",
            "JFromDate":"\(self.selectedFromDate)",
            "JToDate":"\(self.selectedToDate)",
            "PageSize": 20,
            "StartIndex": "\(startIndex)",
            "TicketStatusId": "\(self.selectedStatusId)"
        ] as [String: Any]
        print(parameters)
        self.VM.queryListingApi(parameters: parameters) { response in
            let noOfQueryListing = response?.objCustomerAllQueryJsonList ?? []
            if noOfQueryListing.isEmpty == false{
                self.VM.queryListingArray += noOfQueryListing
                self.noofelements = self.VM.queryListingArray.count
                DispatchQueue.main.async {
                    if self.VM.queryListingArray.count != 0 {
                        self.noDataFoundLbl.isHidden = true
                        self.lodgeQueryTabelView.isHidden = false
                        self.lodgeQueryTabelView.reloadData()
                        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification1033(notification:)), name: Notification.Name("NotificationIdentifier103-3"), object: nil)

                    }else{
                        self.lodgeQueryTabelView.isHidden = true
                        self.noDataFoundLbl.isHidden = false
                    }
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }else{
                if self.itsFrom == "Filter"{
                    self.loaderView.isHidden = true
                    self.stopLoading()
                    self.lodgeQueryTabelView.isHidden = true
                    self.noDataFoundLbl.isHidden = false
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
                self.notificaitonLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notificaitonLbl.isHidden = true
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
    
    
}
extension MSP_LodgeQueryVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.queryListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_LodgeQueryTVC", for: indexPath) as! MSP_LodgeQueryTVC
        cell.selectionStyle = .none
        let querydateAndTime = VM.queryListingArray[indexPath.row].jCreatedDate ?? ""
        let querydateAndTimeArray = querydateAndTime.components(separatedBy: " ")
        cell.queryDate.text = "\(querydateAndTimeArray[0])"
        cell.queryStatusLbl.text = VM.queryListingArray[indexPath.row].ticketStatus ?? "-"
        cell.queryInfo.text = VM.queryListingArray[indexPath.row].helpTopic ?? "-"
        cell.queryTimeLbl.text = "\(querydateAndTimeArray[1])"
        cell.queryRefLbl.text = VM.queryListingArray[indexPath.row].customerTicketRefNo ?? "-"
        
        
//        cell.querystatus.text = VM.queryListingArray[indexPath.section].ticketStatus ?? ""
//        cell.selectionStyle = .none
//        cell.querycode.text = VM.queryListingArray[indexPath.section].customerTicketRefNo ?? ""
//        cell.querydetails.text = "  \(VM.queryListingArray[indexPath.section].helpTopic ?? "")"
//        let querydateAndTime = VM.queryListingArray[indexPath.section].jCreatedDate ?? ""
//        let querydateAndTimeArray = querydateAndTime.components(separatedBy: " ")
//        cell.querydate.text = querydateAndTimeArray[0]
//        cell.querytime.text = querydateAndTimeArray[1]
        
        
        if CustomerTicketID == CustomerTicketIDchatvc{
            let centerviewcontroller = self.storyboard1.instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
            print(VM.queryListingArray[indexPath.section].customerTicketID!)
            centerviewcontroller.CustomerTicketIDchatvc = "\(VM.queryListingArray[indexPath.section].customerTicketID ?? 0)"
            centerviewcontroller.helptopicid = "\(VM.queryListingArray[indexPath.section].helpTopicID ?? 0)"
            centerviewcontroller.querysummary = VM.queryListingArray[indexPath.section].querySummary ?? ""
            centerviewcontroller.helptopicdetails = VM.queryListingArray[indexPath.section].helpTopic ?? ""
            centerviewcontroller.querydetails = "  \(VM.queryListingArray[indexPath.section].queryDetails ?? "")"
            self.navigationController?.pushViewController(centerviewcontroller, animated: true)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let centerviewcontroller = self.storyboard1.instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
        print(VM.queryListingArray[indexPath.section].customerTicketID ?? 0)
        centerviewcontroller.CustomerTicketIDchatvc = "\(VM.queryListingArray[indexPath.row].customerTicketID ?? 0)"
        centerviewcontroller.helptopicid = "\(VM.queryListingArray[indexPath.row].helpTopicID ?? 0)"
        centerviewcontroller.querysummary = VM.queryListingArray[indexPath.row].querySummary ?? ""
        centerviewcontroller.helptopicdetails = VM.queryListingArray[indexPath.row].helpTopic ?? ""
        centerviewcontroller.querydetails = VM.queryListingArray[indexPath.row].queryDetails ?? ""
        self.navigationController?.pushViewController(centerviewcontroller, animated: true)
  
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == lodgeQueryTabelView {
            if indexPath.row == self.VM.queryListingArray.count - 1{
                if self.noofelements == 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.queryListApi(startIndex: self.startindexint)
                }else if self.noofelements > 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.queryListApi(startIndex: self.startindexint)
                }else if noofelements < 20{
                    //myEarningsTableView.reloadData()
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }
    }
    @objc func methodOfReceivedNotification1033(notification: Notification) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController
        vc?.CustomerTicketIDchatvc = UserDefaults.standard.string(forKey: "pushSpecificID") ?? "-1"
        self.navigationController?.pushViewController(vc!, animated: true)
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
