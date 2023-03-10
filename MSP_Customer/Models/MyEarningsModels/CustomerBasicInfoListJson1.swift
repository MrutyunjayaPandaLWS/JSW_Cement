/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CustomerBasicInfoListJson1 : Codable {
    let fullName : String?
    let email : String?
    let isActive : Bool?
    let mobile : String?
    let createdDate : String?
    let merchantID : Int?
    let row : Int?
    let totalRows : Int?
    let dob : String?
    let rewardAdj : Bool?
    let redemption : Bool?
    let referral : Bool?
    let editProfile : Bool?
    let smsToCustomer : Bool?
    let asmSeMapping : Bool?
    let customer_Type : String?
    let awardRewardId : Int?
    let creditedPoint : Double?
    let areaName : String?
    let debitedPoint : Double?
    let balance : Int?
    let invoiceNo : String?
    let enrolledDate : String?
    let pointsBalance : Int?
    let behaviourId : Int?
    let status : String?
    let verified : Int?
    let countryId : Int?
    let countryName : String?
    let verifiedTypeId : Int?
    let cityId : Int?
    let cityName : String?
    let asmUserId : Int?
    let seUserId : Int?
    let asmName : String?
    let seName : String?
    let createdById : Int?
    let createdByName : String?
    let retailerName : String?
    let salesRepresentative : String?
    let registrationStatus : String?
    let accountType : String?
    let gender : String?
    let programName : String?
    let productName : String?
    let loyaltyTempId : String?
    let giftAmount : String?
    let imageUrl : String?
    let vehicleManagement : Bool?
    let leadStatus : String?
    let districtId : Int?
    let districtName : String?
    let talukId : Int?
    let talukName : String?
    let accountNumber : String?
    let acountHolderName : String?
    let bankName : String?
    let bankBranch : String?
    let ifscCode : String?
    let walletNumber : String?
    let salesReturn : Int?
    let categoryName : String?
    let batchNo : Int?
    let trxnDate : String?
    let authorizedBy : String?
    let quantity : Double?
    let isAvailble : String?
    let isCold : String?
    let resolveDate : String?
    let approverIp : String?
    let categoryChangeName : String?
    let mappedCount : String?
    let areaId : Int?
    let transactionType : String?
    let salesPersonsName : String?
    let salesPersonsID : String?
    let partnerID : String?
    let partnerName : String?
    let assessmentCertificate : String?
    let assessmentName : String?
    let productDesc : String?
    let remarks : String?
    let sku : String?
    let pinCode : String?
    let landLine : String?
    let nationality : String?
    let tradLicence : String?
    let sapID : String?
    let customerTicketId : Int?
    let verifiedName : String?
    let ticketReferenceNumber : String?
    let departmentId : Int?
    let designationId : Int?
    let anniversary : String?
    let approvedBy : String?
    let customerCategory : String?
    let customerCategoryId : Int?
    let userOneHeader : String?
    let userTwoHeader : String?
    let requestTo : String?
    let customerTypeId : Int?
    let whatsAppMobileNumber : String?
    let workSiteLandMark : String?
    let workSiteContactPersonName : String?
    let workSitePincode : String?
    let workSiteVerificationStatus : String?
    let workSiteContactNumber : String?
    let workSiteInfoID : Int?
    let workSiteCityName : String?
    let workSiteAddress : String?
    let workSiteVerification : Int?
    let approOneName : String?
    let approTwoName : String?
    let approOneDate : String?
    let approTwoDate : String?
    let approverId : Int?
    let nominalPoints : Int?
    let redeemablePoints : Int?
    let redeemedPoints : Int?
    let locationName : String?
    let productCode : String?
    let sellingPrice : Int?
    let claimedRemarks : String?
    let dealerCode : String?

    enum CodingKeys: String, CodingKey {

        case fullName = "fullName"
        case email = "email"
        case isActive = "isActive"
        case mobile = "mobile"
        case createdDate = "createdDate"
        case merchantID = "merchantID"
        case row = "row"
        case totalRows = "totalRows"
        case dob = "dob"
        case rewardAdj = "rewardAdj"
        case redemption = "redemption"
        case referral = "referral"
        case editProfile = "editProfile"
        case smsToCustomer = "smsToCustomer"
        case asmSeMapping = "asmSeMapping"
        case customer_Type = "customer_Type"
        case awardRewardId = "awardRewardId"
        case creditedPoint = "creditedPoint"
        case areaName = "areaName"
        case debitedPoint = "debitedPoint"
        case balance = "balance"
        case invoiceNo = "invoiceNo"
        case enrolledDate = "enrolledDate"
        case pointsBalance = "pointsBalance"
        case behaviourId = "behaviourId"
        case status = "status"
        case verified = "verified"
        case countryId = "countryId"
        case countryName = "countryName"
        case verifiedTypeId = "verifiedTypeId"
        case cityId = "cityId"
        case cityName = "cityName"
        case asmUserId = "asmUserId"
        case seUserId = "seUserId"
        case asmName = "asmName"
        case seName = "seName"
        case createdById = "createdById"
        case createdByName = "createdByName"
        case retailerName = "retailerName"
        case salesRepresentative = "salesRepresentative"
        case registrationStatus = "registrationStatus"
        case accountType = "accountType"
        case gender = "gender"
        case programName = "programName"
        case productName = "productName"
        case loyaltyTempId = "loyaltyTempId"
        case giftAmount = "giftAmount"
        case imageUrl = "imageUrl"
        case vehicleManagement = "vehicleManagement"
        case leadStatus = "leadStatus"
        case districtId = "districtId"
        case districtName = "districtName"
        case talukId = "talukId"
        case talukName = "talukName"
        case accountNumber = "accountNumber"
        case acountHolderName = "acountHolderName"
        case bankName = "bankName"
        case bankBranch = "bankBranch"
        case ifscCode = "ifscCode"
        case walletNumber = "walletNumber"
        case salesReturn = "salesReturn"
        case categoryName = "categoryName"
        case batchNo = "batchNo"
        case trxnDate = "trxnDate"
        case authorizedBy = "authorizedBy"
        case quantity = "quantity"
        case isAvailble = "isAvailble"
        case isCold = "isCold"
        case resolveDate = "resolveDate"
        case approverIp = "approverIp"
        case categoryChangeName = "categoryChangeName"
        case mappedCount = "mappedCount"
        case areaId = "areaId"
        case transactionType = "transactionType"
        case salesPersonsName = "salesPersonsName"
        case salesPersonsID = "salesPersonsID"
        case partnerID = "partnerID"
        case partnerName = "partnerName"
        case assessmentCertificate = "assessmentCertificate"
        case assessmentName = "assessmentName"
        case productDesc = "productDesc"
        case remarks = "remarks"
        case sku = "sku"
        case pinCode = "pinCode"
        case landLine = "landLine"
        case nationality = "nationality"
        case tradLicence = "tradLicence"
        case sapID = "sapID"
        case customerTicketId = "customerTicketId"
        case verifiedName = "verifiedName"
        case ticketReferenceNumber = "ticketReferenceNumber"
        case departmentId = "departmentId"
        case designationId = "designationId"
        case anniversary = "anniversary"
        case approvedBy = "approvedBy"
        case customerCategory = "customerCategory"
        case customerCategoryId = "customerCategoryId"
        case userOneHeader = "userOneHeader"
        case userTwoHeader = "userTwoHeader"
        case requestTo = "requestTo"
        case customerTypeId = "customerTypeId"
        case whatsAppMobileNumber = "whatsAppMobileNumber"
        case workSiteLandMark = "workSiteLandMark"
        case workSiteContactPersonName = "workSiteContactPersonName"
        case workSitePincode = "workSitePincode"
        case workSiteVerificationStatus = "workSiteVerificationStatus"
        case workSiteContactNumber = "workSiteContactNumber"
        case workSiteInfoID = "workSiteInfoID"
        case workSiteCityName = "workSiteCityName"
        case workSiteAddress = "workSiteAddress"
        case workSiteVerification = "workSiteVerification"
        case approOneName = "approOneName"
        case approTwoName = "approTwoName"
        case approOneDate = "approOneDate"
        case approTwoDate = "approTwoDate"
        case approverId = "approverId"
        case nominalPoints = "nominalPoints"
        case redeemablePoints = "redeemablePoints"
        case redeemedPoints = "redeemedPoints"
        case locationName = "locationName"
        case productCode = "productCode"
        case sellingPrice = "sellingPrice"
        case claimedRemarks = "claimedRemarks"
        case dealerCode = "dealerCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        merchantID = try values.decodeIfPresent(Int.self, forKey: .merchantID)
        row = try values.decodeIfPresent(Int.self, forKey: .row)
        totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        rewardAdj = try values.decodeIfPresent(Bool.self, forKey: .rewardAdj)
        redemption = try values.decodeIfPresent(Bool.self, forKey: .redemption)
        referral = try values.decodeIfPresent(Bool.self, forKey: .referral)
        editProfile = try values.decodeIfPresent(Bool.self, forKey: .editProfile)
        smsToCustomer = try values.decodeIfPresent(Bool.self, forKey: .smsToCustomer)
        asmSeMapping = try values.decodeIfPresent(Bool.self, forKey: .asmSeMapping)
        customer_Type = try values.decodeIfPresent(String.self, forKey: .customer_Type)
        awardRewardId = try values.decodeIfPresent(Int.self, forKey: .awardRewardId)
        creditedPoint = try values.decodeIfPresent(Double.self, forKey: .creditedPoint)
        areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
        debitedPoint = try values.decodeIfPresent(Double.self, forKey: .debitedPoint)
        balance = try values.decodeIfPresent(Int.self, forKey: .balance)
        invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
        enrolledDate = try values.decodeIfPresent(String.self, forKey: .enrolledDate)
        pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
        behaviourId = try values.decodeIfPresent(Int.self, forKey: .behaviourId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        verified = try values.decodeIfPresent(Int.self, forKey: .verified)
        countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
        countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
        verifiedTypeId = try values.decodeIfPresent(Int.self, forKey: .verifiedTypeId)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        asmUserId = try values.decodeIfPresent(Int.self, forKey: .asmUserId)
        seUserId = try values.decodeIfPresent(Int.self, forKey: .seUserId)
        asmName = try values.decodeIfPresent(String.self, forKey: .asmName)
        seName = try values.decodeIfPresent(String.self, forKey: .seName)
        createdById = try values.decodeIfPresent(Int.self, forKey: .createdById)
        createdByName = try values.decodeIfPresent(String.self, forKey: .createdByName)
        retailerName = try values.decodeIfPresent(String.self, forKey: .retailerName)
        salesRepresentative = try values.decodeIfPresent(String.self, forKey: .salesRepresentative)
        registrationStatus = try values.decodeIfPresent(String.self, forKey: .registrationStatus)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        programName = try values.decodeIfPresent(String.self, forKey: .programName)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        loyaltyTempId = try values.decodeIfPresent(String.self, forKey: .loyaltyTempId)
        giftAmount = try values.decodeIfPresent(String.self, forKey: .giftAmount)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        vehicleManagement = try values.decodeIfPresent(Bool.self, forKey: .vehicleManagement)
        leadStatus = try values.decodeIfPresent(String.self, forKey: .leadStatus)
        districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
        districtName = try values.decodeIfPresent(String.self, forKey: .districtName)
        talukId = try values.decodeIfPresent(Int.self, forKey: .talukId)
        talukName = try values.decodeIfPresent(String.self, forKey: .talukName)
        accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
        acountHolderName = try values.decodeIfPresent(String.self, forKey: .acountHolderName)
        bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
        bankBranch = try values.decodeIfPresent(String.self, forKey: .bankBranch)
        ifscCode = try values.decodeIfPresent(String.self, forKey: .ifscCode)
        walletNumber = try values.decodeIfPresent(String.self, forKey: .walletNumber)
        salesReturn = try values.decodeIfPresent(Int.self, forKey: .salesReturn)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        batchNo = try values.decodeIfPresent(Int.self, forKey: .batchNo)
        trxnDate = try values.decodeIfPresent(String.self, forKey: .trxnDate)
        authorizedBy = try values.decodeIfPresent(String.self, forKey: .authorizedBy)
        quantity = try values.decodeIfPresent(Double.self, forKey: .quantity)
        isAvailble = try values.decodeIfPresent(String.self, forKey: .isAvailble)
        isCold = try values.decodeIfPresent(String.self, forKey: .isCold)
        resolveDate = try values.decodeIfPresent(String.self, forKey: .resolveDate)
        approverIp = try values.decodeIfPresent(String.self, forKey: .approverIp)
        categoryChangeName = try values.decodeIfPresent(String.self, forKey: .categoryChangeName)
        mappedCount = try values.decodeIfPresent(String.self, forKey: .mappedCount)
        areaId = try values.decodeIfPresent(Int.self, forKey: .areaId)
        transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType)
        salesPersonsName = try values.decodeIfPresent(String.self, forKey: .salesPersonsName)
        salesPersonsID = try values.decodeIfPresent(String.self, forKey: .salesPersonsID)
        partnerID = try values.decodeIfPresent(String.self, forKey: .partnerID)
        partnerName = try values.decodeIfPresent(String.self, forKey: .partnerName)
        assessmentCertificate = try values.decodeIfPresent(String.self, forKey: .assessmentCertificate)
        assessmentName = try values.decodeIfPresent(String.self, forKey: .assessmentName)
        productDesc = try values.decodeIfPresent(String.self, forKey: .productDesc)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        pinCode = try values.decodeIfPresent(String.self, forKey: .pinCode)
        landLine = try values.decodeIfPresent(String.self, forKey: .landLine)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        tradLicence = try values.decodeIfPresent(String.self, forKey: .tradLicence)
        sapID = try values.decodeIfPresent(String.self, forKey: .sapID)
        customerTicketId = try values.decodeIfPresent(Int.self, forKey: .customerTicketId)
        verifiedName = try values.decodeIfPresent(String.self, forKey: .verifiedName)
        ticketReferenceNumber = try values.decodeIfPresent(String.self, forKey: .ticketReferenceNumber)
        departmentId = try values.decodeIfPresent(Int.self, forKey: .departmentId)
        designationId = try values.decodeIfPresent(Int.self, forKey: .designationId)
        anniversary = try values.decodeIfPresent(String.self, forKey: .anniversary)
        approvedBy = try values.decodeIfPresent(String.self, forKey: .approvedBy)
        customerCategory = try values.decodeIfPresent(String.self, forKey: .customerCategory)
        customerCategoryId = try values.decodeIfPresent(Int.self, forKey: .customerCategoryId)
        userOneHeader = try values.decodeIfPresent(String.self, forKey: .userOneHeader)
        userTwoHeader = try values.decodeIfPresent(String.self, forKey: .userTwoHeader)
        requestTo = try values.decodeIfPresent(String.self, forKey: .requestTo)
        customerTypeId = try values.decodeIfPresent(Int.self, forKey: .customerTypeId)
        whatsAppMobileNumber = try values.decodeIfPresent(String.self, forKey: .whatsAppMobileNumber)
        workSiteLandMark = try values.decodeIfPresent(String.self, forKey: .workSiteLandMark)
        workSiteContactPersonName = try values.decodeIfPresent(String.self, forKey: .workSiteContactPersonName)
        workSitePincode = try values.decodeIfPresent(String.self, forKey: .workSitePincode)
        workSiteVerificationStatus = try values.decodeIfPresent(String.self, forKey: .workSiteVerificationStatus)
        workSiteContactNumber = try values.decodeIfPresent(String.self, forKey: .workSiteContactNumber)
        workSiteInfoID = try values.decodeIfPresent(Int.self, forKey: .workSiteInfoID)
        workSiteCityName = try values.decodeIfPresent(String.self, forKey: .workSiteCityName)
        workSiteAddress = try values.decodeIfPresent(String.self, forKey: .workSiteAddress)
        workSiteVerification = try values.decodeIfPresent(Int.self, forKey: .workSiteVerification)
        approOneName = try values.decodeIfPresent(String.self, forKey: .approOneName)
        approTwoName = try values.decodeIfPresent(String.self, forKey: .approTwoName)
        approOneDate = try values.decodeIfPresent(String.self, forKey: .approOneDate)
        approTwoDate = try values.decodeIfPresent(String.self, forKey: .approTwoDate)
        approverId = try values.decodeIfPresent(Int.self, forKey: .approverId)
        nominalPoints = try values.decodeIfPresent(Int.self, forKey: .nominalPoints)
        redeemablePoints = try values.decodeIfPresent(Int.self, forKey: .redeemablePoints)
        redeemedPoints = try values.decodeIfPresent(Int.self, forKey: .redeemedPoints)
        locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
        productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
        sellingPrice = try values.decodeIfPresent(Int.self, forKey: .sellingPrice)
        claimedRemarks = try values.decodeIfPresent(String.self, forKey: .claimedRemarks)
        dealerCode = try values.decodeIfPresent(String.self, forKey: .dealerCode)
    }

}
