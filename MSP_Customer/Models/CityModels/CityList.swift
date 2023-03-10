/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CityList : Codable {
	let row : Int?
	let countryCode : String?
	let countryId : Int?
	let countryName : String?
	let countryType : String?
	let isActive : Bool?
	let mobilePrefix : String?
	let stateCode : String?
	let stateId : Int?
	let stateName : String?
	let cityCode : String?
	let cityId : Int?
	let cityName : String?

	enum CodingKeys: String, CodingKey {

		case row = "row"
		case countryCode = "countryCode"
		case countryId = "countryId"
		case countryName = "countryName"
		case countryType = "countryType"
		case isActive = "isActive"
		case mobilePrefix = "mobilePrefix"
		case stateCode = "stateCode"
		case stateId = "stateId"
		case stateName = "stateName"
		case cityCode = "cityCode"
		case cityId = "cityId"
		case cityName = "cityName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		row = try values.decodeIfPresent(Int.self, forKey: .row)
		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		countryType = try values.decodeIfPresent(String.self, forKey: .countryType)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		mobilePrefix = try values.decodeIfPresent(String.self, forKey: .mobilePrefix)
		stateCode = try values.decodeIfPresent(String.self, forKey: .stateCode)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		cityCode = try values.decodeIfPresent(String.self, forKey: .cityCode)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
	}

}
