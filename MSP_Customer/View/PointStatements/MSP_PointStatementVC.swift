//
//  MSP_PointStatementVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 24/11/2022.
//

import UIKit
import Firebase
import Lottie

class MSP_PointStatementVC: BaseViewController , DateSelectedDelegate, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func acceptDate(_ vc: MSP_DOBVC) {
            if vc.isComeFrom == "1"{
                self.selectedFromDate = vc.selectedDate
                self.fromDateLbl.text = vc.selectedDate
                self.fromDateLbl.textColor = .black
            }else{
                self.selectedToDate = vc.selectedDate
                self.toDateLbl.text = self.selectedToDate
                self.toDateLbl.textColor = .black
            }
    }
    
    func declineDate(_ vc: MSP_DOBVC) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var redeemablepointsLbl: UILabel!
    @IBOutlet weak var redeeamblepointsTitleLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var tablePointStatementTableView: UITableView!
    @IBOutlet weak var totalPts: UILabel!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet var filterView: UIView!
    @IBOutlet var fromDateLbl: UILabel!
    @IBOutlet var toDateLbl: UILabel!
    @IBOutlet var basePointsOutBtn: UIButton!
    @IBOutlet var rewardAdjustOutBtn: UIButton!
    @IBOutlet var frequenctmultiOutBtn: UIButton!
    @IBOutlet var consistencyOutBtn: UIButton!
    @IBOutlet var rangeMultiOutBtn: UIButton!
    @IBOutlet var volumeOutBtn: UIButton!
    
    @IBOutlet var todayOutBtn: UIButton!
    @IBOutlet var yesterdaysOutBtn: UIButton!
    @IBOutlet var monthOutBtn: UIButton!
    @IBOutlet var sixMonthOutBtn: UIButton!
    @IBOutlet var yearOutBtn: UIButton!
    @IBOutlet var allOutBtn: UIButton!
    @IBOutlet var creditOutBtn: UIButton!
    @IBOutlet var debitOutBtn: UIButton!
    
    @IBOutlet weak var loaderAnimatedView: AnimationView!
       @IBOutlet weak var loaderView: UIView!
    
    private var animationView11: AnimationView?
    
    let customerTypeId = UserDefaults.standard.value(forKey: "CustomerTypeId") ?? 0
    let totalRedeemedPts = UserDefaults.standard.integer(forKey: "TotalRedeemedPoints")
    let redeamblepoints = UserDefaults.standard.integer(forKey: "overAllPointsEarned")
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var fromSideMenu = ""
    var credited = ""
    var debited = ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM1 = HistoryNotificationsViewModel()
    var monthStartDate = ""
    let date = Date()
    let format = DateFormatter()
    var yearStartDate = ""
    var currentDate = ""
    var selectedtoDate = ""
    var sixmonthDate = ""
    var selectedFromDate = ""
    var selectedToDate = ""
    var behaviourId = ""
    var selectedStatus = ""
    var behaviourIdArray = [String]()
    
    var basePoints = ""
    var rewardAdjustmentPoints = ""
    var requencyMultyPliersPoint = ""
    
    
    //    49    Dealer
    //    50    Sales Promoter
    //    51    Retailer
    //    52    Contractor
    //    53    Undefined
    
    var VM = PointStatemntModelCLassVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalPts.text = "\(self.totalRedeemedPts ?? 0)"
        self.redeemablepointsLbl.text = "\(redeamblepoints ?? 0)"
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.volumeOutBtn.isHidden = true
        self.consistencyOutBtn.isHidden = true
        self.rangeMultiOutBtn.isHidden = true
        self.volumeOutBtn.isHidden = true
        self.tablePointStatementTableView.delegate = self
        self.tablePointStatementTableView.dataSource = self
        self.tablePointStatementTableView.register(UINib(nibName: "MSP_PointSummaryTVC", bundle: nil), forCellReuseIdentifier: "MSP_PointSummaryTVC")
        self.filterView.isHidden = true
        
        self.loaderView.isHidden = false
        self.playAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.pointStatementListApi()
        })
     
        if customerTypeId as! Int == 51{
            //Contractor
            self.frequenctmultiOutBtn.isHidden = false
            self.consistencyOutBtn.isHidden = true
            self.volumeOutBtn.isHidden = true
            self.rangeMultiOutBtn.isHidden = true
        }else if customerTypeId as! Int == 52{
            self.consistencyOutBtn.isHidden = true
            self.volumeOutBtn.isHidden = true
            self.rangeMultiOutBtn.isHidden = true
            self.frequenctmultiOutBtn.isHidden = true
        }else{
            self.consistencyOutBtn.isHidden = true
            self.volumeOutBtn.isHidden = true
            self.rangeMultiOutBtn.isHidden = true
            self.frequenctmultiOutBtn.isHidden = true        }
        
        self.tablePointStatementTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 110,right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loaderView.isHidden = true
       // self.notificationListApi()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Point Statement")
