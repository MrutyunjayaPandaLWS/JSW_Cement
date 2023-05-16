//
//  KC_DropDownVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/02/2023.
//

import UIKit


@objc protocol DealerDropdownlistDelagate: AnyObject{
   @objc optional func selectedDealer(item: SelectDealerDropDownVC)

}


class SelectDealerDropDownVC: BaseViewController,UISearchBarDelegate {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dropDownTableView: UITableView!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    var itsFrom = ""
    var isComeFrom = ""
    var selectedDealerName = ""
    var selectedDealerId = -1
    var VM = SelectDealerDropDownVM()
    var delegate: DealerDropdownlistDelagate?
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.noDataFoundLbl.isHidden = true
        self.dropDownTableView.delegate = self
        self.dropDownTableView.dataSource = self
        self.noDataFoundLbl.isHidden = true
        claimPointsDealerApi()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view == self.view {
            self.dismiss(animated: true, completion: nil)
            self.searchBar.resignFirstResponder()
        } else {
            self.searchBar.resignFirstResponder()
        }
    }
    override func viewWillLayoutSubviews() {
        
    }
    
    @IBAction func selectCloseBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func claimPointsDealerApi(){
        self.VM.myClaimsPointsDelarArray.removeAll()
        let parameters = [
                "ActionType": 68,
                "ActorId": "\(userID)"
                ] as [String : Any]
                print(parameters)
                self.VM.claimPointsDelarAPI(parameters: parameters) { response in
                    self.VM.myClaimsPointsDelarArray = response?.lstAttributesDetails ?? []
                    print(self.VM.myClaimsPointsDelarArray.count, "")
                    DispatchQueue.main.async {
                        self.VM.myClaimsPointsDelarArray1 = self.VM.myClaimsPointsDelarArray
                        if self.VM.myClaimsPointsDelarArray.count != 0 {
                            self.dropDownTableView.isHidden = false
                            self.dropDownTableView.reloadData()
                            self.noDataFoundLbl.isHidden = true
                        }else{
                            self.dropDownTableView.isHidden = true
                            self.noDataFoundLbl.isHidden = false
                            //self.dismiss(animated: true)
                            //self.view.makeToast("No Data Found !!", duration: 0.2, position: .center)
                        }
                        self.stopLoading()
                    }
                }
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            if self.VM.myClaimsPointsDelarArray.count > 0 {
                let arr = self.VM.myClaimsPointsDelarArray.filter{ ($0.attributeValue!.localizedCaseInsensitiveContains(searchBar.text!))}
                if self.searchBar.text != ""{
                    
                    if arr.count > 0 {
                        self.VM.myClaimsPointsDelarArray.removeAll(keepingCapacity: true)
                        self.VM.myClaimsPointsDelarArray = arr
                        self.dropDownTableView.reloadData()
                        dropDownTableView.isHidden = false
                    }else {
                        self.VM.myClaimsPointsDelarArray = self.VM.myClaimsPointsDelarArray1
                        self.dropDownTableView.reloadData()
                        dropDownTableView.isHidden = true
                    }
                }else{
                    self.VM.myClaimsPointsDelarArray = self.VM.myClaimsPointsDelarArray1
                    self.dropDownTableView.reloadData()
                    dropDownTableView.isHidden = false
                }
                let searchText = searchBar.text!
                if searchText.count > 0 || self.VM.myClaimsPointsDelarArray1.count == self.VM.myClaimsPointsDelarArray.count {
                    self.dropDownTableView.reloadData()
                }
            }
        }

}
extension SelectDealerDropDownVC: UITableViewDelegate, UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewHeightConstraint.constant = CGFloat(30 * self.VM.myClaimsPointsDelarArray.count)
        return self.VM.myClaimsPointsDelarArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDealerDropDownTVC", for: indexPath) as! SelectDealerDropDownTVC
        cell.selectedTitleLbl.text = self.VM.myClaimsPointsDelarArray[indexPath.row].attributeValue ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.itsFrom)
       
        self.selectedDealerName = self.VM.myClaimsPointsDelarArray[indexPath.row].attributeValue ?? ""
        self.selectedDealerId = self.VM.myClaimsPointsDelarArray[indexPath.row].attributeId ?? -1
        self.delegate?.selectedDealer!(item: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
    
}

