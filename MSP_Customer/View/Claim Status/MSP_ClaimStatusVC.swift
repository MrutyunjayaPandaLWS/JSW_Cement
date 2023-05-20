//
//  MSP_Claim StatusVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 24/11/22.
//

import UIKit
import Firebase
import Lottie
class MSP_ClaimStatusVC: BaseViewController, DateSelectedDelegate, popUpDelegate, DropDownDelegate{
    func redemptionStatusDidTap(_ vc: MSP_DropDownVC) {}
    
    func stateDidTap(_ vc: MSP_DropDownVC) {}
    func cityDidTap(_ vc: MSP_DropDownVC) {}
    func preferredLanguageDidTap(_ vc: MSP_DropDownVC) {}
    func genderDidTap(_ vc: MSP_DropDownVC) {}
    func titleDidTap(_ vc: MSP_DropDownVC) {}
    func dealerDipTap(_ vc: MSP_DropDownVC) {}
    func statusDipTap(_ vc: MSP_DropDownVC) {
        self.selectStatusLbl.text =  vc.selectedStatusName
        self.selectedStatusId = "\(vc.selectedStatusId)"
    }
    

    @IBOutlet var filterScreenView: GradientView!
    @IBOutlet var claimsCountLbl: UILabel!
    @IBOutlet var claimsTableView: UITableView!
    @IBOutlet var filterOutBtn: UIButton!
    @IBOutlet var filterFromDateBtn: UIButton!
    @IBOutlet var filterToDateBtn: UIButton!
    @IBOutlet var selectStatusBtn: UIButton!
    @IBOutlet var filterView: UIView!
    @IBOutlet var noDataLbl: UILabel!
    
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    
    @IBOutlet weak var selectStatusLbl: UILabel!
    
    @IBOutlet weak var filterBtn: GradientButton!
    @IBOutlet weak var cancelBtn: GradientButton!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    
    var selectedFromDate = ""
    var selectedToDate = ""
    var fromSideMenu = ""
    var VM = MSP_ClaimStatusVM()
    var startDate = ""
    var endDate = ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    var selectedStatusId = "-2"
    var noofelements = 0
    var startindexint = 1
    var itsFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
      
