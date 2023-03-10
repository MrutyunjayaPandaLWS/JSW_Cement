//
//  PopupAlertOne_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 12/03/21.
//

import UIKit

protocol popUpDelegate : AnyObject {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC)
}
class PopupAlertOne_VC: BaseViewController {
    
    
    @IBOutlet var ok: GradientButton!
    @IBOutlet var descriptionn: UILabel!
    var titleInfo = ""
    var descriptionInfo = ""
    weak var delegate:popUpDelegate?
    var itsComeFrom = ""
    var itsFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionn.text = descriptionInfo
        self.ok.setTitle("OK", for: .normal)
    }
    
    @IBAction func OK(_ sender: Any) {
        print(itsComeFrom)
        if self.itsComeFrom == "Registration"{
            self.dismiss(animated: true){
                self.delegate?.popupAlertDidTap(self)
                print(self.itsFrom, "slkdajflsdajfljkasdfljsdaljflsd")
                if self.itsFrom == "Welcome"{
                    NotificationCenter.default.post(name: .navigateToLogin, object: self)
                }else{
                    NotificationCenter.default.post(name: .navigateToLogin1, object: self)
                }
             
                
            }
        }else if itsComeFrom == "AccounthasbeenDeleted"{
                self.dismiss(animated: true){
                    self.delegate?.popupAlertDidTap(self)
                    NotificationCenter.default.post(name: .deleteAccount, object: nil)
                }
        }else if itsComeFrom == "ClaimPointsSubmission"{
            self.dismiss(animated: true){
                self.delegate?.popupAlertDidTap(self)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }else if itsComeFrom == "QuerySubmission"{
            self.dismiss(animated: true){
                self.delegate?.popupAlertDidTap(self)
                NotificationCenter.default.post(name: .querySubmission, object: nil)
            }
        }else if itsComeFrom == "RemoveDream"{
            self.dismiss(animated: true){
                self.delegate?.popupAlertDidTap(self)
                NotificationCenter.default.post(name: .removeDreamGiftDetails, object: nil)
            }
        }else if itsComeFrom == "LoginPage"{
            self.dismiss(animated: true){
                self.delegate?.popupAlertDidTap(self)
                NotificationCenter.default.post(name: .sendToLogin, object: nil)
            }
        }else if itsComeFrom == "ChangePassword"{
            self.dismiss(animated: true){
                self.delegate?.popupAlertDidTap(self)
                NotificationCenter.default.post(name: .goToDashBoard, object: nil)
            }
        }
        
        //        if itsComeFrom == "DreamGift"{
        //            print("Called")
        //
        //            self.dismiss(animated: true){
        //                NotificationCenter.default.post(name: .dreamGiftRemoved, object: nil)
        //            }
        //        }else if itsComeFrom == "Scanner"{
        //            self.dismiss(animated: true){
        //                NotificationCenter.default.post(name: .restartScan, object: nil)
        //            }
        //
        //        }else if itsComeFrom == "AddToCart"{
        //            self.dismiss(animated: true){
        //                NotificationCenter.default.post(name: .giftAddedIntoCart, object: nil)
        //            }
        //        }else if itsComeFrom == "enteredCount"{
        //            self.dismiss(animated: true){
        //                NotificationCenter.default.post(name: .checkProductsCount, object: nil)
        //            }
                else if itsComeFrom == "AccountVerification"{
                  
                        delegate?.popupAlertDidTap(self)
                        self.dismiss(animated: true, completion: nil)
                }
                //else if itsComeFrom == "DreamGiftDetails"{
        //            self.dismiss(animated: true){
        //                NotificationCenter.default.post(name: .removeDreamGiftDetails, object: nil)
        //
        //            }
        //        }else if itsComeFrom == "DownloadEWarranty"{
        //            self.dismiss(animated: true){
        //
        //                NotificationCenter.default.post(name: .downloadEwarrantyList, object: nil)
        //                self.navigationController?.popViewController(animated: true)
        //            }
        //
        //        }else if itsComeFrom == "AccountDeleted"{
        //            self.dismiss(animated: true){
        //                NotificationCenter.default.post(name: .removeDreamGiftDetails, object: nil)
        //
        //            }
        //        }
        else if itsComeFrom == "DeactivateAccount"{
                    self.dismiss(animated: true){
                        NotificationCenter.default.post(name: .deactivatedAcc, object: nil)
                        self.delegate?.popupAlertDidTap(self)
        
                    }
                } else if itsComeFrom == "MyProfileImage"{
                    self.dismiss(animated: true){
                        self.delegate?.popupAlertDidTap(self)
        
                    }
                }
        else{
            delegate?.popupAlertDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }
        //
        //    deinit{
        //        print("All memory has been deallocated by system")
        //    }
        
    }
}
