//
//  MSP_SideMenuViewController.swift
//  MSP
//
//  Created by admin on 21/11/22.
//

import UIKit
import SlideMenuControllerSwift
import CoreData
import SDWebImage
import Photos
import Lottie
import QCropper
class MSP_SideMenuViewController: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sidemenuTableView: UITableView!
    @IBOutlet var profileImageBtn: UIButton!
    @IBOutlet var userGradeImage: UIImageView!
    @IBOutlet var userGradeLbl: UILabel!
    @IBOutlet var totalPointsLbl: UILabel!
    @IBOutlet var customerNameLbl: UILabel!
    @IBOutlet var customerIDLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet var sideView: GradientView!
    @IBOutlet weak var memberSinceLbl: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    var sideMenuItems = [SideMenuModel]()
    var benefitsItem = [SecondMenuList]()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    let customerTypeId = UserDefaults.standard.value(forKey: "CustomerTypeId") ?? 0
    var vm = SideMenuViewModel()
    let picker = UIImagePickerController()
    var strBase64 = ""
    var fileType = ""
    var helpId = ""
    var strdata1 = ""
    var selectedIndex = -1
    var vm1 = RedemptionPlannerListViewModel()
    var parameters: JSON?
    var secondIndex = ["",""]
    var itsFrom = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = true
        self.vm.VC = self
        self.vm1.vC2 = self
        self.picker.delegate = self
        self.sidemenuTableView.delegate = self
        self.sidemenuTableView.dataSource = self
        self.sidemenuTableView.separatorStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(closingSideMenu), name: Notification.Name.sideMenuClosing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deletedAccount), name: Notification.Name.deleteAccount, object: nil)
        sideView.layer.cornerRadius = 35
        sideView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.sideView.clipsToBounds = true
        //NotificationCenter.default.post(name: .goToDashBoardAPI, object: nil)
        self.loaderView.isHidden = false
        self.playAnimation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
            self.dashboardAPI()
            self.addItemsIntoArray()
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
        self.userImage.clipsToBounds = true
        self.memberSinceLbl.text = "Member Since \(UserDefaults.standard.string(forKey: "MemberSince") ?? "")"
        self.sidemenuTableView.isScrollEnabled = false
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Side Menu")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        print(sideMenuItems.count,"kjk")
        
        //let noOfCount = sideMenuItems.count * 50
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    @objc func closingSideMenu(){
        self.closeLeft()
    }
    @objc func deletedAccount(){
        
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
        self.clearTable()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        if #available(iOS 13.0, *) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            sceneDelegate?.setInitialViewAsRootViewController()

        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.setInitialViewAsRootViewController()
        }
     
    }
    @IBAction func takeProfilePic(_ sender: Any){
        self.closeLeft()
        let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            self.closeLeft()
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
            self.openRight()
        })
        
    }
    
    @IBAction func logoutActBtn(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "IsloggedIn?")
        
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
             //   self.clearTable2()
            }
        } else {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                if #available(iOS 13.0, *) {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setInitialViewAsRootViewController()
                } else {
                    // Fallback on earlier versions
                }
                
              //  self.clearTable2()
            }
        }
    }
