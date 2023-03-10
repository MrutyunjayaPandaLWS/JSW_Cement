//
//  JSW_ChangePasswordVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 09/03/2023.
//

import UIKit
import Toast_Swift
protocol SendNewPasswordDelegate: class{
    
    func sendNewPassword(_ vc: JSW_ChangePasswordVC)
}
class JSW_ChangePasswordVC: BaseViewController {

    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var oldPasswordTF: UITextField!
    
    var delegate: SendNewPasswordDelegate!
    var newPassword = ""
    var mobileNumber = ""
    
    var VM = JSW_ChangePasswordVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
    }


    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitButton(_ sender: Any) {
        if self.newPasswordTF.text?.count == 0{
            self.view.makeToast("Enter new password", duration: 2.0, position: .bottom)
        }else if self.confirmPasswordTF.text?.count == 0{
            self.view.makeToast("Enter confirm password", duration: 2.0, position: .bottom)
        }else if self.newPasswordTF.text ?? "" != self.confirmPasswordTF.text ?? ""{
            self.view.makeToast("Both new and confirm password should be same", duration: 2.0, position: .bottom)
        }else{
//            self.newPassword = self.confirmPasswordTF.text ?? ""
//            self.delegate.sendNewPassword(self)
//            self.dismiss(animated: true)
            self.passwordUpdateApi(newPassword: self.newPasswordTF.text ?? "", mobilenumber: self.mobileNumber)
        }
        
     
    }
    func passwordUpdateApi(newPassword: String, mobilenumber: String){
        let parameter = [
            "Password": newPassword,
            "UserName":mobilenumber,
            "UserActionType":"UpdateChangedPassword"
        ] as [String:Any]
        print(parameter)
        self.VM.forgetPasswordSubmissionApi(parameter: parameter)
    }
}
