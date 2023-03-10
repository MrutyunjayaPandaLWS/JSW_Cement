//
//  RegisterVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 28/11/22.
//

//import UIKit
//import DPOTPView
//import Firebase
//import Lottie
//class MSP_RegisterVC: BaseViewController, popUpDelegate,UITextFieldDelegate{
//    
//    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
//    
//    @IBOutlet weak var txtDPOTPView: DPOTPView!
//    @IBOutlet var registerView: UIView!
//    @IBOutlet var membershipTF: UITextField!
//    
//    @IBOutlet var countLbl: UILabel!
//    @IBOutlet var resendBTNView: GradientView!
//    @IBOutlet var otpViewConstrain: NSLayoutConstraint!
//    
//    @IBOutlet var sendOTPButtonContrain: NSLayoutConstraint!
//    @IBOutlet var timerLbl: UILabel!
//
//    @IBOutlet weak var sentOtpLbl: UILabel!
//    @IBOutlet weak var submitBtnView: GradientView!
//    @IBOutlet weak var sendOTPBtn: UIButton!
//    @IBOutlet weak var loaderAnimatedView: AnimationView!
//       @IBOutlet weak var loaderView: UIView!
//    private var animationView11: AnimationView?
//    
//    var token = UserDefaults.standard.string(forKey: "TOKEN") ?? ""
//    var VM = RegistrationVM()
//    var txtOTPView: DPOTPView!
//    var enteredValue = ""
//    var enteredMobileNumber = ""
//    var itsFrom = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.VM.VC = self
//        self.loaderView.isHidden = true
//        countLbl.isHidden = true
//        resendBTNView.isHidden = true
//        timerLbl.isHidden = true
//        sendOTPButtonContrain.constant = 20
//        txtDPOTPView.isHidden = true
//        membershipTF.delegate = self
//        self.sentOtpLbl.text = "Send OTP"
//        registerView.layer.cornerRadius = 8
//        registerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        self.registerView.clipsToBounds = true
//        txtDPOTPView.dpOTPViewDelegate = self
//        txtDPOTPView.fontTextField = UIFont.systemFont(ofSize: 25)
//        txtDPOTPView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
//        txtDPOTPView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//      
//      
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.loaderView.isHidden = true
//        countLbl.isHidden = true
//        resendBTNView.isHidden = true
//        timerLbl.isHidden = true
//        sendOTPButtonContrain.constant = 20
//        txtDPOTPView.isHidden = true
//        self.membershipTF.text = ""
//        self.enteredValue = ""
//        self.sentOtpLbl.text = "Send OTP"
//        self.membershipTF.isEnabled = true
//        if self.membershipTF.text!.count != 10{
//            self.txtDPOTPView.text = ""
//        }
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Registration")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
//      
//    }
//    
//    @IBAction func sendOtpBtn(_ sender: Any) {
//        if self.sentOtpLbl.text == "Send OTP"{
//            if self.membershipTF.text!.count == 0{
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "Enter mobile number"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
//            }else if self.membershipTF.text!.count != 10{
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "Enter valid mobile number"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
//            }else if self.membershipTF.text!.count > 10{
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "Enter valid mobile number"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
//            }else if !isValidPhone(testStr: membershipTF.text ?? ""){
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "Enter valid mobile number"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
//            }else{
//                    let parameterJSON = [
//                        "ActionType":"57",
//                        "Location":[
//                            "UserName":"\(self.membershipTF.text ?? "")"
//                        ]
//                    ] as [String:Any]
//                    print(parameterJSON)
//                    self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
//            }
//        }else{
//            if self.enteredValue == ""{
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "Please enter the OTP"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
//            }else if self.enteredValue.count != 6 {
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "Please enter the valid OTP"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
//            }else{
////                self.VM.OTPforVerification = "123456"
//                if self.VM.OTPforVerification == self.enteredValue{
//
//                    self.VM.timer?.invalidate()
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_GeneralInformationVC") as? MSP_GeneralInformationVC
//                    vc!.enteredMobileNumber = self.membershipTF.text ?? ""
//                    vc!.itsFrom = self.itsFrom
//                    self.navigationController?.pushViewController(vc!, animated: true)
//                }else{
//                    DispatchQueue.main.async{
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//                        vc!.descriptionInfo = "Please enter the valid OTP"
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.present(vc!, animated: true, completion: nil)
//                    }
//                }
//               
//            }
//        }
//    }
//    @IBAction func mobileNumberEditingChaned(_ sender: Any) {
//        if self.membershipTF.text!.count == 0{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        }else if self.membershipTF.text!.count != 10{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter valid mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        }else{
//            let parameterJSON = [
//                    "ActionType":"57",
//                    "Location":[
//                        "UserName":"\(self.membershipTF.text ?? "")"
//                    ]
//            ] as [String:Any]
//            print(parameterJSON)
//            self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
//        }
//    }
//    
//    @IBAction func loginBtn(_ sender: Any) {
//        self.VM.timer?.invalidate()
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_LoginVC") as! MSP_LoginVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    @IBAction func resendOtpBtn(_ sender: Any) {
//        if self.membershipTF.text!.count == 0{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        }else if self.membershipTF.text!.count != 10{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Enter valid mobile number"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        }else{
//            self.VM.timer?.invalidate()
//            self.VM.resendOTP()
//        }
//    }
//    func isValidPhone(testStr:String) -> Bool {
//        let phoneRegEx = "^[6-9]\\d{9}$"
//        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
//        return phoneNumber.evaluate(with: testStr)
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
//      let compSepByCharInSet = string.components(separatedBy: aSet)
//      let numberFiltered = compSepByCharInSet.joined(separator: "")
//
//      if string == numberFiltered {
//          let currentText = self.membershipTF.text ?? "" 
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//        return updatedText.count <= 10
//      } else {
//        return false
//      }
//    }
//    func playAnimation(){
//                   animationView11 = .init(name: "Loader_v4")
//                     animationView11!.frame = loaderAnimatedView.bounds
//                     // 3. Set animation content mode
//                     animationView11!.contentMode = .scaleAspectFit
//                     // 4. Set animation loop mode
//                     animationView11!.loopMode = .loop
//                     // 5. Adjust animation speed
//                     animationView11!.animationSpeed = 0.5
//                    loaderAnimatedView.addSubview(animationView11!)
//                     // 6. Play animation
//                     animationView11!.play()
//
//               }
//
//    
//}
//extension MSP_RegisterVC : DPOTPViewDelegate {
//    func dpOTPViewAddText(_ text: String, at position: Int) {
//        print("addText:- " + text + " at:- \(position)" )
//        self.enteredValue = "\(text)"
//    }
//    
//    func dpOTPViewRemoveText(_ text: String, at position: Int) {
//        print("removeText:- " + text + " at:- \(position)" )
//    }
//    
//    func dpOTPViewChangePositionAt(_ position: Int) {
//        print("at:-\(position)")
//    }
//    func dpOTPViewBecomeFirstResponder() {
//        
//    }
//    func dpOTPViewResignFirstResponder() {
//        
//    }
//}
