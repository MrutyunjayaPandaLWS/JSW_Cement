//
//  MyCommonFunctionalUtilities.swift
//  OZFoodHunter
//
//  Created by Siba Prasad Hota on 01/06/17.
//  Copyright © 2017 WeMakeAppz. All rights reserved.
//

import UIKit

class MyCommonFunctionalUtilities: NSObject {
   
    // Below code to calculate if the Data taken from DB And Then converted to Modal Objects.

    class func isInternetCallTheApi() -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            return false
        case .online(.wwan):
            return true
        case .online(.wiFi):
            return true
        }
    }
    
}


extension Notification.Name{
    static let selectGeneralCustomerTypeType = Notification.Name(rawValue: "selectGeneralCustomerTypeType")
    static let selectGeneralLanguageTypeType = Notification.Name(rawValue: "selectGeneralLanguageTypeType")
    static let selectGeneralgradeType = Notification.Name(rawValue: "selectGeneralgradeType")
    static let selectGeneralTitleType = Notification.Name(rawValue: "selectGeneralTitleType")
    static let selectGeneralBranchType = Notification.Name(rawValue: "selectGeneralBranchType")
     static let selectGeneralLocationType = Notification.Name(rawValue: "selectGeneralLocationType")
    static let selectAddressIdentificationType = Notification.Name(rawValue: "selectAddressIdentificationType")
    static let selectIdentityIdentificationType = Notification.Name(rawValue: "selectIdentityIdentificationType")
    static let selectcountryType = Notification.Name(rawValue: "selectcountryType")
    static let selectstateType = Notification.Name(rawValue: "selectstateType")
    static let selectcityType = Notification.Name(rawValue: "selectcityType")
    static let selectfirmType = Notification.Name(rawValue: "selectfirmType")
    static let selectjobType = Notification.Name(rawValue: "selectjobType")
    static let selectpcountryType = Notification.Name(rawValue: "selectpcountryType")
    static let selectpstateType = Notification.Name(rawValue: "selectpstateType")
    static let selectpcityType = Notification.Name(rawValue: "selectpcityType")
    static let selectpncountryType = Notification.Name(rawValue: "selectpncountryType")
    static let selectpnstateType = Notification.Name(rawValue: "selectpnstateType")
    static let selectpncityType = Notification.Name(rawValue: "selectpncityType")
    static let selectprofessionType = Notification.Name(rawValue: "selectprofessionType")
    static let selectincomeType = Notification.Name(rawValue: "selectincomeType")
    static let selectagegroupType = Notification.Name(rawValue: "selectagegroupType")


}
