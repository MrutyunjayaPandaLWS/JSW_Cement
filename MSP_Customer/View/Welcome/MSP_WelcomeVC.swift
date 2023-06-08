//
//  WelcomeVC.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 28/11/22.
//

import UIKit
import Firebase
import Lottie

class MSP_WelcomeVC: BaseViewController {
//
//    @IBOutlet var supportLbl: UILabel!
//
//    @IBOutlet var supportView: UIView!
    
    @IBOutlet var welcomeView: UIView!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
    @IBOutlet weak var loaderView: UIView!
    private var animationView11: AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = true
        self.tokendata()
        
        //        self.viewAndEditButton.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
        self.welcomeView.clipsToBounds = true
        welcomeView.layer.cornerRadius = 16
        welcomeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
//        self.supportView.clipsToBounds = true
//        supportView.layer.cornerRadius = 16
//        supportView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//
//        let topBorder = CALayer()
//        supportView.layer.borderWidth = 1
//        supportView.layer.borderColor = UIColor.red.cgColor
//        topBorder.frame = CGRect(x: 0.0, y: 0.0, width:self.supportView.frame.size.width, height: 1)
//        supportView.layer.addSublayer(topBorder)
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Welcome")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    func addTopBorders() {
       //let thickness: CGFloat = 1.0
//       let topBorder = CALayer()
//       topBorder.frame = CGRect(x: 0.0, y: 0.0, width:self.supportView.frame.size.width, height: thickness)
//        topBorder.backgroundColor = UIColor.red.cgColor
//        supportView.layer.addSublayer(topBorder)
    }
    
    @IBAction func loginActBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_LoginVC") as? MSP_LoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
//    @IBAction func registerActBtn(_ sender: Any) {
////        let vc = storyboard?.instantiateViewController(withIdentifier: "MSP_RegisterVC") as! MSP_RegisterVC
////        vc.itsFrom = "Welcome"
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    @IBAction func contactSupportBtn(_ sender: Any) {
//        if let phoneCallURL = URL(string: "tel://\(+918955177400)") {
//            
//            let application:UIApplication = UIApplication.shared
//            if (application.canOpenURL(phoneCallURL)) {
//                application.open(phoneCallURL, options: [:], completionHandler: nil)
//                
//            }
//        }
//        
//    }
    func tokendata(){
        DispatchQueue.main.async {
            self.startLoading()
            self.loaderView.isHidden = false
            self.playAnimation()
        }
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
                let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                        print(parseddata.access_token ?? "")
                        UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                    DispatchQueue.main.async {
                        self.loaderView.isHidden = true
                        self.stopLoading()
                    }
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
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
