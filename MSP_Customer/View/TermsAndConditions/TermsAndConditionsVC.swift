//
//  TermsAndConditionsVC.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 20/04/22.
//

import UIKit
import Lottie
class TermsAndConditionsVC: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var webViewKit: UIWebView!
    
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    
    
    
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
                                    self.webViewKit.loadHTMLString(htmlString , baseURL:nil)
                                        let content = "<html><body><p><font size=2>" + (data.html ?? "") + "</font></p></body></html>"
                                        self.webViewKit.loadHTMLString(content, baseURL: nil)
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

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func loadHTMLStringImage(htmlString:String) -> Void {
           let htmlString = "\(htmlString)"
        webViewKit.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
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
