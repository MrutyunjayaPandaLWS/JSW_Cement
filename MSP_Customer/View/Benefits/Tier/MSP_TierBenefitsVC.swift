//
//  MSP_TierBenefitsVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 18/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_TierBenefitsVC: UIViewController {
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
        @IBOutlet weak var loaderView: UIView!

    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tierBenefitsTableView: UITableView!
    @IBOutlet weak var tierView: UIView!
    var tierListingArray = ["Bronze", "Silver","Gold","Platinum"]
    
    var tierListingArray1 = ["0 to 199 Points","200 to 399 Points","400 to 799 Points","800 & Above Points"]
    
    var tierListingArray2 = ["0% additional bonus on your claim approval","10% additional bonus on your earnings after claim approval","20% additional bonus on your earnings after claim approval","30% additional bonus on your earnings after claim approval"]
    
    
    var fromSideMenu = ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDataFoundLbl.isHidden = false
        self.tierBenefitsTableView.delegate = self
        self.tierBenefitsTableView.dataSource = self
        self.tierBenefitsTableView.isHidden = false
        self.tierView.isHidden = true
        self.loaderView.isHidden = true
//        if self.tierListingArray.count >= 10{
//            self.tableViewHeightConstraint.constant = 550
//        }else{
//            self.tableViewHeightConstraint.constant = CGFloat( self.tierListingArray.count * 50)
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
     //   self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Tier Benefits")
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
}
extension MSP_TierBenefitsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tierListingArray.count
    //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_TierBenefitsTVC") as! MSP_TierBenefitsTVC
        cell.selectionStyle = .none
        cell.tierLbl.text = tierListingArray[indexPath.row]
        cell.pointsSlabLbl.text = tierListingArray1[indexPath.row]
        cell.benefitsLbl.text = tierListingArray2[indexPath.row]
        
        return cell
    }
//
//    func playAnimation(){
//               animationView = .init(name: "Loader_v4")
//                 animationView!.frame = loaderAnimatedView.bounds
//                 // 3. Set animation content mode
//                 animationView!.contentMode = .scaleAspectFit
//                 // 4. Set animation loop mode
//                 animationView!.loopMode = .loop
//                 // 5. Adjust animation speed
//                 animationView!.animationSpeed = 0.5
//                loaderAnimatedView.addSubview(animationView!)
//                 // 6. Play animation
//                 animationView!.play()
//
//           }
}
