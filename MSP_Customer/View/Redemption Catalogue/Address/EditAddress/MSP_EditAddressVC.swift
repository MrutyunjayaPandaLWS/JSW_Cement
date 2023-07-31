//
//  MSP_EditAddressVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 21/11/2022.
//

import UIKit
import Firebase
import Lottie

protocol SendUpdatedAddressDelegate: NSObject {
    func updatedAddressDetails(_ vc: MSP_EditAddressVC)
}


class MSP_EditAddressVC: BaseViewController, UITextFieldDelegate, DropDownDelegate, popUpDelegate {
    func redemptionStatusDidTap(_ vc: MSP_DropDownVC) {}
    func statusDipTap(_ vc: MSP_DropDownVC) {}
    

    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func stateDidTap(_ vc: MSP_DropDownVC) {
        self.selectedStateIdProtocol = vc.selectedStateID
        self.selectedStateID = vc.selectedStateID
        self.stateButton.setTitle(vc.selectedState, for: .normal)
        self.selectedState = vc.selectedState
        self.selectedCityID = 0
        self.selectedCityIdProtocol = 0
        self.cityButton.setTitle("Select District", for: .normal)
    }
    
    func cityDidTap(_ vc: MSP_DropDownVC) {
        //self.cityLbl.text = vc.selectedCity
        self.selectedCityIdProtocol = vc.selectedCityID
        self.selectedCityID = vc.selectedCityID
        self.cityButton.setTitle(vc.selectedCity, for: .normal)
        self.selectedCity = vc.selectedCity
    }
    
    func preferredLanguageDidTap(_ vc: MSP_DropDownVC) {
    }
    
    func genderDidTap(_ vc: MSP_DropDownVC) {
    }
    
    func titleDidTap(_ vc: MSP_DropDownVC) {}
    
    func dealerDipTap(_ vc: MSP_DropDownVC) {}
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var mobileTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var countryTF: UITextField!
    @IBOutlet var stateButton: UIButton!
    @IBOutlet var cityButton: UIButton!
    @IBOutlet var zipCodeTF: UITextField!
    @IBOutlet weak var notificationCountLbl: UILabel!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var saveChanges: GradientButton!
    weak var delegate: SendUpdatedAddressDelegate?
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    var selectedStateIdProtocol = -1
    var selectedCityIdProtocol = -1
    
    var selectedname = ""
    var selectedemail = ""
    var selectedmobile = ""
    var selectedState = ""
    var selectedStateID = 0
    var countryId = 15
    var countryName = ""
    var selectedCity = ""
    var selectedCityID = 0
    var selectedaddress = ""
    var selectedpincode = ""
    var selectedCountryId = 0
    var selectedCountry = ""
    var isComeFrom = 0
    var VM1 = HistoryNotificationsViewModel()
    var VM = EditAddressModels()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zipCodeTF.keyboardType = .numberPad
        self.mobileTF.keyboardType = .numberPad
        self.zipCodeTF.delegate = self
        self.mobileTF.delegate = self
        self.nameTF.text = selectedname
        self.mobileTF.text = selectedmobile
        self.emailTF.text = selectedemail
        self.addressTF.text = selectedaddress
        self.countryTF.text = "India"
        self.countryTF.isEnabled = false
        self.stateButton.setTitle(selectedState, for: .normal)
        self.cityButton.setTitle(selectedCity, for: .normal)
        self.zipCodeTF.text = selectedpincode
        print(self.selectedmobile, "Mobile Number")
        self.loaderView.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
      //  self.myCartListAPI()
       // self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Edit Address")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
  
    
    @IBAction func selectStateBTN(_ sender: Any) {
        if self.selectedCountryId == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Country"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                        vc!.descriptionInfo = "No Internet"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
                vc!.delegate = self
                vc!.isComeFrom = 1
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
//
    }
    @IBAction func selectCityBTN(_ sender: Any) {
        print(self.selectedStateID,"ID")
        if self.selectedStateID == 0 || self.selectedCountryId == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                    vc!.descriptionInfo = "Select State"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                        vc!.descriptionInfo = "No Internet"
                    
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
                vc!.delegate = self
                vc!.isComeFrom = 2
                vc!.stateIDfromPreviousScreen = selectedStateID
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func switchToCartBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyCartVC") as! MSP_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func switchToFavBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func switchToNotificaiton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func saveChangesButton(_ sender: Any) {
        
        if nameTF.text?.count == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Name"
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

        }else if mobileTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Mobile Number"
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

        }else if mobileTF.text?.count != 10 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Valid Mobile Number"
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

        }
