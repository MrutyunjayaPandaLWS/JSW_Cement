//
//  HR_TermsandCondtionVC.swift
//  HR_Johnson
//
//  Created by ADMIN on 14/05/2022.
//

import UIKit
import WebKit
import Firebase
import Lottie
protocol CheckBoxSelectDelegate{
    func accept(_ vc: HR_TermsandCondtionVC)
    func decline(_ vc: HR_TermsandCondtionVC)
}

class HR_TermsandCondtionVC: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
        
    }
    

    @IBOutlet var termsText: UITextView!
    @IBOutlet weak var webview1: WKWebView!
    @IBOutlet weak var termsandCondtions: UILabel!
    @IBOutlet weak var decline: UIButton!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    var boolResult:Bool = false
    var delegate: CheckBoxSelectDelegate!
    var requestAPIs = RestAPI_Requests()
    var itsFrom = ""
    var fromSideMenu = ""
    var tcListingArray = [LstTermsAndCondition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loaderView.isHidden = false
        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.dashboardTCApi()
        })
        
      }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Terms & condition")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    func dashboardTCApi(){
        DispatchQueue.main.async {
        self.startLoading()
        }
        let parameters = [
            "ActionType": 1,
             "ActorId": 2
        ] as [String: Any]
        print(parameters)
        self.requestAPIs.TCDetails(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.loaderView.isHidden = true
                        self.tcListingArray = result?.lstTermsAndCondition ?? []
                        if self.tcListingArray.count == 0{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "No terms and Conditions Found"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                                for data in self.tcListingArray{
                                    if data.html != ""{
                                        let htmlString = data.html ?? ""
                                        print(htmlString,"dlkshfug")
                                    self.webview1.loadHTMLString(htmlString , baseURL:nil)
                                        let content = "<html><body><p><font size=2>" + (data.html ?? "") + "</font></p></body></html>"
                                        self.webview1.loadHTMLString(content, baseURL: nil)
                                    }else{
                                        print("Data Wrong")
                                    }
                                        return
                                }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.loaderView.isHidden = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                    self.loaderView.isHidden = true
                }
            }
        }
    }

    func loadHTMLStringImage(htmlString:String) -> Void {
           let htmlString = "\(htmlString)"
        webview1.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
       }
    @IBAction func declineBTN(_ sender: Any) {
       
        self.boolResult = false
        self.delegate.decline(self)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func acceptBTN(_ sender: Any) {
        self.boolResult = true
        self.delegate.accept(self)
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
