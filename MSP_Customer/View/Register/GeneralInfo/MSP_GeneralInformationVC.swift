//
//  MSP_GeneralInformationVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 28/11/22.
//

import UIKit
import Firebase
import Lottie
import Photos
import QCropper
class MSP_GeneralInformationVC: BaseViewController, DropDownDelegate, DateSelectedDelegate, popUpDelegate, UITextFieldDelegate{
    func statusDipTap(_ vc: MSP_DropDownVC) {}
    func redemptionStatusDidTap(_ vc: MSP_DropDownVC) {}
    func dealerDipTap(_ vc: MSP_DropDownVC) {}
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func titleDidTap(_ vc: MSP_DropDownVC) {
        self.titleNameLbl.text = vc.selectedTitle
    }
    
    func acceptDate(_ vc: MSP_DOBVC) {
        self.dobLbl.text = vc.selectedDate
    }
    
    func declineDate(_ vc: MSP_DOBVC) {}
    
    func genderDidTap(_ vc: MSP_DropDownVC) {
        self.genderLbl.text = vc.selectedGender
    }
    
    func stateDidTap(_ vc: MSP_DropDownVC) {
        self.selectedStateId = vc.selectedStateID
        self.stateLbl.text = vc.selectedState
        self.cityLbl.text = "Select"
        self.selectedCityId = -1
    }
    
    func cityDidTap(_ vc: MSP_DropDownVC) {
        self.cityLbl.text = vc.selectedCity
        self.selectedCityId = vc.selectedCityID
    }
    
    func preferredLanguageDidTap(_ vc: MSP_DropDownVC) {
        self.preferredLanguageLbl.text = vc.selectedLanguage
        self.selectedLanguageId = vc.selectedPreferredID
    }
    
    
    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet var titleOutBtn: UIButton!
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var mobileNumberTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var alterMobileTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var pinCodeTF: UITextField!
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var preferredLanguageLbl: UILabel!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileClickOutBtn: UIButton!
    
    var VM = GeneralInfoVM()
    var selectedStateId = -1
    var selectedCityId = -1
    var selectedLanguageId = -1
    var enteredMobileNumber = ""
    var genderArray:[String] = ["Male", "Female", "Don't want to show"]
    var titleArray:[String] = ["Mr.", "Ms.", "Mrs.", "Miss."]
    var itsFrom = ""
    var itsComeFrom = ""
    
    let picker = UIImagePickerController()
    var strBase64 = ""
    var fileType = ""
    var strdata1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.picker.delegate = self
        print(profileImage,"lskdl")
        self.loaderView.isHidden = true
        self.mobileNumberTF.delegate = self
        self.alterMobileTF.delegate = self
        self.pinCodeTF.delegate = self
        self.mobileNumberTF.keyboardType = .asciiCapableNumberPad
        self.alterMobileTF.keyboardType = .asciiCapableNumberPad
        self.pinCodeTF.keyboardType = .asciiCapableNumberPad
        self.mobileNumberTF.text = self.enteredMobileNumber
        self.mobileNumberTF.isEnabled = false
   
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToLoginVC), name: Notification.Name.navigateToLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToLoginVC1), name: Notification.Name.navigateToLogin1, object: nil)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loaderView.isHidden = true
        print(self.itsFrom, "sldkafjkasdkjlflasdkjfsda")
        self.itsComeFrom = ""
        self.itsComeFrom = self.itsFrom
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "General Info")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
      
    }
    override func viewWillLayoutSubviews() {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.layer.borderWidth = 3.0
        self.profileImage.clipsToBounds = true
        
        }
    
    @objc func navigateToLoginVC1(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MSP_LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    @objc func navigateToLoginVC(){

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_LoginVC") as! MSP_LoginVC
            vc.itsFrom = ""
            self.navigationController?.pushViewController(vc, animated: true)
        
       
    }
    @IBAction func profileActBtn(_ sender: Any) {
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

    @IBAction func titleActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
        vc!.delegate = self
        vc!.isComeFrom = 5
        vc!.titleArray = self.titleArray
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func stateActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
        vc!.delegate = self
        vc!.isComeFrom = 1
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func cityActBtn(_ sender: Any) {
        if self.selectedStateId == -1{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please select state"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
            vc!.delegate = self
            vc!.isComeFrom = 2
            vc!.stateIDfromPreviousScreen = selectedStateId
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func dobActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "DOB"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func genderActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
        vc!.delegate = self
        vc!.isComeFrom = 4
        vc!.genderArray = genderArray
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func languageActBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DropDownVC") as? MSP_DropDownVC
        vc!.delegate = self
        vc!.isComeFrom = 3
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func submitActBtn(_ sender: Any) {
        let fileteredBySpace = self.lastNameTF.text!
        let trimmed = fileteredBySpace.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed, "FilteredBy1")
        self.lastNameTF.text = "\(trimmed)"
        
        let fileteredBySpace1 = self.firstNameTF.text!
        let trimmed1 = fileteredBySpace1.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed1, "FilteredBy2")
        self.firstNameTF.text = "\(trimmed1)"
        
        let fileteredBySpace2 = self.mobileNumberTF.text!
        let trimmed2 = fileteredBySpace2.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed2, "FilteredBy3")
        self.mobileNumberTF.text = "\(trimmed2)"
        
        let fileteredBySpace3 = self.addressTF.text!
        let trimmed3 = fileteredBySpace3.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed3, "FilteredBy4")
        self.addressTF.text = "\(trimmed3)"
        
        let fileteredBySpace4 = self.pinCodeTF.text!
        let trimmed4 = fileteredBySpace4.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed4, "FilteredBy5")
        self.pinCodeTF.text = "\(trimmed4)"

        
        let fileteredBySpace21 = self.emailTF.text!
        let trimmed21 = fileteredBySpace21.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed21, "FilteredBy1")
        self.emailTF.text = "\(trimmed21)"
        
        let fileteredBySpace22 = self.alterMobileTF.text!
        let trimmed22 = fileteredBySpace22.trimmingCharacters(in: .whitespacesAndNewlines)
        print(trimmed22, "FilteredBy1")
        self.alterMobileTF.text = "\(trimmed22)"
        
        if self.strdata1 == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Profile Image"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.titleNameLbl.text == "Select"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Title"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.firstNameTF.text == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Firstname"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.mobileNumberTF.text == "" {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter mobile number"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.mobileNumberTF.text?.count != 10 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter valid mobile number"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