//        
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        
        self.todayOutBtn.setTitleColor(.black, for: .normal)
        self.yearOutBtn.setTitleColor(.black, for: .normal)
        self.yesterdaysOutBtn.setTitleColor(.black, for: .normal)
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    @IBAction func filterActBTN(_ sender: Any) {
        self.filterView.isHidden = false
    }
    
    
    
    
    
    
    
    @IBAction func filterCloseBtn(_ sender: Any) {
        self.filterView.isHidden = true
    }
    
    @IBAction func fromDateBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func toDateBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_DOBVC") as? MSP_DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "2"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func todayBtn(_ sender: Any) {
        
        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
        let today = yesterday.split(separator: " ")
        let desiredDateFormat = convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
        self.fromDateLbl.text = "\(desiredDateFormat)"
        self.fromDateLbl.textColor = .black
        self.toDateLbl.text = "\(desiredDateFormat)"
        self.toDateLbl.textColor = .black
        
        self.selectedFromDate = "\(desiredDateFormat)"
        self.selectedToDate = "\(desiredDateFormat)"
        //self.todayOutBtn.backgroundColor = .red
        if self.todayOutBtn.currentTitle == "Today" {
            self.todayOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.yearOutBtn.backgroundColor = .white
            self.monthOutBtn.backgroundColor = .white
            self.sixMonthOutBtn.backgroundColor = .white
            self.yesterdaysOutBtn.backgroundColor = .white
            
            self.todayOutBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.yesterdaysOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.sixMonthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.yearOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.monthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        }
    }
    
    @IBAction func yesterDateActBtn(_ sender: Any) {
        let today = Date().description.split(separator: " ")
        let yesterday = "\(Calendar.current.date(byAdding: .day, value: -1, to: Date())!)"
        let chanegeFormate = yesterday.split(separator: " ")
        let desiredDateFormat = convertDateFormater("\(chanegeFormate[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
        let desiredDate = convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
        self.fromDateLbl?.text = "\(desiredDateFormat)"
        self.fromDateLbl.textColor = .black
        self.toDateLbl.text = "\(desiredDateFormat)"
        self.toDateLbl.textColor = .black
        self.selectedFromDate = "\(desiredDateFormat)"
        self.selectedToDate = "\(desiredDateFormat)"
        //if self.yesterdaysOutBtn.currentTitle == "Yesterday" {
            self.yesterdaysOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.yearOutBtn.backgroundColor = .white
            self.monthOutBtn.backgroundColor = .white
            self.sixMonthOutBtn.backgroundColor = .white
            self.todayOutBtn.backgroundColor = .white
            
            self.yesterdaysOutBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.todayOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.yearOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.monthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.sixMonthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
     //   }
    }
    
    @IBAction func monthBtn(_ sender: Any) {
//        print(Date().endOfMonth())
//        print(Date().startOfMonth())
//        let calendar: Calendar = Calendar.current
        let startDate = Date().startOfMonth
        let startingMonth = startDate.description.split(separator: " ")
        print("startDate :: \(startingMonth[0])")
        let monthDate = Date().getPreviousMonth()
        print(monthDate)
        print(Date().getThisMonthStart())

        let desiredMonthDate = convertDateFormater("\(startingMonth[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
//
        
       
        
        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 1, to: Date())!)"
        let today = yesterday.split(separator: " ")
        let desiredDateFormat = convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
        
        self.toDateLbl.text = "\(desiredDateFormat)"
        self.toDateLbl.textColor = .black
        
        print(desiredDateFormat)
        self.selectedFromDate = "\(desiredMonthDate)"
        self.selectedToDate = "\(desiredDateFormat)"
        
     //   if self.monthOutBtn.currentTitle == "This Month" {
            self.monthOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.yearOutBtn.backgroundColor = .white
            self.yesterdaysOutBtn.backgroundColor = .white
            self.sixMonthOutBtn.backgroundColor = .white
            self.todayOutBtn.backgroundColor = .white
       // }
        if let startDate = getCurrentMonthStartDate() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startDateString = dateFormatter.string(from: startDate)
            self.fromDateLbl.text = "\(startDateString)"
            self.fromDateLbl.text = "\(startDateString)"
            self.fromDateLbl.textColor = .black
            print("The current month's starting date is: \(startDateString)")
        } else {
            print("Failed to get the current month's starting date.")
        }
        
        self.yesterdaysOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.todayOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.yearOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.monthOutBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.sixMonthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        
    }
    
    
    
    func getCurrentMonthStartDate() -> Date? {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        var firstDayComponents = DateComponents()
        firstDayComponents.year = components.year
        firstDayComponents.month = components.month
        firstDayComponents.day = 1
        let firstDayOfCurrentMonth = calendar.date(from: firstDayComponents)
        return firstDayOfCurrentMonth
    }

    // Get the current month's starting date
    
   

    
    @IBAction func sixMonthBtn(_ sender: Any) {
       // let today = Date().description.split(separator: " ")
        let previousMonth = "\(Calendar.current.date(byAdding: .day, value: -180, to: Date())!)"
        let exactPrivDate = previousMonth.split(separator: " ")
        let desiredMonthDate = convertDateFormater("\(exactPrivDate[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
    
        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
        let today = yesterday.split(separator: " ")
       // let desiredDateFormat = convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
        
        let desiredTodaysDate = convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
        self.fromDateLbl.text = "\(desiredMonthDate)"
        self.fromDateLbl.textColor = .black
        self.toDateLbl.text = "\(desiredTodaysDate)"
        self.toDateLbl.textColor = .black
        self.selectedFromDate = "\(desiredMonthDate)"
        self.selectedToDate = "\(desiredTodaysDate)"
        
      //  if self.sixMonthOutBtn.currentTitle == "Last 6 Month" {
        self.sixMonthOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.yearOutBtn.backgroundColor = .white
            self.yesterdaysOutBtn.backgroundColor = .white
            self.monthOutBtn.backgroundColor = .white
            self.todayOutBtn.backgroundColor = .white
            
            self.yesterdaysOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.todayOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.yearOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.monthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.sixMonthOutBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        //}
    }
    
    @IBAction func yearBtn(_ sender: Any) {
        
        var components = Calendar.current.dateComponents([.year], from: Date())
        if let startDateOfYear = Calendar.current.date(from: components) {
            components.year = 0
            components.day = 1
            let lastDateOfYear = Calendar.current.date(byAdding: components, to: startDateOfYear)
            print(startDateOfYear)
            print(lastDateOfYear!)
            let yearDate = lastDateOfYear
            let fromDatee = "\(yearDate!)".split(separator: " ")
            print( "\(fromDatee[0] ?? "")")
            let desiredTodaysDate = convertDateFormater("\(fromDatee[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
            self.fromDateLbl.text = "\(desiredTodaysDate)"
            self.selectedFromDate = "\(desiredTodaysDate)"
        }
        
       // let today = Date().description.split(separator: " ")
        let previousMonth = "\(Calendar.current.date(byAdding: .day, value: -365, to: Date())!)"
        let exactPrivDate = previousMonth.split(separator: " ")
        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
        let today = yesterday.split(separator: " ")
        let desiredTodaysDate = convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
        
        self.fromDateLbl.textColor = .black
        self.toDateLbl.text = "\(desiredTodaysDate)"
        self.selectedToDate = "\(desiredTodaysDate)"
        self.toDateLbl.textColor = .black
      //  if self.yearOutBtn.currentTitle == "This Year" {
            self.yearOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.sixMonthOutBtn.backgroundColor = .white
            self.yesterdaysOutBtn.backgroundColor = .white
            self.monthOutBtn.backgroundColor = .white
            self.todayOutBtn.backgroundColor = .white
            
            self.yesterdaysOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.todayOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.yearOutBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.monthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.sixMonthOutBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
      //  }
    }
    
    @IBAction func allBtn(_ sender: Any) {

        self.selectedStatus = "All"
            self.allOutBtn.backgroundColor = .red
            self.debitOutBtn.backgroundColor = .white
            self.creditOutBtn.backgroundColor = .white
            self.allOutBtn.setTitleColor(.white, for: .normal)
            self.debitOutBtn.setTitleColor(.black, for: .normal)
            self.creditOutBtn.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func selectFilterCredit(_ sender: Any) {
    
        self.selectedStatus = "Credited"
            self.creditOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.debitOutBtn.backgroundColor = .white
            self.allOutBtn.backgroundColor = .white
            self.allOutBtn.setTitleColor(.black, for: .normal)
            self.debitOutBtn.setTitleColor(.black, for: .normal)
            self.creditOutBtn.setTitleColor(.white, for: .normal)
        
        
        
    }
    
    @IBAction func selectFilterDebitBtn(_ sender: Any) {
     
            self.selectedStatus = "Debited"
            self.debitOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.creditOutBtn.backgroundColor = .white
            self.allOutBtn.backgroundColor = .white
            self.allOutBtn.setTitleColor(.black, for: .normal)
            self.debitOutBtn.setTitleColor(.white, for: .normal)
            self.creditOutBtn.setTitleColor(.black, for: .normal)
     }
    
    
    @IBAction func basePointsBtn(_ sender: Any) {
        
        if self.basePointsOutBtn.backgroundColor == #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1){
            self.basePointsOutBtn.backgroundColor = .white
            self.basePointsOutBtn.setTitleColor(.black, for: .normal)
            self.behaviourId = ""
            self.behaviourIdArray.append("")
            self.basePoints = ""
            
        }else if basePointsOutBtn.backgroundColor == .white{
            self.basePointsOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.basePointsOutBtn.setTitleColor(.white, for: .normal)
            self.behaviourId = "1"
            self.behaviourIdArray.append("1")
            self.basePoints = "1"
        }
    }
    
    @IBAction func rewardAdjustBtn(_ sender: Any) {
        
        
        if rewardAdjustOutBtn.backgroundColor == #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1) {
            self.rewardAdjustOutBtn.backgroundColor = .white
            self.rewardAdjustOutBtn.setTitleColor(.black, for: .normal)
            self.rewardAdjustmentPoints = ""
            self.behaviourId = ""
            self.behaviourIdArray.append("")
        }else if rewardAdjustOutBtn.backgroundColor == .white{
            self.behaviourId = "1"
            self.behaviourIdArray.append("1")
            self.rewardAdjustOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
            self.rewardAdjustOutBtn.setTitleColor(.white, for: .normal)
            self.rewardAdjustmentPoints = "1"
        }
        
        
//        self.basePointsOutBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.frequenctmultiOutBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.basePointsOutBtn.setTitleColor(.black, for: .normal)
//        self.frequenctmultiOutBtn.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func frequencyBtn(_ sender: Any) {
        self.behaviourId = "44"
        self.behaviourIdArray.append("44")
        self.frequenctmultiOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
//        self.rewardAdjustOutBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.basePointsOutBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.basePointsOutBtn.setTitleColor(.black, for: .normal)
//        self.rewardAdjustOutBtn.setTitleColor(.black, for: .normal)
        self.frequenctmultiOutBtn.setTitleColor(.white, for: .normal)
        self.requencyMultyPliersPoint = "44"
    }

    
    @IBAction func volumebtn(_ sender: Any) {
        self.volumeOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
    }
    
    @IBAction func rangeMultiBtn(_ sender: Any) {
        self.rangeMultiOutBtn.backgroundColor = #colorLiteral(red: 0.8922217488, green: 0.1653764248, blue: 0.1413091719, alpha: 1)
    }
    
    @IBAction func resetBtn(_ sender: Any) {
        self.behaviourIdArray.removeAll()
        self.toDateLbl.text = "To date"
        self.fromDateLbl.text = "From date"
        self.todayOutBtn.backgroundColor = .white
        self.yesterdaysOutBtn.backgroundColor = .white
        self.monthOutBtn.backgroundColor = .white
        self.sixMonthOutBtn.backgroundColor = .white
        self.yearOutBtn.backgroundColor = .white
        self.allOutBtn.backgroundColor = .white
        self.creditOutBtn.backgroundColor = .white
        self.debitOutBtn.backgroundColor = .white
        self.creditOutBtn.backgroundColor = .white
        
        self.selectedStatus = ""
        self.behaviourId = ""
        
        self.basePointsOutBtn.backgroundColor = .white
        self.rewardAdjustOutBtn.backgroundColor = .white
        self.frequenctmultiOutBtn.backgroundColor = .white
        
        self.todayOutBtn.setTitleColor(.black, for: .normal)
        self.yesterdaysOutBtn.setTitleColor(.black, for: .normal)
        self.monthOutBtn.setTitleColor(.black, for: .normal)
        self.sixMonthOutBtn.setTitleColor(.black, for: .normal)
        self.yearOutBtn.setTitleColor(.black, for: .normal)
        self.allOutBtn.setTitleColor(.black, for: .normal)
        self.creditOutBtn.setTitleColor(.black, for: .normal)
        self.debitOutBtn.setTitleColor(.black, for: .normal)
        self.basePointsOutBtn.setTitleColor(.black, for: .normal)
        self.rewardAdjustOutBtn.setTitleColor(.black, for: .normal)
        self.frequenctmultiOutBtn.setTitleColor(.black, for: .normal)
        self.consistencyOutBtn.setTitleColor(.black, for: .normal)
        self.rangeMultiOutBtn.setTitleColor(.black, for: .normal)
        self.volumeOutBtn.setTitleColor(.black, for: .normal)
        self.selectedFromDate = ""
        self.selectedToDate = ""
        self.basePoints = ""
        self.rewardAdjustmentPoints = ""
        self.requencyMultyPliersPoint = ""
        self.filterView.isHidden = true
        self.pointStatementListApi()
        
    }
    
    @IBAction func filterActBtn(_ sender: Any) {
        
        if fromDateLbl.text == "From date" &&  toDateLbl.text != "To date"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please select From date"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if fromDateLbl.text != "From date" &&  toDateLbl.text == "To date"{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please select To date"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if self.selectedFromDate > self.selectedToDate{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "To date shouldn't greater than from date"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                self.filterView.isHidden = true
                if self.selectedStatus == "All"{
                    self.selectedStatus = ""
                }
                
                self.pointStatementListApi()
            }
        }
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_NotificationVC") as! MSP_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pointStatementListApi(){
        DispatchQueue.main.async {
          self.startLoading()
        }
        //{"ActionType":"1","ActorId":"99981","BasePoints":"","BehaviorId":"","ConsistencyMultiplierPoints":"","FrequencyMultyPliersPoint":"","FromDate":"","RewardAdjustmentPoints":"","Status":"","ToDate":""}
        
        //["ActionType": "1", "ActorId": "99981", "ToDate": "", "Status": "", "BasePoints": "", "ConsistencyMultiplierPoints": "", "FrequencyMultyPliersPoint": "", "BehaviorId": "", "FromDate": "", "RewardAdjustmentPoints": ""]
        
        let parameters = [
                "ActionType": "1",
                "ActorId": "\(userID)",
                "BehaviorId": "",
                "FromDate": "\(self.selectedFromDate)",
                "Status": "\(self.selectedStatus)",
                "ToDate": "\(self.selectedToDate)",
                "BasePoints": "\(self.basePoints)",
                "RewardAdjustmentPoints": "\(self.rewardAdjustmentPoints)",
                "FrequencyMultyPliersPoint": "\(self.requencyMultyPliersPoint)",
                "ConsistencyMultiplierPoints": ""
           ] as [String : Any]
        print(parameters)
        self.VM.pointStatementAPI(parameters: parameters){ response in
            self.VM.myPointsStatementArray = response?.lstRewardTransJsonDetails ?? []
            print(self.VM.myPointsStatementArray.count, "countOfMyPointsStatemnet")
            DispatchQueue.main.async {
                if self.VM.myPointsStatementArray.count != 0 {
                    self.tablePointStatementTableView.isHidden = false
                    self.noDataFoundLbl.isHidden = true
                    self.tablePointStatementTableView.reloadData()
                }else{
                    self.tablePointStatementTableView.isHidden = true
                    self.noDataFoundLbl.isHidden = false
                }
                self.loaderView.isHidden = true
                self.stopLoading()
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
                self.countLbl.text = "\(self.VM1.notificationListArray.count)"
            }else{
                self.countLbl.isHidden = true
            }
            if self.VM1.notificationListArray.count != 0 {
                DispatchQueue.main.async {
                    //                    self.notificationListTableView.isHidden = false
                    //                    self.noDataFoundLbl.isHidden = true
                    //                    self.notificationListTableView.reloadData()
                }
            }else{
                //                self.noDataFoundLbl.isHidden = false
                //                self.notificationListTableView.isHidden = true
                
            }
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
extension MSP_PointStatementVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.myPointsStatementArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSP_PointSummaryTVC") as! MSP_PointSummaryTVC
        cell.selectionStyle = .none
        if self.VM.myPointsStatementArray[indexPath.row].status ?? "0" == "0"{
            cell.statusLbl.text = "- \(Double(VM.myPointsStatementArray[indexPath.row].pointBalance ?? 0))"
            cell.statusLbl.textColor = #colorLiteral(red: 0.8862745098, green: 0.09411764706, blue: 0.1176470588, alpha: 1)
        }else{
            cell.statusLbl.text = "+ \(Double(VM.myPointsStatementArray[indexPath.row].pointBalance ?? 0))"
            cell.statusLbl.textColor = #colorLiteral(red: 0.02745098039, green: 0.6745098039, blue: 0.1764705882, alpha: 1)
        }
        if self.VM.myPointsStatementArray[indexPath.row].behaviourName ?? "-" == "Bonus Points"{
            cell.infoLbl.text = "Bonus"
        }else{
            cell.infoLbl.text = VM.myPointsStatementArray[indexPath.row].behaviourName ?? "-"
        }
     
        
        let receivedDate = (VM.myPointsStatementArray[indexPath.row].jTranDate ?? "-").split(separator: " ")
        //let dateFormatted = convertDateFormater(String(receivedDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        cell.datelbl.text = "\(VM.myPointsStatementArray[indexPath.row].jTranDate ?? "-")"
        
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 170
//
//    }
    
    
    
}

extension Date {
    
    func getLast6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)
    }
    
    func getLast3Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -3, to: self)
    }
    func getLast2Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -2, to: self)
    }
    
    
    func getCurrentDate() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 0, to: self)
    }
    
    func getLast7Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)
    }
    func getLast30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -30, to: self)
    }
    func get90thStartDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -90, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 0, to: self)
        
    }
    
    
    // This Month Start
    func getThisMonthStart() -> Date? {
    let components = Calendar.current.dateComponents([.year, .month], from: self)
    return Calendar.current.date(from: components)!
}
    
    var startOfDay: Date {
           return Calendar.current.startOfDay(for: self)
       }

       var startOfMonth: Date {

           let calendar = Calendar(identifier: .gregorian)
           let components = calendar.dateComponents([.year, .month], from: self)

           return  calendar.date(from: components)!
       }

       var endOfDay: Date {
           var components = DateComponents()
           components.day = 0
           components.second = -1
           return Calendar.current.date(byAdding: components, to: startOfDay)!
       }

       var endOfMonth: Date {
           var components = DateComponents()
           components.month = 1
           components.second = -1
           return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
       }

       func isMonday() -> Bool {
           let calendar = Calendar(identifier: .gregorian)
           let components = calendar.dateComponents([.weekday], from: self)
           return components.weekday == 2
       }
    
    
    
    func getThisMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    //Last Month Start
    func getLastMonthStart() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    func get2LastMonthStart() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month -= 2
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    
    //Last Month End
    func getLastMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
//    func startOfMonth() -> Date {
//        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
//    }
//
//    func endOfMonth() -> Date {
//        return Calendar.current.date(byAdding: DateComponents(month: 1, day: 30), to: self.startOfMonth())!
//    }
    
}





