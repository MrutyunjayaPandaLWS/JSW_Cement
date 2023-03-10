/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstInfluencerClaimDetailsAPI : Codable {
    let userName : String?
    let monthName : String?
    let dealerName : String?
    let tierName : String?
    let dealerBilled : Double?
    let mappedDealer : Int?
    let dealerCode : String?
    let mappedInfluencers : Int?
    let influencersClaimed : Double?
    let volumeClaimed : Double?
    let totalCount : Int?
    let approvedQty : Double?
    let customerTypeID : Int?
    let customerTeirID : Int?
    let rejectedQty : Double?
    let pendingQty : Double?
    let volume : String?
    let customerType : String?
    let currentTeir : String?
    let previousTeir : String?
    let date : String?
    let fromDate : String?
    let toDate : String?

    enum CodingKeys: String, CodingKey {

        case userName = "userName"
        case monthName = "monthName"
        case dealerName = "dealerName"
        case tierName = "tierName"
        case dealerBilled = "dealerBilled"
        case mappedDealer = "mappedDealer"
        case dealerCode = "dealerCode"
        case mappedInfluencers = "mappedInfluencers"
        case influencersClaimed = "influencersClaimed"
        case volumeClaimed = "volumeClaimed"
        case totalCount = "totalCount"
        case approvedQty = "approvedQty"
        case customerTypeID = "customerTypeID"
        case customerTeirID = "customerTeirID"
        case rejectedQty = "rejectedQty"
        case pendingQty = "pendingQty"
        case volume = "volume"
        case customerType = "customerType"
        case currentTeir = "currentTeir"
        case previousTeir = "previousTeir"
        case date = "date"
        case fromDate = "fromDate"
        case toDate = "toDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        monthName = try values.decodeIfPresent(String.self, forKey: .monthName)
        dealerName = try values.decodeIfPresent(String.self, forKey: .dealerName)
        tierName = try values.decodeIfPresent(String.self, forKey: .tierName)
        dealerBilled = try values.decodeIfPresent(Double.self, forKey: .dealerBilled)
        mappedDealer = try values.decodeIfPresent(Int.self, forKey: .mappedDealer)
        dealerCode = try values.decodeIfPresent(String.self, forKey: .dealerCode)
        mappedInfluencers = try values.decodeIfPresent(Int.self, forKey: .mappedInfluencers)
        influencersClaimed = try values.decodeIfPresent(Double.self, forKey: .influencersClaimed)
        volumeClaimed = try values.decodeIfPresent(Double.self, forKey: .volumeClaimed)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        approvedQty = try values.decodeIfPresent(Double.self, forKey: .approvedQty)
        customerTypeID = try values.decodeIfPresent(Int.self, forKey: .customerTypeID)
        customerTeirID = try values.decodeIfPresent(Int.self, forKey: .customerTeirID)
        rejectedQty = try values.decodeIfPresent(Double.self, forKey: .rejectedQty)
        pendingQty = try values.decodeIfPresent(Double.self, forKey: .pendingQty)
        volume = try values.decodeIfPresent(String.self, forKey: .volume)
        customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
        currentTeir = try values.decodeIfPresent(String.self, forKey: .currentTeir)
        previousTeir = try values.decodeIfPresent(String.self, forKey: .previousTeir)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        fromDate = try values.decodeIfPresent(String.self, forKey: .fromDate)
        toDate = try values.decodeIfPresent(String.self, forKey: .toDate)
    }

}
