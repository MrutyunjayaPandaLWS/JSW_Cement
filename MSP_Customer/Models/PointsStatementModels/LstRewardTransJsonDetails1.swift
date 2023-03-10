/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstRewardTransJsonDetails1 : Codable {
	let invoiceNo : String?
	let tranDate : String?
	let jTranDate : String?
	let amount : Double?
	let rewardPoints : Double?
	let merchantName : String?
	let loyaltyId : String?
	let currencyName : String?
	let locationName : String?
	let merchantID : Int?
	let transactionType : String?
	let status : String?
	let remarks : String?
	let ltyBehaviourId : Int?
	let isNotionalId : Int?
	let partyName : String?
	let totalRows : Int?
	let memberName : String?
	let bonusName : String?
	let cashierName : String?
	let prodCode : String?
	let prodName : String?
	let brandName : String?
	let locationID : Int?
	let vendorName : String?
	let createdBy : String?
	let processDateTime : String?
	let quantity : Int?
	let categoryName : String?
	let serialNumber : String?
	let behaviorId : Int?
	let pointsGiftedBy : String?
	let expairyOnDate : String?
	let pointBalance : Double?
	let skuName : String?
	let claimApproveDate : String?
	let behaviourName : String?
	let totalPointDebited : Int?
	let totalPointCredited : Int?
	let pointDebited : Int?
	let pointCredited : Int?

	enum CodingKeys: String, CodingKey {

		case invoiceNo = "invoiceNo"
		case tranDate = "tranDate"
		case jTranDate = "jTranDate"
		case amount = "amount"
		case rewardPoints = "rewardPoints"
		case merchantName = "merchantName"
		case loyaltyId = "loyaltyId"
		case currencyName = "currencyName"
		case locationName = "locationName"
		case merchantID = "merchantID"
		case transactionType = "transactionType"
		case status = "status"
		case remarks = "remarks"
		case ltyBehaviourId = "ltyBehaviourId"
		case isNotionalId = "isNotionalId"
		case partyName = "partyName"
		case totalRows = "totalRows"
		case memberName = "memberName"
		case bonusName = "bonusName"
		case cashierName = "cashierName"
		case prodCode = "prodCode"
		case prodName = "prodName"
		case brandName = "brandName"
		case locationID = "locationID"
		case vendorName = "vendorName"
		case createdBy = "createdBy"
		case processDateTime = "processDateTime"
		case quantity = "quantity"
		case categoryName = "categoryName"
		case serialNumber = "serialNumber"
		case behaviorId = "behaviorId"
		case pointsGiftedBy = "pointsGiftedBy"
		case expairyOnDate = "expairyOnDate"
		case pointBalance = "pointBalance"
		case skuName = "skuName"
		case claimApproveDate = "claimApproveDate"
		case behaviourName = "behaviourName"
		case totalPointDebited = "totalPointDebited"
		case totalPointCredited = "totalPointCredited"
		case pointDebited = "pointDebited"
		case pointCredited = "pointCredited"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
		tranDate = try values.decodeIfPresent(String.self, forKey: .tranDate)
		jTranDate = try values.decodeIfPresent(String.self, forKey: .jTranDate)
		amount = try values.decodeIfPresent(Double.self, forKey: .amount)
		rewardPoints = try values.decodeIfPresent(Double.self, forKey: .rewardPoints)
		merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		currencyName = try values.decodeIfPresent(String.self, forKey: .currencyName)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		merchantID = try values.decodeIfPresent(Int.self, forKey: .merchantID)
		transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		ltyBehaviourId = try values.decodeIfPresent(Int.self, forKey: .ltyBehaviourId)
		isNotionalId = try values.decodeIfPresent(Int.self, forKey: .isNotionalId)
		partyName = try values.decodeIfPresent(String.self, forKey: .partyName)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		bonusName = try values.decodeIfPresent(String.self, forKey: .bonusName)
		cashierName = try values.decodeIfPresent(String.self, forKey: .cashierName)
		prodCode = try values.decodeIfPresent(String.self, forKey: .prodCode)
		prodName = try values.decodeIfPresent(String.self, forKey: .prodName)
		brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
		locationID = try values.decodeIfPresent(Int.self, forKey: .locationID)
		vendorName = try values.decodeIfPresent(String.self, forKey: .vendorName)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		processDateTime = try values.decodeIfPresent(String.self, forKey: .processDateTime)
		quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		serialNumber = try values.decodeIfPresent(String.self, forKey: .serialNumber)
		behaviorId = try values.decodeIfPresent(Int.self, forKey: .behaviorId)
		pointsGiftedBy = try values.decodeIfPresent(String.self, forKey: .pointsGiftedBy)
		expairyOnDate = try values.decodeIfPresent(String.self, forKey: .expairyOnDate)
		pointBalance = try values.decodeIfPresent(Double.self, forKey: .pointBalance)
		skuName = try values.decodeIfPresent(String.self, forKey: .skuName)
		claimApproveDate = try values.decodeIfPresent(String.self, forKey: .claimApproveDate)
		behaviourName = try values.decodeIfPresent(String.self, forKey: .behaviourName)
		totalPointDebited = try values.decodeIfPresent(Int.self, forKey: .totalPointDebited)
		totalPointCredited = try values.decodeIfPresent(Int.self, forKey: .totalPointCredited)
		pointDebited = try values.decodeIfPresent(Int.self, forKey: .pointDebited)
		pointCredited = try values.decodeIfPresent(Int.self, forKey: .pointCredited)
	}

}
