//
//  MSP_DropDownVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 26/11/2022.
//

import UIKit
import Toast_Swift
import Lottie
@objc protocol DropDownDelegate : AnyObject {
    func stateDidTap(_ vc: MSP_DropDownVC)
    func cityDidTap(_ vc: MSP_DropDownVC)
    func preferredLanguageDidTap(_ vc: MSP_DropDownVC)
    func genderDidTap(_ vc: MSP_DropDownVC)
    func titleDidTap(_ vc: MSP_DropDownVC)
    func dealerDipTap(_ vc: MSP_DropDownVC)
    func statusDipTap(_ vc: MSP_DropDownVC)
    func redemptionStatusDidTap(_ vc: MSP_DropDownVC)
    @objc optional func DidTappedCatagoryList(_ vc: MSP_DropDownVC)
}
class MSP_DropDownVC: BaseViewController{

    @IBOutlet weak var viewHolder: UIView!

    @IBOutlet var heightOfTable: NSLayoutConstraint!
    @IBOutlet var noDataFoundLbl: UILabel!
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var loaderAnimatedView: AnimationView!
    @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    weak var delegate:DropDownDelegate?
    var selectedTitle = ""
    var selectedId = ""
    var isComeFrom = 0
    var selectedStateID = -1
    var selectedCityID = -1
    var selectedPreferredID = -1
    var stateIDfromPreviousScreen = -1
    var countryIDfromPreviousScreen = 15
    var catagoryName = ""
    var selectedState = ""
    var selectedCity = ""
    var selectedLanguage = ""
    var selectedGender = ""
    
    var selectedDealerName = ""
    var selectedDealerId = -1
    
    var seletedRedemptionStatusId = -1
    var selectedRedemptionStatus = ""
    
