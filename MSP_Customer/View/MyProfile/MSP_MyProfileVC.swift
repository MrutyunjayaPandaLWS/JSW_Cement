//
//  MSP_MyProfileVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit
import Firebase
import Photos
import Lottie
import QCropper
class MSP_MyProfileVC: BaseViewController {

    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet weak var memberTypeTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var dateOfBirthTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var pinTF: UITextField!
    @IBOutlet weak var notifiCountLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var profileViewStackView: UIStackView!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    var VM = ProfileViewModel()
    let picker = UIImagePickerController()
    var strdata1 = ""
    var fileType = ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    var fromSideMenu = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.picker.delegate = self
        self.memberTypeTF.isEnabled = false
//        self.firstNameTF.isEnabled = false
//        self.lastNameTF.isEnabled = false
        self.mobileNumberTF.isEnabled = false
        self.emailTF.isEnabled = false
        self.dateOfBirthTF.isEnabled = false
        self.addressTF.isEnabled = false
        self.stateBtn.isEnabled = false
        self.cityBtn.isEnabled = false
        self.pinTF.isEnabled = false
        //self.profileDetails()
        self.profileViewStackView.isHidden = true
        
        self.loaderView.isHidden = false
        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
        //    self.notificationListApi()
            self.profileDetails()
        })
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Profile")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    override func viewWillLayoutSubviews() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.borderWidth = 3.0
        self.profileImageView.clipsToBounds = true
        
        }
   
 
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func  profileDetails(){
        DispatchQueue.main.async {
          self.startLoading()
//                self.loaderView.isHidden = false
//                self.playAnimation()
        }
        let parameters = [
            "ActionType": "6",
            "CustomerId": "\(userID)"
        ] as [String: Any]
        print(parameters)
        self.VM.myProifleDetails(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.loaderView.isHidden = true
                self.stopLoading()
                self.nameLbl.text = response?.lstCustomerJson?[0].firstName ?? "-"
                self.memberTypeTF.text = response?.lstCustomerJson?[0].customerType ?? "-"
//                self.firstNameTF.text = response?.lstCustomerJson?[0].firstName ?? "-"
//                self.lastNameTF.text = response?.lstCustomerJson?[0].lastName ?? "-"
                self.mobileNumberTF.text = response?.lstCustomerJson?[0].mobile ?? "-"
                self.emailTF.text = response?.lstCustomerJson?[0].email ?? "-"
                //self.dateOfBirthTF.text = response?.lstCustomerJson?[0].dob ?? "-"
                self.addressTF.text = response?.lstCustomerJson?[0].address1 ?? "-"
                self.stateBtn.setTitle(" \(response?.lstCustomerJson?[0].stateName ?? "-")", for: .normal)
                self.cityBtn.setTitle(" \(response?.lstCustomerJson?[0].districtName ?? "-")", for: .normal)
                self.pinTF.text = response?.lstCustomerJson?[0].zip ?? "-"
                let createdDate = (response?.lstCustomerJson?[0].jdob ?? "-").split(separator: " ")
                //let convertedFormat = self.convertDateFormater(String(createdDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
                self.dateOfBirthTF.text = "\(createdDate[0])"
                let profileDetails = response?.lstCustomerJson ?? []
                let customerImage = String(profileDetails[0].profilePicture ?? "").dropFirst()
                self.profileImageView.sd_setImage(with: URL(string: PROMO_IMG1 + "\(customerImage)"), placeholderImage: UIImage(named: "icons8-life-cycle-96"))
            }
            
        }
    }
    func notificationListApi(){
        DispatchQueue.main.async {
          self.startLoading()
//                self.loaderView.isHidden = false
//                self.playAnimation()
        }
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
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
            }else{
                DispatchQueue.main.async {
                    //                self.noDataFoundLbl.isHidden = false
                    //                self.notificationListTableView.isHidden = true
                    self.loaderView.isHidden = true
                    self.stopLoading()
                }
                
            }
        }
        
    }
    @IBAction func profileActBtn(_ sender: Any) {
    }
    @IBAction func panDetailsActBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PancardViewController") as! PancardViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func imageUpdateBtn(_ sender: Any) {
        
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.allowsEditing = false
//        picker.delegate = self
//        self.present(picker, animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
}
extension MSP_MyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
//        DispatchQueue.main.async {
//            guard let selectedImage = info[.originalImage] as? UIImage else {
//                return
//            }
//            let imageData = selectedImage.resized(withPercentage: 0.1)
//            let imageData1: NSData = imageData!.pngData()! as NSData
//            self.profileImageView.image = selectedImage
//            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
//            self.VM.imageSubmissionAPI(base64: self.strdata1)
////            picker.dismiss(animated: true, completion: nil)
////            self.dismiss(animated: true, completion: nil)
//
//        }
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
            
            let imageData = image.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.profileImageView.image = image
            //self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            let cropper = CropperViewController(originalImage: image)
            print(strdata1,"Image")
            cropper.delegate = self
            
            picker.dismiss(animated: true) {
            self.present(cropper, animated: true, completion: nil)
              
            }
          
    }
        
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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

extension MSP_MyProfileVC: CropperViewControllerDelegate {

    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
    cropper.dismiss(animated: true, completion: nil)
 
    if let state = state,
        let image = cropper.originalImage.cropped(withCropperState: state) {
        print(image,"imageDD")
        let imageData = image.resized(withPercentage: 0.1)
        let imageData1: NSData = imageData!.pngData()! as NSData
        self.profileImageView.image = image
        self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        print(strdata1,"kdjgjhdsj")
        self.profileImageView.image = image
        self.VM.imageSubmissionAPI(base64: self.strdata1)
        print(self.profileImageView.image,"lsjdkh")
    } else {
        print("Something went wrong")
    }
    self.dismiss(animated: true, completion: nil)
    }
}
