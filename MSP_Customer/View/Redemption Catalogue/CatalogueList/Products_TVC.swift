//
//  Products_TVC.swift
//  centuryDemo
//
//  Created by Arkmacbook on 10/03/22.
//

import UIKit
protocol AddedToCartOrPlannerDelegate{
    func addToCart(_ cell: Products_TVC)
    func addToPlanner(_ cell: Products_TVC)
    func detailsDidTap(_ cell: Products_TVC)
}

class Products_TVC: UITableViewCell{

    @IBOutlet var productImage: UIImageView!
    @IBOutlet var categoryTypeLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet weak var addToPlanner: GradientButton!
    @IBOutlet weak var addedToPlanner: GradientButton!
    @IBOutlet weak var addedToCart: GradientButton!
    @IBOutlet var wishPlannerOutBTN: UIButton!
    
    
    @IBOutlet weak var detailsButton: UIButton!
    var delegate: AddedToCartOrPlannerDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    @IBAction func addToCartButton(_ sender: Any) {
        self.delegate.addToCart(self)
        
    }
    @IBAction func addToPlanners(_ sender: Any) {
        self.delegate.addToPlanner(self)
    }
    
    @IBAction func detailsBtn(_ sender: Any) {
        self.delegate.detailsDidTap(self)
    }
    //    @IBAction func wishplannerBTN(_ sender: Any) {
//
//    }
    
}
