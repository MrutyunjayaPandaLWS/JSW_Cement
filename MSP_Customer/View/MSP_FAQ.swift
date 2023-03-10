//
//  MSP_FAQ.swift
//  MSP_Customer
//
//  Created by ADMIN on 05/12/2022.
//

import UIKit
import WebKit
class MSP_FAQ: BaseViewController {

    @IBOutlet weak var webviewKit: UIWebView!
    
    var fromSideMenu = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        webviewKit.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "udaan_ilp_faqs", ofType: "html")!) as URL) as URLRequest)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "FAQ")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        
       
    }

    @IBAction func backBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
//    func loadHTMLStringImage(htmlString:String) -> Void {
//           let htmlString = "\(htmlString)"
//        webViewKit.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
//       }
}
