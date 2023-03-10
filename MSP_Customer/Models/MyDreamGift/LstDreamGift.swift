/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstDreamGift : Codable {
    let dreamGiftName : String?
    let pointsRequired : Int?
    let jDesiredDate : String?
    let loyaltyID : String?
    let dreamGiftDescription : String?
    let giftImage : String?
    let giftStatusId : Int?
    let jCreatedDate : String?
    let contractorName : String?
    let mobile : String?
    let address : String?
    let pointsBalance : Int?
    let role : String?
    let totRow : Int?
    let dreamGiftId : Int?
    let giftType : String?
    let avgEarningPoints : Int?
    let expectedDate : String?
    let earlyExpectedPoints : Int?
    let earlyExpectedDate : String?
    let lateExpectedPoints : Int?
    let lateExpectedDate : String?
    let status : String?
    let remark : String?
    let tdsPoints : Double?
    let is_Redeemable : Int?
    let token : String?
    let actorId : Int?
    let isActive : Bool?
    let actorRole : String?
    let actionType : Int?

    enum CodingKeys: String, CodingKey {

        case dreamGiftName = "dreamGiftName"
        case pointsRequired = "pointsRequired"
        case jDesiredDate = "jDesiredDate"
        case loyaltyID = "loyaltyID"
        case dreamGiftDescription = "dreamGiftDescription"
        case giftImage = "giftImage"
        case giftStatusId = "giftStatusId"
        case jCreatedDate = "jCreatedDate"
        case contractorName = "contractorName"
        case mobile = "mobile"
        case address = "address"
        case pointsBalance = "pointsBalance"
        case role = "role"
        case totRow = "totRow"
        case dreamGiftId = "dreamGiftId"
        case giftType = "giftType"
        case avgEarningPoints = "avgEarningPoints"
        case expectedDate = "expectedDate"
        case earlyExpectedPoints = "earlyExpectedPoints"
        case earlyExpectedDate = "earlyExpectedDate"
        case lateExpectedPoints = "lateExpectedPoints"
        case lateExpectedDate = "lateExpectedDate"
        case status = "status"
        case remark = "remark"
        case tdsPoints = "tdsPoints"
        case is_Redeemable = "is_Redeemable"
        case token = "token"
        case actorId = "actorId"
        case isActive = "isActive"
        case actorRole = "actorRole"
        case actionType = "actionType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dreamGiftName = try values.decodeIfPresent(String.self, forKey: .dreamGiftName)
        pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
        jDesiredDate = try values.decodeIfPresent(String.self, forKey: .jDesiredDate)
        loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
        dreamGiftDescription = try values.decodeIfPresent(String.self, forKey: .dreamGiftDescription)
        giftImage = try values.decodeIfPresent(String.self, forKey: .giftImage)
        giftStatusId = try values.decodeIfPresent(Int.self, forKey: .giftStatusId)
        jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
        contractorName = try values.decodeIfPresent(String.self, forKey: .contractorName)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        totRow = try values.decodeIfPresent(Int.self, forKey: .totRow)
        dreamGiftId = try values.decodeIfPresent(Int.self, forKey: .dreamGiftId)
        giftType = try values.decodeIfPresent(String.self, forKey: .giftType)
        avgEarningPoints = try values.decodeIfPresent(Int.self, forKey: .avgEarningPoints)
        expectedDate = try values.decodeIfPresent(String.self, forKey: .expectedDate)
        earlyExpectedPoints = try values.decodeIfPresent(Int.self, forKey: .earlyExpectedPoints)
        earlyExpectedDate = try values.decodeIfPresent(String.self, forKey: .earlyExpectedDate)
        lateExpectedPoints = try values.decodeIfPresent(Int.self, forKey: .lateExpectedPoints)
        lateExpectedDate = try values.decodeIfPresent(String.self, forKey: .lateExpectedDate)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        remark = try values.decodeIfPresent(String.self, forKey: .remark)
        tdsPoints = try values.decodeIfPresent(Double.self, forKey: .tdsPoints)
        is_Redeemable = try values.decodeIfPresent(Int.self, forKey: .is_Redeemable)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
    }

}
