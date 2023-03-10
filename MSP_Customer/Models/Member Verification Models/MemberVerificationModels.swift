//
//  MemberVerificationModels.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 15/04/22.
//

import Foundation
struct MemberVerificationModels : Codable {
    let CheckCustomerExistancyAndVerificationJsonResult : Int?

    enum CodingKeys: String, CodingKey {

        case CheckCustomerExistancyAndVerificationJsonResult = "CheckCustomerExistancyAndVerificationJsonResult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        CheckCustomerExistancyAndVerificationJsonResult = try values.decodeIfPresent(Int.self, forKey: .CheckCustomerExistancyAndVerificationJsonResult)
    }

}