    var VM = DropDownModels()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var genderArray = [String]()
    var titleArray = [String]()
    var statusListArray = ["Pending","Approved","Rejected", "Escalated"]
    var Catagorylist = ["Select Type","Dealer","Sub Dealer"]
    var selectedStatusName = ""
    var selectedStatusId = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.dropDownTableView.delegate = self
        self.dropDownTableView.dataSource = self
        if isComeFrom == 1{
             self.stateListingAPI(CountryID: countryIDfromPreviousScreen)
         }else if isComeFrom == 2{
             self.cityListingAPI(stateID: stateIDfromPreviousScreen)
         }else if isComeFrom == 3{
             self.preferredLanguageApi()
         }else if isComeFrom == 4 {
             self.dropDownTableView.reloadData()
         }else if isComeFrom == 5{
             self.dropDownTableView.reloadData()
         }else if isComeFrom == 6{
             self.claimPointsDealerApi()
         }else if isComeFrom == 7{
             self.dropDownTableView.reloadData()
         }else if isComeFrom == 8{
             self.myRedemptionStatusApi()
         }else if isComeFrom == 9{
             self.lodgeQueryStatusApi()
         }else if isComeFrom == 10{
             self.dropDownTableView.reloadData()
             self.heightOfTable.constant = 90
         }
        print(isComeFrom, "isComeFrom")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.dropDownTableView
            {
                self.dismiss(animated: true, completion: nil) }
        }
    func customerTypeApi(){
        let parametersJSON = [
            "ActionType":"33",
            "ActorId":"\(self.userID)"
        ] as! [String:Any]
        print(parametersJSON)
        //self.VM.customerTypeApi(parameters: parametersJSON)
    }
    func helptopicListingAPI(){
        let parametersJSON = [
            "IsActive": "true","ActionType": "4"
        ] as! [String:Any]
        print(parametersJSON)
     //   self.VM.helptopicAPI(parameters: parametersJSON)
    }
    func countryListingAPI(){
        let parameterJSON = [
            "ActionType":3
        ] as  [String:Any]
        print(parameterJSON)
     //   self.VM.countrylisting(parameters: parameterJSON)
    }
    func stateListingAPI(CountryID: Int){
        let parameterJSON = [
            "ActionType":"2",
            "IsActive":"true",
            "SortColumn":"STATE_NAME",
            "SortOrder":"ASC",
            "StartIndex":"1",
            "CountryID":15
        ] as  [String:Any]
        print(parameterJSON)
        self.VM.statelisting(parameters: parameterJSON)
    }

    func cityListingAPI(stateID: Int){
        let parameterJSON = [
            "ActionType":"2",
            "IsActive":"true",
            "SortColumn":"CITY_NAME",
            "SortOrder":"ASC",
            "StateId":"\(stateIDfromPreviousScreen)"
        ] as  [String:Any]
        print(parameterJSON)
        self.VM.citylisting(parameters: parameterJSON)
    }
    func preferredLanguageApi(){
        let parameterJSON = [
            "ActionType":24
        ] as  [String:Any]
        print(parameterJSON)
        self.VM.preferredLanguageApi(parameters: parameterJSON)
    }
    func lodgeQueryStatusApi(){
        let parameterJSON = [
            "ActionType": 150
        ] as  [String:Any]
        print(parameterJSON)
        self.VM.myRedemptionListApi(parameters: parameterJSON)
    }
    func myRedemptionStatusApi(){
        let parameterJSON = [
            "ActionType": 138
        ] as  [String:Any]
        print(parameterJSON)
        self.VM.myRedemptionListApi(parameters: parameterJSON)
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
                        if self.VM.myClaimsPointsDelarArray.count != 0 {
                            self.dropDownTableView.isHidden = false
                            self.dropDownTableView.reloadData()
                            self.noDataFoundLbl.isHidden = true
                            //self.heightOfTable.constant =
                            if self.VM.myClaimsPointsDelarArray.count < 10 {
                                for item in self.VM.myClaimsPointsDelarArray {
                                    self.heightOfTable.constant = CGFloat(self.VM.myClaimsPointsDelarArray.count * 30)
                                }
                            }else{
                                self.heightOfTable.constant = 350
                            }
                            
                        }else{
                            self.dropDownTableView.isHidden = true
                            self.noDataFoundLbl.isHidden = false
                            //self.dismiss(animated: true)
                            //self.view.makeToast("No Data Found !!", duration: 0.2, position: .center)
                        }
                        self.loaderView.isHidden = true
                        self.stopLoading()
                    }
                }
    }
    
    

}
extension MSP_DropDownVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(isComeFrom, "Its From")
        
       if isComeFrom == 1{
          
            return self.VM.stateArray.count
        }else if isComeFrom == 2{
            return self.VM.cityArray.count
        }else if isComeFrom == 3{
            return self.VM.preferredLanguageArray.count
        }else if isComeFrom == 4{
            return self.genderArray.count
        }else if isComeFrom == 5{
            print(self.titleArray.count)
            return self.titleArray.count
        }else if isComeFrom == 6{
            print(self.titleArray.count)
            return self.VM.myClaimsPointsDelarArray.count
        }else if isComeFrom == 7{
            return self.statusListArray.count
        }else if isComeFrom == 8 || isComeFrom == 9{
            return self.VM.myRedemptionListArray.count
        }else if isComeFrom == 10{
            return self.Catagorylist.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_DropdownTVC", for: indexPath) as? MSP_DropdownTVC
        cell!.selectionStyle = .none
       if isComeFrom == 1{
            cell!.dropdownInfo.text = self.VM.stateArray[indexPath.row].stateName ?? ""
        }else if isComeFrom == 2{
            cell!.dropdownInfo.text = self.VM.cityArray[indexPath.row].cityName ?? ""
        }else if isComeFrom == 3{
            cell!.dropdownInfo.text = self.VM.preferredLanguageArray[indexPath.row].attributeValue ?? ""
        }else if isComeFrom == 4{
            cell!.dropdownInfo.text = self.genderArray[indexPath.row]
        }else if isComeFrom == 5{
            cell!.dropdownInfo.text = self.titleArray[indexPath.row]
        }else if isComeFrom == 6{
            cell!.dropdownInfo.text = self.VM.myClaimsPointsDelarArray[indexPath.row].attributeValue ?? ""
        }else if isComeFrom == 7{
            cell!.dropdownInfo.text = self.statusListArray[indexPath.row]
        }else if isComeFrom == 8 || isComeFrom == 9{
            cell!.dropdownInfo.text = self.VM.myRedemptionListArray[indexPath.row].attributeValue ?? ""
        }else if isComeFrom == 10{
            cell!.dropdownInfo.text = self.Catagorylist[indexPath.row]
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     if isComeFrom == 1{
            self.selectedState = self.VM.stateArray[indexPath.row].stateName ?? ""
            self.selectedStateID = self.VM.stateArray[indexPath.row].stateId ?? -1
            self.delegate?.stateDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == 2{
            self.selectedCity = self.VM.cityArray[indexPath.row].cityName ?? ""
            self.selectedCityID = self.VM.cityArray[indexPath.row].cityId ?? -1
            self.delegate?.cityDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == 3{
            self.selectedLanguage = self.VM.preferredLanguageArray[indexPath.row].attributeValue ?? ""
            self.selectedPreferredID = self.VM.preferredLanguageArray[indexPath.row].attributeId ?? -1
            self.delegate?.preferredLanguageDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == 4{
            self.selectedGender = self.genderArray[indexPath.row]
            self.delegate?.genderDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == 5{
            self.selectedTitle = self.titleArray[indexPath.row]
            self.delegate?.titleDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == 6{
            self.selectedDealerName = self.VM.myClaimsPointsDelarArray[indexPath.row].attributeValue ?? ""
            self.selectedDealerId = self.VM.myClaimsPointsDelarArray[indexPath.row].attributeId ?? -1
            self.delegate?.dealerDipTap(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == 7{
            self.selectedStatusName = self.statusListArray[indexPath.row]
            if self.selectedStatusName == "Pending"{
                self.selectedStatusId = 0
            }else if self.selectedStatusName == "Approved"{
                self.selectedStatusId = 1
            }else if self.selectedStatusName == "Rejected"{
                self.selectedStatusId = -1
            }else if self.selectedStatusName == "Escalated"{
                self.selectedStatusId = 2
            }
//            else if self.selectedStatusName == "Cancelled"{
//                self.selectedStatusId = 3
//            }
            else if self.selectedStatusName == "Posted for approval"{
                self.selectedStatusId = 4
            }
            self.delegate?.statusDipTap(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == 8 || isComeFrom == 9{
            self.selectedRedemptionStatus = self.VM.myRedemptionListArray[indexPath.row].attributeValue ?? ""
            self.seletedRedemptionStatusId = self.VM.myRedemptionListArray[indexPath.row].attributeId ?? -1
            self.delegate?.redemptionStatusDidTap(self)
            self.dismiss(animated: true, completion: nil)
            
        }else if isComeFrom == 10{
            self.catagoryName = self.Catagorylist[indexPath.row]
            self.delegate?.DidTappedCatagoryList?(self)
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
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
    
