//
//  ForgotPasswordModels.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 15/04/22.
//

import Foundation
struct ForgotPasswordModels : Codable {
    let forgotPasswordMobileAppResult : Bool?

    enum CodingKeys: String, CodingKey {

        case forgotPasswordMobileAppResult = "forgotPasswordMobileAppResult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        forgotPasswordMobileAppResult = try values.decodeIfPresent(Bool.self, forKey: .forgotPasswordMobileAppResult)
    }

}
