/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ObjCatalogueDetailsForCustomer1 : Codable {
	let catalogueId : Int?
	let pointsRequired : Int?
	let pointsBalance : Int?
	let pointsRequiredToRedeem : Int?
	let redemptionType : Int?
	let catalogueName : String?
	let catalogueImage : String?

	enum CodingKeys: String, CodingKey {

		case catalogueId = "catalogueId"
		case pointsRequired = "pointsRequired"
		case pointsBalance = "pointsBalance"
		case pointsRequiredToRedeem = "pointsRequiredToRedeem"
		case redemptionType = "redemptionType"
		case catalogueName = "catalogueName"
		case catalogueImage = "catalogueImage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		catalogueId = try values.decodeIfPresent(Int.self, forKey: .catalogueId)
		pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
		pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
		pointsRequiredToRedeem = try values.decodeIfPresent(Int.self, forKey: .pointsRequiredToRedeem)
		redemptionType = try values.decodeIfPresent(Int.self, forKey: .redemptionType)
		catalogueName = try values.decodeIfPresent(String.self, forKey: .catalogueName)
		catalogueImage = try values.decodeIfPresent(String.self, forKey: .catalogueImage)
	}

}
