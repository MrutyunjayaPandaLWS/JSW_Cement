//
//  MSP_CreateNewQueryVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 23/11/2022.
//

import UIKit
import Photos
import AVFoundation
import SDWebImage
import CoreData
import Firebase
import Lottie

class MSP_CreateNewQueryVC: BaseViewController, popUpDelegate,UITextViewDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}

    @IBOutlet weak var notificationCountLbl: UILabel!
    
    @IBOutlet weak var selectedLbl: UILabel!
    
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet weak var queryImage: UIImageView!
    @IBOutlet weak var uploadInfoLbl: UILabel!
    @IBOutlet weak var uploadInfoLbl2: UILabel!
    @IBOutlet weak var queryDetailsTextView: UITextView!
    @IBOutlet weak var dropDownView: UIView!
    
    @IBOutlet weak var dropDownTableView: UITableView!
    
    @IBOutlet weak var ImageSelectionView: UIView!
    
    @IBOutlet var submitOutBtn: GradientButton!
    @IBOutlet var cancelOutBtn: UIButton!
  @IBOutlet var imageHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
    @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
        var helptopicid = ""
        var strdata1 = ""
        var isFrom = 0
        var helptopicname:String = ""
        var isComeFrom = ""
        var codeData = [String]()
        var storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let VM = CreateNewQueryViewModel()
        var topicsarray = [ObjHelpTopicList]()
        var topicselectedID:String = ""
        let picker = UIImagePickerController()
        let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
        let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
        var querySummaryDetails = ""
        var selectedCodesArray = [String]()
        var strBase64 = ""
        var VM1 = HistoryNotificationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.dropDownView.isHidden = true
        self.dropDownTableView.delegate = self
        self.dropDownTableView.dataSource = self
        
        self.loaderView.isHidden = true
//        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.helpTopicListApi()
                })
      
        
        self.imageHeightConstrain.constant = 160
        //self.cancelOutBtn.isHidden = true
        self.queryDetailsTextView.textColor = .gray
        self.queryDetailsTextView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(querySubmissions), name: Notification.Name.querySubmission, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
//        self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Create Query")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.queryDetailsTextView.text == "Please Enter Message"{
            self.queryDetailsTextView.text = ""
            self.queryDetailsTextView.textColor = .black
        }
    }
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        self.noofcharacters.text = "\(self.queryDetailsTextView.text.count) / 100"
//    }
    
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let newText = (queryDetailsTextView.text as NSString).replacingCharacters(in: range, with: text)
//        let numberOfChars = newText.count
//        return numberOfChars < 101    // 10 Limit Value
//    }
    @objc func querySubmissions(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func dropDownBtn(_ sender: Any) {
        self.dropDownView.isHidden = false
        self.submitOutBtn.isHidden = true
    }
    @IBAction func favoriteBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func imageSelectionBtn(_ sender: Any) {
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
    
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dropDownView.isHidden = true
        self.submitOutBtn.isHidden = false
        
    }
    
    
    @IBAction func submitButton(_ sender: Any) {
        
        if selectedLbl.text == "  Select Topic"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                    vc!.descriptionInfo = "Select a Query Topic"
                 
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

        }else if queryDetailsTextView.text == "Please Enter Message"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Query Details is empty"
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }

            }else{
                self.loaderView.isHidden = false
                self.playAnimation()
                self.newQuerySubmissionApi()
            }
        
    }
    func helpTopicListApi(){
        let parameters = [
            "ActionType": "4",
              "ActorId": "\(userID)",
              "IsActive": "true"
        ] as [String: Any]
        print(parameters)
        self.VM.helpTopicList(parameters: parameters) { response in
            self.topicsarray = response?.objHelpTopicList ?? []
            print(self.topicsarray.count)
            DispatchQueue.main.async {
                self.dropDownTableView.isHidden = false
                self.dropDownTableView.reloadData()
                self.loaderView.isHidden = true
                self.stopLoading()
                
            }
            
        }
        
    }
    // submission Api
    
    func newQuerySubmissionApi(){
        let parameters = [
            "ActionType": "0",
            "ActorId": "\(userID)",
            "CustomerName": "null",
            "Email": "null",
            "HelpTopic": selectedLbl.text ?? "",
            "HelpTopicID": "\(helptopicid)",
            "IsQueryFromMobile": "true",
            "LoyaltyID": "\(loyaltyId)",
            "QueryDetails": self.queryDetailsTextView.text ?? "",
            "QuerySummary": self.queryDetailsTextView.text ?? "",
            "SourceType": "1",
            "ImageUrl": "\(self.strdata1)",
        ] as [String: Any]
        print(parameters)
        self.VM.newQuerySubmission(parameters: parameters) { response in
            if response?.returnMessage ?? "" != "" || response?.returnMessage ?? nil != nil{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "QuerySubmission"
                    vc!.descriptionInfo = "Query Submitted successfully!"
                    vc!.modalPresentationStyle = .overFullScreen
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
                    vc!.itsComeFrom = "QuerySubmission"
                    vc!.descriptionInfo = "Something went wrong please try again later."
                    vc!.modalPresentationStyle = .overFullScreen
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
                self.notificationCountLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.notificationCountLbl.isHidden = true
            }
           
        }
        
    }
    
}
extension MSP_CreateNewQueryVC: UITableViewDataSource, UITableViewDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicsarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_QueryTypeListingTVC") as? MSP_QueryTypeListingTVC
        cell?.selectionStyle = .none
        cell?.topicslabel.text = self.topicsarray[indexPath.row].helpTopicName ?? ""
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLbl.text = "  \(topicsarray[indexPath.row].helpTopicName ?? "")"
        helptopicid  = "\(topicsarray[indexPath.row].helpTopicId ?? 0)"
        print(helptopicid)
         dropDownView.isHidden = true
        self.submitOutBtn.isHidden = false
    }
    

    func openGallery() {
        DispatchQueue.main.async {
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .photoLibrary
                        self.picker.mediaTypes = ["public.image"]
                        self.present(self.picker, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery Access", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
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
        
    }
    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {
                                self.picker.allowsEditing = false
                                self.picker.sourceType = UIImagePickerController.SourceType.camera
                                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }            } else {
                            DispatchQueue.main.async {
                                let alertVC = UIAlertController(title: "Need Camera Access", message: "Allow Camera Access", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }
                            
                            
                        }
                }} else {
                    self.noCamera()
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
                    let alertVC = UIAlertController(title: "MSP customer Application need to access camera gallery", message: "", preferredStyle: .alert)
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
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry no device", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        DispatchQueue.main.async { [self] in
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            self.imageHeightConstrain.constant = 200
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.queryImage.isHidden = false
            self.queryImage.image = selectedImage
            self.uploadInfoLbl.isHidden = true
            self.uploadInfoLbl2.isHidden = true
          
            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            picker.dismiss(animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
