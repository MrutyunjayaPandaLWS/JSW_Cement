//
//  gradientView.swift
//  VolvoMITR
//
//  Created by Arokia IT on 3/31/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit

@IBDesignable
class GradientButton: UIButton {

    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.01 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.99 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

@IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.01 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.99 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

@IBDesignable
class GradientTabBarController: UITabBarController {

        let gradientlayer = CAGradientLayer()

        override func viewDidLoad() {
            super.viewDidLoad()
//            setGradientBackground(colorOne: #colorLiteral(red: 0.03399862722, green: 0.07562554628, blue: 0.3805418015, alpha: 1), colorTwo: #colorLiteral(red: 0.8941176471, green: 0.1647058824, blue: 0.1411764706, alpha: 1))
            setGradientBackground(colorOne: UIColor(hexString: "184A98"), colorTwo: UIColor(hexString: "E92327"))
        }

        func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
            gradientlayer.frame = tabBar.bounds
            gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
            gradientlayer.locations = [0, 1]
            gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
            self.tabBar.layer.insertSublayer(gradientlayer, at: 0)
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tabBar.frame.size.height = 80
        //tabBar.layer.cornerRadius = 8
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowOpacity = 1
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = UIColor.clear
      //  tabBar.frame.origin.y = view.frame.height - 10
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
         if self.selectedIndex == 0 {
            let rootView = self.viewControllers![self.selectedIndex] as! UINavigationController
            rootView.popToRootViewController(animated: false)
         }else if self.selectedIndex == 1{
             self.tabBarController?.selectedIndex = selectedIndex
         }else if self.selectedIndex == 2{
             self.tabBarController?.selectedIndex = selectedIndex
         }
     }
}
@IBDesignable
class GradientLabel: UILabel {

    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.01 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.99 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
