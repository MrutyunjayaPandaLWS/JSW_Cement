//
//  MSP_OffersandPromotionsDetailsVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit
import WebKit
import SDWebImage
import Firebase
import Lottie
class MSP_OffersandPromotionsDetailsVC: BaseViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var notifiCountLbl: UILabel!
    
    @IBOutlet weak var productNameLbl: UILabel!
    
    @IBOutlet weak var shortDescriptionLbl: UILabel!
    @IBOutlet weak var descriptionWK: UIWebView!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    var VM1 = HistoryNotificationsViewModel()
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var shortDesc = ""
    var longDesc = ""
    var productImg = ""
    var productName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productNameLbl.text = self.productName
        self.shortDescriptionLbl.text = self.shortDesc
        self.productImage.sd_setImage(with: URL(string: productImg), placeholderImage: UIImage(named: "ic_default_img"))
        self.descriptionWK.loadHTMLString(self.longDesc, baseURL: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
      //  self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Offers & Promotion Details")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
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
                self.notifiCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notifiCountLbl.isHidden = true
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