        self.cancelBtn.backgroundColor = .clear
        self.cancelBtn.setTitleColor(.black, for: .normal)
        self.noDataLbl.isHidden = true
        self.filterView.isHidden = true
        self.claimsTableView.delegate = self
        self.claimsTableView.dataSource = self
        self.claimsTableView.register(UINib(nibName: "MSP_ClaimStatusTVC", bundle: nil), forCellReuseIdentifier: "MSP_ClaimStatusTVC")
        self.loaderView.isHidden = false
        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.claimPointsApi(startIndex: self.startindexint)
        })
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        self.loaderView.isHidden = true
      //  self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Claim Status")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    
    @IBAction func claimStatusNotificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func claimsBackBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func filterActBtn(_ sender: Any) {
        self.filterView.isHidden = false
        self.cancelBtn.backgroundColor = .clear
        self.cancelBtn.setTitleColor(.black, for: .normal)
    }
    
    
    @IBAction func fromDateActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func toDateActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "2"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func selectStatusActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
        vc!.delegate = self
        vc!.isComeFrom = 7
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func filterSubmitButton(_ sender: Any) {
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
                self.VM.claimStatusArray.removeAll()
                self.startindexint = 1
                self.itsFrom = "Filter"
                self.claimPointsApi(startIndex: self.startindexint)
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
                self.VM.claimStatusArray.removeAll()
                self.startindexint = 1
                self.itsFrom = "Filter"
                self.claimPointsApi(startIndex: self.startindexint)
                    self.filterView.isHidden = true
            }
            
        }
    }
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    
    @IBAction func filterCancelBtn(_ sender: Any) {
        self.fromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
        self.selectStatusLbl.text = "Select Status"
        self.selectedStatusId = "-2"
        self.selectedFromDate = ""
        self.selectedToDate = ""
        self.VM.claimStatusArray.removeAll()
        self.startindexint = 1
        self.itsFrom = "Filter"
        self.claimPointsApi(startIndex: self.startindexint)
        self.filterView.isHidden = true
    }
    
    func acceptDate(_ vc: MSP_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromDateLbl.text = vc.selectedDate
        }else{
            self.selectedToDate = vc.selectedDate
            self.toDateLbl.text = self.selectedToDate
        }
    }
    func declineDate(_ vc: MSP_DOBVC) {
        self.dismiss(animated: true)
    }
    
    
    //API:-
    
   // {"ActionType":4,"ActiveStatus":"-2","FromDate":"","PageSize":8,"SalesPersonId":"MSP000327","StartIndex":1,"ToDate":""}
    func claimPointsApi(startIndex: Int) {
        self.VM.claimStatusArray.removeAll()
        let parameters = [
            "ActionType": 4,
            "ActiveStatus": "\(self.selectedStatusId)",
            "FromDate": "\(selectedFromDate)",
            "ToDate": "\(selectedToDate)",
            "PageSize": 20,
            "SalesPersonId": "\(self.loyaltyId)",
            "StartIndex": "\(startIndex)"
        ]  as [String : Any]
        print(parameters)
        self.VM.claimStatusApi(parameters: parameters)
            
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
                self.claimsCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.claimsCountLbl.isHidden = true
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
extension MSP_ClaimStatusVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.claimStatusArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_ClaimStatusTVC") as! MSP_ClaimStatusTVC
        cell.selectionStyle = .none
        cell.productNameLbl.text = self.VM.claimStatusArray[indexPath.row].productName ?? "-"
        cell.quantityLbl.text = "\(self.VM.claimStatusArray[indexPath.row].quantity ?? 0)"
        cell.dealerNameLbl.text = self.VM.claimStatusArray[indexPath.row].retailerName ?? "-"
        cell.claimsIDLbl.text = self.VM.claimStatusArray[indexPath.row].invoiceNo ?? "-"
        cell.remarksLbl.text = self.VM.claimStatusArray[indexPath.row].remarks ?? "-"
        //cell.DealerCodeLbl.text = self.VM.claimStatusArray[indexPath.row].dealerCode ?? ""
        cell.earnedPointsLbl.text = "\(Int(self.VM.claimStatusArray[indexPath.row].creditedPoint ?? 0))"
        
            if self.VM.claimStatusArray[indexPath.row].status ?? "-" == "Pending" || self.VM.claimStatusArray[indexPath.row].status ?? "-" == "Escalated"{
                cell.claimStatusView.backgroundColor = #colorLiteral(red: 0.8686603904, green: 0.6390978098, blue: 0.02780325711, alpha: 1)
            }else if self.VM.claimStatusArray[indexPath.row].status ?? "-" == "Approved"{
                cell.claimStatusView.backgroundColor = #colorLiteral(red: 0.03790682182, green: 0.6447886229, blue: 0.3517391384, alpha: 1)
            }else if self.VM.claimStatusArray[indexPath.row].status ?? "-" == "Rejected"{
                cell.claimStatusView.backgroundColor = #colorLiteral(red: 0.7981722951, green: 0.05850049108, blue: 0.0840594396, alpha: 1)
            }else{
                cell.claimStatusView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        cell.claimsStatus.text = self.VM.claimStatusArray[indexPath.row].status ?? "-"
        cell.claimRemarksLbl.text = self.VM.claimStatusArray[indexPath.row].claimedRemarks ?? "-" 
        let date = "\(VM.claimStatusArray[indexPath.row].trxnDate ?? "-")"
        //"Dec 15 2022  2:40PM"
        //let receivedDate = (self.VM.claimStatusArray[indexPath.row].trxnDate ?? "").split(separator: " ")
       // let dateFormatted = convertDateFormater(String(date), fromDate: "MMM dd yyyy HH:mm a", toDate: "dd/MM/yyyy")
       let dateFormatted = convertDateFormater(String(date), fromDate: "MMM dd yyyy hh:mma", toDate: "dd/MM/yyyy")
        cell.dateLbl.text = "\(dateFormatted)"
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == claimsTableView {
            if indexPath.row == self.VM.claimStatusArray.count - 1{
                if self.noofelements == 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.claimPointsApi(startIndex: self.startindexint)
                }else if self.noofelements > 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.claimPointsApi(startIndex: self.startindexint)
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
    
}
