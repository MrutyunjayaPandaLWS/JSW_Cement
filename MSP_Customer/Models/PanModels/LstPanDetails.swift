/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstPanDetails : Codable {
	let dOB : String?
	let isVerified : String?
	let modifiedBy : Int?
	let modifiedDate : String?
	let panId : String?
	let panImage : String?
	let panName : String?
	let result : String?
	let status : String?
	let verifiedBy : String?
	let verifiedStatus : String?
	let code : Int?
	let data : String?
	let timestamp : Int?
	let transaction_id : String?

	enum CodingKeys: String, CodingKey {

		case dOB = "DOB"
		case isVerified = "IsVerified"
		case modifiedBy = "ModifiedBy"
		case modifiedDate = "ModifiedDate"
		case panId = "PanId"
		case panImage = "PanImage"
		case panName = "PanName"
		case result = "Result"
		case status = "Status"
		case verifiedBy = "VerifiedBy"
		case verifiedStatus = "VerifiedStatus"
		case code = "code"
		case data = "data"
		case timestamp = "timestamp"
		case transaction_id = "transaction_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dOB = try values.decodeIfPresent(String.self, forKey: .dOB)
		isVerified = try values.decodeIfPresent(String.self, forKey: .isVerified)
		modifiedBy = try values.decodeIfPresent(Int.self, forKey: .modifiedBy)
		modifiedDate = try values.decodeIfPresent(String.self, forKey: .modifiedDate)
		panId = try values.decodeIfPresent(String.self, forKey: .panId)
		panImage = try values.decodeIfPresent(String.self, forKey: .panImage)
		panName = try values.decodeIfPresent(String.self, forKey: .panName)
		result = try values.decodeIfPresent(String.self, forKey: .result)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		verifiedBy = try values.decodeIfPresent(String.self, forKey: .verifiedBy)
		verifiedStatus = try values.decodeIfPresent(String.self, forKey: .verifiedStatus)
		code = try values.decodeIfPresent(Int.self, forKey: .code)
		data = try values.decodeIfPresent(String.self, forKey: .data)
		timestamp = try values.decodeIfPresent(Int.self, forKey: .timestamp)
		transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
	}

}