//    func clearTable2(){
//        let context = persistanceservice.persistentContainer.viewContext
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AddToCART")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        } catch {
//            print ("There was an error")
//        }
//    }
 
    func addItemsIntoArray(){
        DispatchQueue.main.async {
            self.sideMenuItems.removeAll()
            self.benefitsItem.removeAll()
            print(self.customerTypeId,"ldsjkd")
            if self.customerTypeId as! Int == 51{
                self.benefitsItem.append(SecondMenuList(sideMenuItem: "Program Benefits", sideMenuID: 22, sidemenuImage: "redeem"))
            }else{
                self.benefitsItem.append(SecondMenuList(sideMenuItem: "Tier Benefits", sideMenuID: 21, sidemenuImage: "user-check-icon 1"))
                self.benefitsItem.append(SecondMenuList(sideMenuItem: "Program Benefits", sideMenuID: 22, sidemenuImage: "redeem"))
            }
            self.sideMenuItems.append(SideMenuModel(parentName: "Profile", parentList:  [], parentID: 1, parentExpand: false, parentImage: "user-check-icon 1"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Claim Points", parentList:  [], parentID: 2, parentExpand: false, parentImage: "redeem"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Claim Status", parentList:  [], parentID: 3, parentExpand: false, parentImage: "Group 6400"))
            self.sideMenuItems.append(SideMenuModel(parentName: "My Earnings", parentList:  [], parentID: 4, parentExpand: false, parentImage: "added-value-icon"))
            self.sideMenuItems.append(SideMenuModel(parentName: "My Redemptions", parentList:  [], parentID: 5, parentExpand: false, parentImage: "reademailalt"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Points Statement", parentList:  [], parentID: 6, parentExpand: false, parentImage: "confirmation-number"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Wishlist", parentList: [], parentID: 7, parentExpand: false, parentImage: "heart-plus-icon"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Dream Gift", parentList:  [], parentID: 8, parentExpand: false, parentImage: "gift-wrap-icon"))
            self.sideMenuItems.append(SideMenuModel(parentName: "My Promotions", parentList: [], parentID: 9, parentExpand: false, parentImage: "thumbs-up-solid"))
            self.sideMenuItems.append(SideMenuModel(parentName: "My Summary", parentList: [], parentID: 10, parentExpand: false, parentImage: "__TEMP__SVG__"))
//            self.sideMenuItems.append(SideMenuModel(parentName: "Pan Details", parentList: [], parentID: 11, parentExpand: false, parentImage: "credit-card"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Lodge Query", parentList: [], parentID: 11, parentExpand: false, parentImage: "how-to-icon"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Helpline", parentList: [], parentID: 12, parentExpand: false, parentImage: "female-services-support-icon"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Change Password", parentList: [], parentID: 13, parentExpand: false, parentImage: "key"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Benefits", parentList: self.benefitsItem, parentID: 14, parentExpand: false, parentImage: "vm-solid", parentDropDownImage: "dropDownImg"))
            
            self.sideMenuItems.append(SideMenuModel(parentName: "FAQs", parentList: [], parentID: 15, parentExpand: false, parentImage: "faq-icon"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Terms and Conditions", parentList: [], parentID: 16, parentExpand: false, parentImage: "text-file-black-icon"))
            self.sideMenuItems.append(SideMenuModel(parentName: "Delete Account", parentList: [], parentID: 17, parentExpand: false, parentImage: "md-log-out"))
            self.sidemenuTableView.reloadData()
           // self.loaderView.isHidden = false
            self.stopLoading()
        }
        
            
        }
    
    
    //Api:-
    
    func dashboardAPI() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
          self.startLoading()
//                self.loaderView.isHidden = false
//                self.playAnimation()
        })
        let parameters = [
            "ActorId":"\(userID)"
        ]
        print(parameters,"Dash")
        self.vm.dashboardAPICall(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.customerNameLbl.text = response?.lstCustomerFeedBackJsonApi?[0].firstName ?? "-"
                let customerImage = String(response?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "").dropFirst(1)
                
                let imageData = customerImage.split(separator: "~")
                if imageData.count >= 2 {
                    print(imageData[1],"jdsnjkdn")
                    let totalImgURL = PROMO_IMG1 + (imageData[1])
                    print(totalImgURL, "Total Image URL")
                    self.userImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "icons8-life-cycle-96"))
                }else{
                    let totalImgURL = PROMO_IMG1 + customerImage
                    print(totalImgURL, "Total Image URL")
                    self.userImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "icons8-life-cycle-96"))
                }
                
                
              //  self.userGradeLbl.text = response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "-"