//        else if emailTF.text?.count == 0{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter EmailID"
//                vc!.modalPresentationStyle = .overFullScreen
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//
//        }
//        else  if !isValidEmail(emailTF.text ?? "") {
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter Valid EmailID"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//                }
//            }
       else if addressTF.text?.count == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                    vc!.descriptionInfo = "Enter Address"
                 
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

       }else if stateButton.currentTitle == "Select State" || stateButton.currentTitle == "" || stateButton.currentTitle == nil{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                    vc!.descriptionInfo = "Select State"
                
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

       }else if cityButton.currentTitle == "Select District" || self.cityButton.currentTitle == "" || self.cityButton.currentTitle == nil{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                    vc!.descriptionInfo = "Select District"
                
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

        }else if zipCodeTF.text?.count == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                    vc!.descriptionInfo = "Enter Pin"
                
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

        }else if zipCodeTF.text?.count != 6{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Valid Zip"
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

        }else{
          print(self.addressTF.text ?? "")
            print(self.mobileTF.text ?? "")
            print(self.emailTF.text ?? "")
            print(self.selectedCity)
            print(self.selectedState)
            print(self.zipCodeTF.text ?? "")
            print(self.emailTF.text ?? "")

            self.selectedname = self.nameTF.text ?? ""
            self.selectedmobile = self.mobileTF.text ?? ""
            self.selectedemail = self.emailTF.text ?? ""
            self.selectedpincode = self.zipCodeTF.text ?? ""
            self.selectedaddress = self.addressTF.text ?? ""
           self.delegate?.updatedAddressDetails(self)
            self.navigationController?.popViewController(animated: true)
        }
    }
 

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //API:-
    func notificationListApi(){
        let parameters = [
            "ActionType": 0,
            "ActorId": "\(userID)",
            "LoyaltyId": self.loyaltyID
        ] as [String: Any]
        print(parameters)
        self.VM1.notificationListApi(parameters: parameters) { response in
            self.VM1.notificationListArray = response?.lstPushHistoryJson ?? []
            print(self.VM1.notificationListArray.count)
            if self.VM1.notificationListArray.count > 0{
                self.notificationCountLbl.isHidden = false
                self.notificationCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notificationCountLbl.isHidden = true
            }
        }
    }
    
    
    func myCartListAPI(){
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyID)"
        ] as [String: Any]
        print(parameters)
        self.VM.myCartList(parameters: parameters) { response in
            self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
            print(self.VM.myCartListArray.count)
            if self.VM.myCartListArray.count > 0 {
                self.cartCountLbl.isHidden = false
                self.cartCountLbl.text = "\(self.VM.myCartListArray.count)"
            }else{
                self.cartCountLbl.isHidden = true
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
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let maxLength = 10
//        let otpLength = 6
//        if textField == mobileTF{
//            let currentString: NSString = (mobileTF.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }else if textField == zipCodeTF{
//            let currentString: NSString = (zipCodeTF.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= otpLength
//        }
//        return true
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      if string == numberFiltered {
          if textField == mobileTF{
              let currentText = mobileTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == zipCodeTF {
              let currentText = zipCodeTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 6
          }
      
      } else {
        return false
      }
        return false
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[6-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    //Delegate:-
    
//    func didSelectedItem(_ vc: DropDownVC) {
//        print(vc.selectedTitle)
//        print(vc.selectedId)
//        if vc.isComeFrom == 1{
//            self.stateButton.setTitle(vc.selectedTitle, for: .normal)
//            self.selectedState = vc.selectedTitle
//            self.selectedStateID = Int(vc.selectedId) ?? 0
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                self.cityButton.setTitle("Select City", for: .normal)
//             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                 self.cityButton.setTitle("शहर चुनें", for: .normal)
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                self.cityButton.setTitle("শহর নির্বাচন করুন", for: .normal)
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                self.cityButton.setTitle("సిటీని ఎంచుకోండి", for: .normal)
//              }
//
//        }else if vc.isComeFrom == 2{
//            self.cityButton.setTitle(vc.selectedTitle, for: .normal)
//            self.selectedCity = vc.selectedTitle
//            self.selectedCityID = Int(vc.selectedId) ?? 0
//        }
//    }
//
//    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
}

