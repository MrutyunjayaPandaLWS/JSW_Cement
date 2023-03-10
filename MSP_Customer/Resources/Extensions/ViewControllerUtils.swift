//
//  ViewControllerUtili.swift
//  SuperStamp Project
//
//  Created by Arokia-M3 on 19/08/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc public func showOnScreenLoader() {
       
        ViewControllerUtils.sharedInstance.showActivityIndicator(uiView: self.view)
    }
    
    @objc public func hideOnScreenLoader() {
        
        ViewControllerUtils.sharedInstance.hideActivityIndicator(uiView: self.view)
    }
    
}

class ViewControllerUtils {

    // Swift 3.0
    static let _sharedInstance = ViewControllerUtils()

    // private init() This prevents others from using the default '()' initializer for this class.
    private init() {

    }

    class var sharedInstance: ViewControllerUtils {
        return _sharedInstance
    }
    
    

    var circleAnimator:SpinnerView = SpinnerView()
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var loadingImageView: UIImageView = UIImageView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator(uiView: UIView) {
        container.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        container.center = CGPoint(x: <#T##Double#>, y: <#T##Double#>)
//        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        container.backgroundColor = UIColorFromHex(rgbValue: 0x000000, alpha: 0.3)
        
        
        loadingView.frame = CGRect.init(origin: CGPoint(x:0, y:0), size: CGSize(width: 80, height: 80))
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue:0x444444, alpha: 0.5)//0.7
        //loadingView.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "bg_splash.png"))
        loadingView.backgroundColor = UIColor.clear
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        
        activityIndicator.frame = CGRect.init(origin: CGPoint(x:0, y:0), size: CGSize(width: 40, height: 40))
        //CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        //loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        
        let width:CGFloat = 80.0
        loadingImageView.frame = CGRect.init(origin: CGPoint(x:UIScreen.main.bounds.size.width / 2 - width/2, y: UIScreen.main.bounds.size.height / 2 - width/2), size: CGSize(width: width, height: width))
        loadingImageView.image = UIImage(named:"loder-icon.png")
        loadingImageView.contentMode = .scaleToFill
        container.addSubview(loadingImageView)
        loadingImageView.layer.masksToBounds = true
        loadingImageView.layer.cornerRadius = width/2.0
        loadingImageView.layer.borderWidth = 4.0
        loadingImageView.layer.borderColor = UIColor.white.cgColor
        loadingImageView.tag = 99
    
        circleAnimator.frame = CGRect.init(origin: CGPoint(x:UIScreen.main.bounds.size.width / 2 - width/2, y: UIScreen.main.bounds.size.height / 2 - width/2), size: CGSize(width: width, height: width))
        circleAnimator.tag = 100
        container.addSubview(circleAnimator)
        
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator(uiView: UIView) {
        
        if let vw:UIView = container.viewWithTag(100){
            
            vw.layer.removeAllAnimations()
            vw.removeFromSuperview()
        }
        if let vw:UIView = container.viewWithTag(99){
            
            vw.removeFromSuperview()
        }
        
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
        
//        activityIndicator.removeFromSuperview()
//        loadingView.removeFromSuperview()
//        container.removeFromSuperview()
//        container.isHidden = true
//        container = UIView()
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}

extension UIImage {
    
    func tint(with color: UIColor) -> UIImage
    {
        UIGraphicsBeginImageContext(self.size)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        // flip the image
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -self.size.height)
        
        // multiply blend mode
        context.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        
        // create UIImage
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        
        return newImage
    }

    
}

//// In order to show the activity indicator, call the function from your view controller
//// ViewControllerUtils().showActivityIndicator(self.view)
//// In order to hide the activity indicator, call the function from your view controller
//// ViewControllerUtils().hideActivityIndicator(self.view)