//        else if !isValidPhone(testStr: mobileNumberTF.text ?? ""){
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        }else if self.alterMobileTF.text == ""{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter alternate mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//
//        }else if !isValidPhone(testStr: alterMobileTF.text ?? ""){
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter valid alternate mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        }else if self.alterMobileTF.text == self.mobileNumberTF.text{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Alternate number shouldn't match mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//                self.alterMobileTF.text = ""
//            }
//
//        }else if self.emailTF.text == ""{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter Email"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//
//        }else if !isValidEmail(emailTF.text ?? "") {
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter valid email id"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//                self.emailTF.text = ""
//            }
//
        //}
    else if self.addressTF.text == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter address"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if self.stateLbl.text == "Select"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select State"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if self.cityLbl.text == "Select"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select City"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if self.pinCodeTF.text == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter pin code"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if self.pinCodeTF.text!.count != 6{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter valid pin code"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
                self.pinCodeTF.text = ""
            }
            
        }else if self.dobLbl.text == "Select"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Date of birth"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if self.genderLbl.text == "Select"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select gender"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if self.preferredLanguageLbl.text == "Select"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Language"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else{
            let parameters = [
                "ActionType": 0,
                "ObjCustomerJson": [
                    "Title": "\(self.titleNameLbl.text ?? "")",
                    "Mobile": "\(self.mobileNumberTF.text ?? "")",
                    "Mobile_Two": "\(self.alterMobileTF.text ?? "")",
                    "CustomerTypeID": 53,
                    "FirstName": "\(self.firstNameTF.text ?? "")",
                    "StateId": self.selectedStateId,
                    "CityId": self.selectedCityId,
                    "CountryId": 15,
                    "Address1": "\(self.addressTF.text ?? "")",
                    "LastName": "\(self.lastNameTF.text ?? "")",
                    "Gender": "\(self.genderLbl.text ?? "")",
                    "DOB": "\(self.dobLbl.text ?? "")",
                    "RegistrationSource": 3,
                    "Zip": "\(self.pinCodeTF.text ?? "")",
                    "Email": "\(self.emailTF.text ?? "")",
                    "DisplayImage" : "\(self.strdata1)"
                ],
                "ObjCustomerDetails": [
                    "LanguageID": self.selectedLanguageId
                ]
            ] as [String: Any]
            print(parameters)
            self.VM.registrationSubmissionApi(paramters: parameters)
        }
    }
    
    
    @IBAction func backBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      if string == numberFiltered {
          if textField == mobileNumberTF{
              let currentText = mobileNumberTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == alterMobileTF{
              let currentText = alterMobileTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == pinCodeTF {
              let currentText = pinCodeTF.text ?? ""
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
}

extension MSP_GeneralInformationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//            self.profileImage.image = selectedImage
//            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
//            print(self.strdata1,"base64Image")
//            //self.vm.imageSubmissionAPI(base64: self.strdata1)
//            picker.dismiss(animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                print(image)
                
                let imageData = image.resized(withPercentage: 0.1)
                let imageData1: NSData = imageData!.pngData()! as NSData
                self.profileImage.image = image
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
}
extension MSP_GeneralInformationVC: CropperViewControllerDelegate {

    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
    cropper.dismiss(animated: true, completion: nil)
 
    if let state = state,
        let image = cropper.originalImage.cropped(withCropperState: state) {
        print(image,"imageDD")
        let imageData = image.resized(withPercentage: 0.1)
        let imageData1: NSData = imageData!.pngData()! as NSData
        self.profileImage.image = image
        self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        print(strdata1,"kdjgjhdsj")
        self.profileImage.image = image
       // self.vm.imageSubmissionAPI(base64: self.strdata1)
    } else {
        print("Something went wrong")
    }
    self.dismiss(animated: true, completion: nil)
    }
}
