//
//  MSP_ForgotPasswordVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 28/11/22.
//

import UIKit
import Firebase
import Lottie
class MSP_ForgotPasswordVC: BaseViewController, popUpDelegate, UITextFieldDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
        if self.isSuccess == 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBOutlet var forgotPassView: UIView!
    @IBOutlet var forgotPasswordTF: UITextField!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    var vm = ForgotPasswordViewModel()
    var isSuccess = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.loaderView.isHidden = true
        forgotPasswordTF.delegate = self
        self.forgotPasswordTF.keyboardType = .numberPad
        forgotPassView.layer.cornerRadius = 16
        forgotPassView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.forgotPassView.clipsToBounds = true
     //   self.infoLbl.text = "Enter your registered mobile number"
        self.forgotPasswordTF.placeholder = "Enter Mobile number"
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendToLogin), name: Notification.Name.sendToLogin, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        DispatchQueue.main.async{
            self.loaderView.isHidden = true
        }
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Forgot Password")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    @objc func sendToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        if forgotPasswordTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Mobile number"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if forgotPasswordTF.text?.count != 10 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter valid mobile number"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else {
            let parameters = [
                "UserName":"\(self.forgotPasswordTF.text ?? "")"
            ]
            print(parameters)
            self.vm.forgotPasswordAPI(paramters: parameters)
            
        }}
                //print(response?.forgotPasswordMobileAppResult,"hjsgjhdg")
                
//                if response?.forgotPasswordMobileAppResult ?? false == true {
//                    DispatchQueue.main.async{
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//                        self.isSuccess = 1
//                        vc!.descriptionInfo = "New password sent to the registered mobile number!"
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.present(vc!, animated: true, completion: nil)
//                    }
//                } else {
//                    self.forgotPasswordTF.text = ""
//                    DispatchQueue.main.async{
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//                        self.isSuccess = 0
//                        vc!.descriptionInfo = "Please enter registered number"
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.present(vc!, animated: true, completion: nil)
//                    }

//            }
//        }
//    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func membershipIdDidEnd(_ sender: Any) {
        let parameters = [
            "ActionType":"58",
            "Location":["UserName":"\(forgotPasswordTF.text ?? "")"]
        ] as [String : Any]
        print(parameters)
        self.vm.membershipIDVerification(parameters: parameters) { response in
            if response?.CheckCustomerExistancyAndVerificationJsonResult ?? -1 != 1 {
                DispatchQueue.main.async{
                    self.loaderView.isHidden = true
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    self.isSuccess = 0
                    vc!.descriptionInfo = "MembershipID doesn't exists"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.forgotPasswordTF.text = ""
                }
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        if string == numberFiltered {
            let currentText = forgotPasswordTF.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 10
        } else {
            return false
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
