//
//  MSP_MyCartVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 18/11/2022.
//

import UIKit
import Firebase
import Lottie
class MSP_MyCartVC: BaseViewController, popUpDelegate, MyCartDelegate {
    @IBOutlet var myCartTableView: UITableView!
    @IBOutlet var proceedToCheckoutButton: GradientButton!
    @IBOutlet var totalPointsLabel: UILabel!
    @IBOutlet weak var checkoutView: UIView!
    @IBOutlet weak var nodataFound: UILabel!
    @IBOutlet weak var notificationCount: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?

    var VM = MycartViewModel()
    var pointBalance = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var customerCartId = 0
    var quantity = 1
    var productValue = ""
    var finalPoints = 0
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = true
        self.myCartTableView.delegate = self
        self.myCartTableView.dataSource = self
        self.myCartList()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
       // self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Cart")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteBtn(_ sender: Any) {

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func proceedbtn(_ sender: Any) {
        if self.verifiedStatus != 1{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
            vc!.delegate = self
            vc!.titleInfo = ""
            vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
            
        }else if self.verifiedStatus == 1{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DefaultAddressVC") as! MSP_DefaultAddressVC
            vc.totalPoint = self.finalPoints
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    //Delegate:-
 
    func increaseCount(_ cell: MyCart_TVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        if cell.plusBTN.tag == tappedIndexPath.row{
            if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) <= Int(self.pointBalance) ?? 0{
                let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) + Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                print(calcValue, "Calculated Values")
                if calcValue <= Int(self.pointBalance) ?? 0{
                    let totalQTY = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) + 1
                    self.quantity = totalQTY
                    cell.countTF.text = "\(quantity)"
                    self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                    if self.VM.myCartListArray[tappedIndexPath.row].is_Redeemable ?? 0 == 1{
                        self.increaseProduct()
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            
                            vc!.descriptionInfo = "You are not allowed to redeem. Please contact your adminstration"
                           
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }
                    
                }else{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        
                        vc!.descriptionInfo = "Insufficient Point Balance"
                       
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
                
            }
        }
        self.myCartTableView.reloadData()
        
    }
    