//                if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Bronze" {
//                    self.userGradeImage.image = UIImage(named: "grade1")
//                } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Gold" {
//                    self.userGradeImage.image = UIImage(named: "grade2")
//                } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Silver" {
//                    self.userGradeImage.image = UIImage(named: "grade3")
//                } else {
//                    self.userGradeImage.image = UIImage(named: "grade3")
//                }
                self.customerIDLbl.text = response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                self.totalPointsLbl.text = "Total Points \(response?.objCustomerDashboardList?[0].totalRedeemed ?? 0)"
                self.loaderView.isHidden = true
                self.stopLoading()
            }
        }
    }
}

extension MSP_SideMenuViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sideMenuItems[section].parentExpand == true{
            return sideMenuItems[section].parentList!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell
        cell?.selectionStyle = .none
        
        if sideMenuItems[indexPath.section].parentExpand == true {
            if sideMenuItems[indexPath.section].parentList!.count != 0{
                cell?.sideMenuDataLbl.text = sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuItem ?? ""
               
                cell?.sideMenuImage.image = UIImage(named: sideMenuItems[indexPath.section].parentList![indexPath.row].sidemenuImage ?? "")
                cell?.leadingConstrain.constant = 30
                
            }
           
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.customerTypeId,"kjshdkhd")
        if self.customerTypeId as! Int == 51{
            if sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuID == 22{
                self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ProgromBenefits") as? MSP_ProgromBenefits
                vc!.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }else{
            if sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuID == 21{
                self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_TierBenefitsVC") as? MSP_TierBenefitsVC
                vc!.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            if sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuID == 22{
                self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ProgromBenefits") as? MSP_ProgromBenefits
                vc!.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor.clear
        let label = UILabel()
        label.frame = CGRect.init(x: 42, y: 0, width: headerView.frame.width, height: headerView.frame.height-1)
        label.textColor = UIColor.white
        label.font = label.font.withSize(14)
        
        let labelimage = UIImageView()
        labelimage.frame = CGRect.init(x: 10, y: 5, width: 25, height: 25)
        let button = UIButton()
        button.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        button.backgroundColor = UIColor.clear
        label.text = sideMenuItems[section].parentName ?? ""
        let label1 = UILabel()
        label1.frame = CGRect.init(x: 8, y: headerView.frame.height - 1, width: headerView.frame.width - 16, height: 1)
        //        label1.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1)
        label1.backgroundColor = UIColor.white
        headerView.addSubview(label1)
        headerView.addSubview(label)
        labelimage.image = UIImage(named: sideMenuItems[section].parentImage ?? "Mask Group 17")
        headerView.addSubview(labelimage)
        headerView.addSubview(button)
        
        button.tag = sideMenuItems[section].parentID ?? -1
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        return headerView
    }
    
    @objc func buttonTapped(sender:UIButton){
        if sender.tag == 1{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyProfileVC") as! MSP_MyProfileVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
            

        }else if sender.tag == 2{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ClaimPointsVC") as! MSP_ClaimPointsVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 3{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_ClaimStatusVC") as! MSP_ClaimStatusVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 4{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyEarningsVC") as! MSP_MyEarningsVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 5{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyRedemptionVC") as! MSP_MyRedemptionVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 6{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_PointStatementVC") as! MSP_PointStatementVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 7{
            if vm1.myPlannerListArray.count > 0 {
                self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if sender.tag == 8{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyDreamGiftVC") as! MSP_MyDreamGiftVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 9{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_OffersandPromotionsVC") as! MSP_OffersandPromotionsVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 10{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MySummaryVC") as! MSP_MySummaryVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 11{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_LodgeQueryVC") as! MSP_LodgeQueryVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 12{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_Support") as! MSP_Support
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 13{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JSW_ChangePasswordVC") as! JSW_ChangePasswordVC
          //  vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 14{
        
            if let index = sideMenuItems.firstIndex{$0.parentID == sender.tag}{
                if sideMenuItems[index].parentExpand == false{
                    sideMenuItems[index].parentExpand = true
                    print("hide")
                    
                    
                    self.sidemenuTableView.reloadData()
                }else{
                    sideMenuItems[index].parentExpand = false
                    print("Expanded")
                    self.sidemenuTableView.reloadData()
                }
              
            }
        }else if sender.tag == 15{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_FAQ") as! MSP_FAQ
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 16{
            self.closeLeft()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TermsAndConditionsVC") as! TermsAndConditionsVC
            vc.fromSideMenu = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
           
        }else{
            self.closeLeft()
            let alert = UIAlertController(title: "", message: "Are you sure? want to delete this account", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
                self.deleteAccountAPI()
        }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
            

        }

        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func deleteAccountAPI(){
        DispatchQueue.main.async {
          self.startLoading()
//                self.loaderView.isHidden = false
//                self.playAnimation()
        }

        self.parameters = [
            "ActionType": 1,
            "userid":"\(self.userID)"
        ] as [String : Any]
        print(self.parameters!)
            self.vm.deleteAccount(parameters: self.parameters!) { response in
                DispatchQueue.main.async {
                    print(response?.returnMessage ?? "-1")
                    if response?.returnMessage ?? "-1" == "1"{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.itsComeFrom = "AccounthasbeenDeleted"
                            vc!.descriptionInfo = "Account has been deleted successfully"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                            }
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.itsComeFrom = "AccounthasbeenDeleted"
                            vc!.descriptionInfo = "Something went wrong please try again later!"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                            }
                    }
                   self.loaderView.isHidden = false
                  self.stopLoading()
                    }
            }
    }
    
}

extension MSP_SideMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openGallery() {
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            if newStatus ==  PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = .savedPhotosAlbum
                    self.picker.mediaTypes = ["public.image"]
                    self.present(self.picker, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)

                }
            }
        })
    }

    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {

                                self.picker.allowsEditing = false
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "NeedCameraAccess", message: "Allow", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                            }
                            alertVC.addAction(okAction)
                            alertVC.addAction(cancelAction)
                            self.present(alertVC, animated: true, completion: nil)

                        }
                    }
                }} else {
                    DispatchQueue.main.async {
                        self.noCamera()
                    }
                }
        }

    }


    func opencamera() {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker,animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "MSPneedtoaccesscameraGallery", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "Disallow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorrnodevice", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        DispatchQueue.main.async {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
//            let imageData = selectedImage.resized(withPercentage: 0.1)
//            let imageData1: NSData = imageData!.pngData()! as NSData
//            self.userImage.image = selectedImage
//            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
//            self.vm.imageSubmissionAPI(base64: self.strdata1)
//            picker.dismiss(animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                print(image)
                
                let imageData = image.resized(withPercentage: 0.1)
                let imageData1: NSData = imageData!.pngData()! as NSData
                self.userImage.image = image
                //self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
                let cropper = CropperViewController(originalImage: image)
                print(self.strdata1,"Image")
                cropper.delegate = self
                
                picker.dismiss(animated: true) {
                self.present(cropper, animated: true, completion: nil)
                  
                }
              
        }
            
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func clearTable(){
        
        let context = persistanceservice.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ClaimPointsArray")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
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
                     animationView11!.animationSpeed = 0.4
                    loaderAnimatedView.addSubview(animationView11!)
                     // 6. Play animation
                     animationView11!.play()

               }

}

extension MSP_SideMenuViewController: CropperViewControllerDelegate {

    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
    cropper.dismiss(animated: true, completion: nil)
 
    if let state = state,
        let image = cropper.originalImage.cropped(withCropperState: state) {
        print(image,"imageDD")
        let imageData = image.resized(withPercentage: 0.1)
        let imageData1: NSData = imageData!.pngData()! as NSData
        self.userImage.image = image
        self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        print(strdata1,"kdjgjhdsj")
        self.userImage.image = image
        self.vm.imageSubmissionAPI(base64: self.strdata1)
    } else {
        print("Something went wrong")
    }
    self.dismiss(animated: true, completion: nil)
    }
}
