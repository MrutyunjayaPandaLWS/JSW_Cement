//
//  NotificationExtension.swift
//  Quba Safalta
//
//  Created by Arkmacbook on 31/03/21.
//

import Foundation

extension Notification.Name{
    static let showPopUp = Notification.Name(rawValue: "showPopUp")
    static let runCodeAgain = Notification.Name(rawValue: "runCodeAgain")
    static let removeRetailer = Notification.Name(rawValue: "removeRetailer")
    static let refreshDealerCoupon = Notification.Name(rawValue: "refreshDealerCoupon")
    static let refreshProductCatalogue = Notification.Name(rawValue: "refreshProductCatalogue")
    static let refreshSelectedProductCatalogue = Notification.Name(rawValue: "refreshSelectedProductCatalogue")
    static let sideMenuClosing = Notification.Name(rawValue: "sideMenuClosing")
    static let deleteAccount = Notification.Name(rawValue: "deleteAccount")
    static let verificationStatus = Notification.Name(rawValue: "verificationStatus")
    static let userIsActive = Notification.Name(rawValue: "userIsActive")
    static let dreamGiftRemoved = Notification.Name(rawValue: "dreamGiftRemoved")
    static let giftAddedIntoCart = Notification.Name(rawValue: "giftAddedIntoCart")
    static let removeDreamGiftDetails = Notification.Name(rawValue: "removeDreamGiftDetails")
    static let navigateToLogin = Notification.Name(rawValue: "navigateToLogin")
    static let navigateToLogin1 = Notification.Name(rawValue: "navigateToLogin1")
    static let redemptionSubmission = Notification.Name(rawValue: "redemptionSubmission")
    static let catalogueSubmission = Notification.Name(rawValue: "catalogueSubmission")
    static let dismissScreen = Notification.Name(rawValue: "dismissScreen")
    static let dismissCurrentVC = Notification.Name(rawValue: "dismissCurrentVC")
    static let querySubmission = Notification.Name(rawValue: "querySubmission")
    static let deactivatedAcc = Notification.Name(rawValue: "deactivatedAcc")
    static let sendDashboard = Notification.Name(rawValue: "sendDashboard")
    static let goToDashBoardAPI = Notification.Name(rawValue: "goToDashBoardAPI")
    static let sendToClaimStatusVC = Notification.Name(rawValue: "sendToClaimStatusVC")
    static let goToMain = Notification.Name(rawValue: "GoToMain")
    static let sendToDreamGift = Notification.Name(rawValue: "sendToDreamGift")
    static let sendToLogin = Notification.Name(rawValue: "sendToLogin")
    
    static let hitDashBoardRequest = Notification.Name(rawValue: "hitDashBoardRequest")
    static let goToDashBoard = Notification.Name(rawValue: "goToDashBoard")
    
    
}
