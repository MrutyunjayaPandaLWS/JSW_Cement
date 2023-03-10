/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstTermsAndCondition : Codable {
	let termsAndConditionsId : Int?
	let tcName : String?
	let html : String?
	let color : String?
	let statusName : String?
	let fileName : String?
	let createDate : String?
	let segmentId : Int?
	let segmentType : String?
	let segmentName : String?
	let wefDate : String?
	let isActive : Bool?
	let languageId : Int?
	let language : String?
	let token : String?
	let actorId : Int?
	let actorRole : String?
	let actionType : Int?

	enum CodingKeys: String, CodingKey {

		case termsAndConditionsId = "termsAndConditionsId"
		case tcName = "tcName"
		case html = "html"
		case color = "color"
		case statusName = "statusName"
		case fileName = "fileName"
		case createDate = "createDate"
		case segmentId = "segmentId"
		case segmentType = "segmentType"
		case segmentName = "segmentName"
		case wefDate = "wefDate"
		case isActive = "isActive"
		case languageId = "languageId"
		case language = "language"
		case token = "token"
		case actorId = "actorId"
		case actorRole = "actorRole"
		case actionType = "actionType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		termsAndConditionsId = try values.decodeIfPresent(Int.self, forKey: .termsAndConditionsId)
		tcName = try values.decodeIfPresent(String.self, forKey: .tcName)
		html = try values.decodeIfPresent(String.self, forKey: .html)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		statusName = try values.decodeIfPresent(String.self, forKey: .statusName)
		fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
		createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
		segmentId = try values.decodeIfPresent(Int.self, forKey: .segmentId)
		segmentType = try values.decodeIfPresent(String.self, forKey: .segmentType)
		segmentName = try values.decodeIfPresent(String.self, forKey: .segmentName)
		wefDate = try values.decodeIfPresent(String.self, forKey: .wefDate)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		languageId = try values.decodeIfPresent(Int.self, forKey: .languageId)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
	}

}