    func decreaseCount(_ cell: MyCart_TVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        if self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0 >= 1{
            cell.minusBTN.isEnabled = true
            if cell.minusBTN.tag == tappedIndexPath.row{
                if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) <= Int(self.pointBalance) ?? 0{
                    let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) - Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                    print(calcValue, "reduceValues")
                    if calcValue <= Int(self.pointBalance) ?? 0 {
                        if calcValue != 0  && calcValue >= Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0){
                            let totalQuantity = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) - 1
                            self.quantity = totalQuantity
                            self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                            if self.quantity >= 1 {
                                cell.countTF.text = "\(quantity)"
                                self.increaseProduct()
                            }else{
                                self.quantity = 1
                            }
                           
                        }
                        
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                vc!.descriptionInfo = "Insufficient Point Balance"
                             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                 vc!.descriptionInfo = "अपर्याप्त प्वाइंट बैलेंस"
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                vc!.descriptionInfo = "অপর্যাপ্ত পয়েন্ট ব্যালেন্স"
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                vc!.descriptionInfo = "తగినంత పాయింట్ బ్యాలెన్స్ లేదు"
                              }
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }
                }
                
            }
        }else{
//            if self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0 < 1{
//                cell.minusBTN.isEnabled = false
//                cell.countTF.text = "1"
//            }
          
        }
        
 
            self.myCartTableView.reloadData()
    }
    
    func removeProduct(_ cell: MyCart_TVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        if cell.removeProductBTN.tag == tappedIndexPath.row{
            self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
            self.removeProduct()
            self.myCartTableView.reloadData()
        }
    }
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    
    //Api:-
    
    func myCartList(){
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myCartList(parameters: parameters) { response in
            self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
            print(self.VM.myCartListArray.count)
            if self.VM.myCartListArray.count != 0 {
                DispatchQueue.main.async {
                   
                    self.myCartTableView.isHidden = false
                    self.checkoutView.isHidden = false
                    self.nodataFound.isHidden = true
                    self.myCartTableView.reloadData()
//                    if self.VM.myCartListArray[0].Is_Redeemable ?? -2 == 1{
//                        self.checkoutView.isHidden = false
//
//                    }else{
//                        self.checkoutView.isHidden = true
//
//                    }
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }else{
                
                DispatchQueue.main.async {
                    self.myCartTableView.isHidden = true
                    self.checkoutView.isHidden = true
                    self.nodataFound.isHidden = false
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }
            
        }
    }
    
    func increaseProduct(){
        
        let parameters = [
            
            "ActionType": "3",
            "ActorId": "\(userID)",
            "CustomerCartId": "\(customerCartId)",
            "CustomerCartList": [
                [
                "CustomerCartId": "\(customerCartId)",
                "Quantity": "\(quantity)"
                ]
            ]
            ] as [String: Any]
        print(parameters)
        self.VM.increaseProductApi(parameters: parameters) { response in
            print(response?.returnMessage ?? "0")
            if response?.returnMessage == "1"{
                DispatchQueue.main.async {
                    self.myCartList()
                    self.myCartTableView.reloadData()
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }else{
                DispatchQueue.main.async {
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }
        }
    }
    
    
    func removeProduct(){
        let parameters = [
            "ActionType": "4",
            "ActorId": "\(userID)",
            "CustomerCartId": "\(customerCartId)"
        ] as [String: Any]
        print(parameters)
        self.VM.removeProduct(parameters: parameters) { response in
       
            if response?.returnMessage == "1"{
                DispatchQueue.main.async{
                    self.myCartList()
                    self.myCartTableView.reloadData()
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        
                        vc!.descriptionInfo = "Product has been removed from Cart"
                     
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    self.loaderView.isHidden = true
                        self.stopLoading()
                    }
                    
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                        vc!.descriptionInfo = "Something went wrong!"
                
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.loaderView.isHidden = true
                    self.stopLoading()
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
                self.notificationCount.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notificationCount.isHidden = true
            }
           
        }
    }
    
    func verifyAdhaarExistencyApi(){
        
        let parameter = [
            "ActionType": 154,
            "ActorId": self.userID
        ] as [String: Any]
        print(parameter)
        self.VM.adhaarNumberExistsApi(parameters: parameter) { response in
            
            let result = response?.lstAttributesDetails ?? []
            if result.count != 0 {
                let sortedValues = String(result[0].attributeValue ?? "").split(separator: ":")
                print(self.verifiedStatus)
                print(sortedValues)
                if sortedValues.count != 0 {
                    if sortedValues[0] == "1"{
                        if self.verifiedStatus != 1{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                            
                        }else if self.verifiedStatus == 1{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DefaultAddressVC") as! MSP_DefaultAddressVC
                            vc.totalPoint = self.finalPoints
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            
                            vc!.descriptionInfo = "\(sortedValues[1])"
                            
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                            self.loaderView.isHidden = true
                            self.stopLoading()
                        }
                    }
                }else{
                    self.view.makeToast("Something went wrong! Try again Later ....")
                }

            }
        }
    }
}
extension MSP_MyCartVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myCartListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCart_TVC") as! MyCart_TVC
        cell.delegate = self
        cell.selectionStyle = .none
        cell.catagoryName.text = self.VM.myCartListArray[indexPath.row].categoryName ?? ""
        cell.productName.text = self.VM.myCartListArray[indexPath.row].productName ?? ""
        cell.pointsLabel.text = "\(Double(self.VM.myCartListArray[indexPath.row].pointsRequired ?? 0))"
        let receivedImage = self.VM.myCartListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
        if self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0 != 0 {
            cell.countTF.text = "\(self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0)"
        }else{
            cell.countTF.text = "\(self.quantity)"
        }
        cell.plusBTN.tag = indexPath.row
        cell.minusBTN.tag = indexPath.row
        cell.removeProductBTN.tag = indexPath.row
        print("\(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0)")
        self.totalPointsLabel.text = "\(Double(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0.0))"
        self.finalPoints = Int(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
