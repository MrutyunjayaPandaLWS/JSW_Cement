//
//  MSP_MyEarningsVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 24/11/22.
//

import UIKit
import Firebase
import Lottie

class MSP_MyEarningsVC: BaseViewController , DateSelectedDelegate, popUpDelegate{

    @IBOutlet weak var fromDateLbl: UILabel!
    
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet var myEarningsTableView: UITableView!
    @IBOutlet var myEarningsCountLbl: UILabel!
    @IBOutlet var noDataFoundLbl: UILabel!
    @IBOutlet var myEarningsFilterOutBtn: UIButton!
    @IBOutlet var myEarningFilterView: UIView!
    @IBOutlet var myEarningFilterButtonView: UIView!
    @IBOutlet var backOutBTN: UIButton!
    @IBOutlet weak var headerLBL: UILabel!
   // @IBOutlet var filterByStatusLbl: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
    @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    var selectedFromDate = ""
    var selectedToDate = ""
    var fromSideMenu = ""
    var startDate = ""
    var endDate = ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM = MyEarningsViewModel()
    var VM1 = HistoryNotificationsViewModel()
    var noofelements = 0
    var startindexint = 1
    var itsFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = false
        
        self.noDataFoundLbl.isHidden = true
        self.myEarningFilterView.isHidden = true
        self.myEarningsTableView.delegate = self
        self.myEarningsTableView.dataSource = self
        self.myEarningsTableView.separatorStyle = .none
        self.myEarningsTableView.register(UINib(nibName: "MSP_MyEarningsTVC", bundle: nil), forCellReuseIdentifier: "MSP_MyEarningsTVC")
        
        
        if ((tabBarController?.shouldPerformSegue(withIdentifier: "comingFromEarn", sender: .none)) != nil){
            self.backOutBTN.isHidden = true
            self.headerLBL.textAlignment = .center
        }
        self.myEarningsTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 110,right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myEarningFilterView.isHidden = true
        selectedFromDate = ""
        selectedToDate = ""
        self.loaderView.isHidden = true
        self.playAnimation()
        self.VM.myEarningListArray.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            self.myEarningListApi(startIndex: 1)
        })
       
        self.myEarningFilterButtonView.isHidden = false
       
        
       // self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Earning")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }

    
    @IBAction func myEarningsFilterBtn(_ sender: Any) {
        self.myEarningFilterView.isHidden = false
        
    }
    @IBAction func myEaningsBellBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyDreamGiftVC") as! MSP_MyDreamGiftVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func myEarningsBackBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func fromDateActionBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func toDateActionBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "2"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func cancelActionBtn(_ sender: Any) {
        
        self.fromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
        self.selectedFromDate = ""
        self.selectedToDate = ""
        self.itsFrom = "Filter"
        self.startindexint = 1
        self.VM.myEarningListArray.removeAll()
        self.myEarningListApi(startIndex: self.startindexint)
        self.myEarningFilterView.isHidden = true
        
    }
    
    @IBAction func filterActBtn(_ sender: Any) {
        if self.fromDateLbl.text ?? "" == "From Date"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please enter From date"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.toDateLbl.text ?? "" == "To Date" {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please enter To date"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if self.toDateLbl.text ?? "" != "To Date" && self.fromDateLbl.text ?? "" != "From Date" {
            if self.selectedFromDate > self.selectedToDate{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "To date shouldn't greater than From date"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                self.itsFrom = "Filter"
                self.startindexint = 1
                self.VM.myEarningListArray.removeAll()
                self.myEarningListApi(startIndex: self.startindexint)
                self.myEarningFilterView.isHidden = true
            }
        }
    }
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    func acceptDate(_ vc: MSP_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromDateLbl.text = self.selectedFromDate
            
        }else{
            self.selectedToDate = vc.selectedDate
            self.toDateLbl.text = self.selectedToDate
        }
    }
    func declineDate(_ vc: MSP_DOBVC) {
        self.dismiss(animated: true)
    }
    
    //API:-
    
    //{"ActionType":3,"ActiveStatus":-2,"FromDate":"","PageSize":20,"SalesPersonId":"MSP000426","StartIndex":1,"ToDate":""}
    //["ActiveStatus": "-2", "ActionType": "3", "PageSize": "20", "SalesPersonId": "MSP000426", "StartIndex": 1, "FromDate": "", "ToDate": ""]
    
    func myEarningListApi(startIndex: Int){
        self.VM.myEarningListArray.removeAll()
        let parameters = [
            "ActionType": "3",
            "ActiveStatus": "-2",
            "PageSize": "20",
            "SalesPersonId": "\(UserDefaults.standard.string(forKey: "LoyaltyID") ?? "")",
            "StartIndex": startIndex,
            "FromDate": "\(self.selectedFromDate)",
            "ToDate": "\(self.selectedToDate)"
        ] as [String: Any]
        print(parameters)
        self.VM.myEarningListAPi(parameters: parameters) { response in
            
                
            let myEarningArrayListing = response?.customerBasicInfoListJson ?? []
            if myEarningArrayListing.isEmpty == false{
            DispatchQueue.main.async {
                self.loaderView.isHidden = true
                self.stopLoading()
            
                    self.VM.myEarningListArray = self.VM.myEarningListArray + myEarningArrayListing
                    self.noofelements = self.VM.myEarningListArray.count
                    print(self.noofelements,"Count")
                    print(self.VM.myEarningListArray.count)
                    if self.VM.myEarningListArray.count != 0 {
                        self.myEarningsTableView.isHidden = false
                        self.noDataFoundLbl.isHidden = true
                        self.myEarningFilterButtonView.isHidden = false
                        self.myEarningsTableView.reloadData()
                    }else{
                        self.myEarningsTableView.isHidden = true
                        self.noDataFoundLbl.isHidden = false
                        self.myEarningFilterButtonView.isHidden = false
                    }
                }
            }else{
                //                if self.itsFrom == "Filter"{
                print("Resposadfasdfsadf")
                self.myEarningsTableView.isHidden = true
                self.noDataFoundLbl.isHidden = false
                self.myEarningFilterButtonView.isHidden = false
                //                }
                
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
                self.myEarningsCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.myEarningsCountLbl.isHidden = true
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

extension MSP_MyEarningsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myEarningListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_MyEarningsTVC") as! MSP_MyEarningsTVC
        cell.selectionStyle = .none
        if self.VM.myEarningListArray.count != 0 {
            
            cell.productNameLbl.text = VM.myEarningListArray[indexPath.row].productName ?? ""
            cell.dateLbl.text = "\(self.VM.myEarningListArray[indexPath.row].trxnDate ?? "")"
            cell.pointsLbl.text = "\(Double(self.VM.myEarningListArray[indexPath.row].creditedPoint ?? 0))"
            cell.quantityLbl.text = "\(Double(self.VM.myEarningListArray[indexPath.row].quantity ?? 0))"
            cell.delaerNameLbl.text = "\(self.VM.myEarningListArray[indexPath.row].requestTo ?? "")"
            cell.claimIDLbl.text = self.VM.myEarningListArray[indexPath.row].invoiceNo ?? "0"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == myEarningsTableView {
            if indexPath.row == self.VM.myEarningListArray.count - 1{
                if self.noofelements == 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.myEarningListApi(startIndex: self.startindexint)
                }else if self.noofelements > 20{
                    self.startindexint = self.startindexint + 1
                    self.itsFrom = "Pagination"
                    self.myEarningListApi(startIndex: self.startindexint)
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
