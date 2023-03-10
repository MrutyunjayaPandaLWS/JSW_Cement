//
//  MSP_NotificationVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 26/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_NotificationVC: BaseViewController {
    
    @IBOutlet weak var notificationListTableView: UITableView!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM = HistoryNotificationsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
        self.loaderView.isHidden = true
        self.notificationListTableView.separatorStyle = .none
        self.notificationListTableView.register(UINib(nibName: "MSP_NotificationTVC", bundle: nil), forCellReuseIdentifier: "MSP_NotificationTVC")
        self.notificationListTableView.delegate = self
        self.notificationListTableView.dataSource = self
        self.notificationListTableView.separatorStyle = .none
        
        self.loaderView.isHidden = false
        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.notificationListApi()
        })
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Notification")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func notificationListApi(){
        DispatchQueue.main.async {
          self.startLoading()
        }
        let parameters = [
            "ActionType": 0,
            "ActorId": "\(userID)",
            "LoyaltyId": self.loyaltyId
        ] as [String: Any]
        print(parameters)
        self.VM.notificationListApi(parameters: parameters) { response in
            self.VM.notificationListArray = response?.lstPushHistoryJson ?? []
            print(self.VM.notificationListArray.count)
            DispatchQueue.main.async {
                if self.VM.notificationListArray.count != 0 {
                    DispatchQueue.main.async {
                        self.notificationListTableView.isHidden = false
                        self.noDataFoundLbl.isHidden = true
                        self.notificationListTableView.reloadData()
                    }
                }else{
                    self.noDataFoundLbl.isHidden = false
                    self.notificationListTableView.isHidden = true
                    
                }
                self.loaderView.isHidden = true
                self.stopLoading()
            }
        }
        
    }
    
}
extension MSP_NotificationVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.notificationListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_NotificationTVC") as? MSP_NotificationTVC
        cell?.selectionStyle = .none
        cell?.customerNameLbl.text = VM.notificationListArray[indexPath.row].title ?? "-"
        let receivedDate = (self.VM.notificationListArray[indexPath.row].jCreatedDate ?? "").split(separator: " ")
        cell?.dataLbl.text = self.VM.notificationListArray[indexPath.row].jCreatedDate
        cell?.pushMessageLbl.text = self.VM.notificationListArray[indexPath.row].pushMessage
//        let imageurl = VM.notificationListArray[indexPath.row].imagesURL ?? ""
//        let totalImgURL = PROMO_IMG1 + imageurl
//        print(totalImgURL, "Total Image URL")
//        cell?.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "icons8-life-cycle-96"))
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
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
