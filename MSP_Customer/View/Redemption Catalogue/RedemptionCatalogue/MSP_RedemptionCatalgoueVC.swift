//
//  MSP_RedemptionCatalgoueVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_RedemptionCatalgoueVC: BaseViewController, ViewTappedDelegate {
    func didTapView(_ cell: MSP_RedemptionCatalogueTVC) {
        guard let tappedIndexPath = self.redemptionCatalogueTableView.indexPath(for: cell) else {return}
        if cell.viewBtn.tag == tappedIndexPath.row{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ProductCatalogueVC") as! MSP_ProductCatalogueVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var redemptionCatalogueTableView: UITableView!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    let redemptionBalance = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    var viewArray = ["View"]
    var VM1 = HistoryNotificationsViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = true
        print(redemptionBalance ?? 0,"Balance")
        self.totalPoints.text = "\(redemptionBalance ?? 0)"
        self.redemptionCatalogueTableView.register(UINib(nibName: "MSP_RedemptionCatalogueTVC", bundle: nil), forCellReuseIdentifier: "MSP_RedemptionCatalogueTVC")
        redemptionCatalogueTableView.delegate = self
        redemptionCatalogueTableView.dataSource = self
        self.loaderView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
     //   self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Redemption Catalogue")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cartBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyCartVC") as! MSP_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension MSP_RedemptionCatalgoueVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_RedemptionCatalogueTVC") as? MSP_RedemptionCatalogueTVC
        cell?.delegate = self
        cell?.viewLbl.text = self.viewArray[indexPath.row]
        cell?.viewBtn.tag = indexPath.row
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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
