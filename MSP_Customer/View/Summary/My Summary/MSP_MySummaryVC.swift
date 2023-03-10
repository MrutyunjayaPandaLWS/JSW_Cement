//
//  MSP_MySummaryVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//My Performance

import UIKit
import Firebase
import Lottie
class MSP_MySummaryVC: BaseViewController {

    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var mySummaryTableView: UITableView!
    @IBOutlet weak var notificationCountLbl: UILabel!
    
    @IBOutlet var mySummaryView: UIView!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    
    var fromSideMenu = ""
    let customerMobile = UserDefaults.standard.string(forKey: "CustomerMobile") ?? ""
    let VM = MySummeryModels()
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        mySummaryTableView.delegate = self
        mySummaryTableView.dataSource = self
        self.noDataFoundLbl.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loaderView.isHidden = true
        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.mySummeryAPI()
            //self.notificationListApi()
        })

       
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Summery")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
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
    func mySummeryAPI(){
        let parameterJSON = [
     
            "ActionType": 8,
            "UserName": "\(loyaltyId)",
            "CustomerTypeID":1
        ] as  [String:Any]
        print(parameterJSON)
        self.VM.mySummeryAPI(parameters: parameterJSON)
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
extension MSP_MySummaryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.mySummeryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_MySummaryTVC", for: indexPath) as? MSP_MySummaryTVC
        cell?.selectionStyle = .none
        cell?.monthLbl.text = VM.mySummeryArray[indexPath.row].monthName ?? "-"
        print(VM.mySummeryArray[indexPath.row].approvedQty ?? 0,"ksdhgjdg")
        cell?.approvedQtyLbl.text = "\(Double(VM.mySummeryArray[indexPath.row].approvedQty ?? 0))"
        cell?.pendingQty.text = "\(Double(VM.mySummeryArray[indexPath.row].pendingQty ?? 0))"
        cell?.rejectedQty.text = "\(Double(VM.mySummeryArray[indexPath.row].rejectedQty ?? 0))"
        cell?.volumeClaimed.text = "\(Double(VM.mySummeryArray[indexPath.row].volumeClaimed ?? 0))"
        return cell!
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 60
    //    }
    
    
}
