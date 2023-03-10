


import Foundation
struct ObjHelpTopicList : Codable {
    let helpTopicId : Int?
    let helpTopicName : String?
    let iS_ACTIVE : Bool?
    let escalationInHours : Int?
    let createDate : String?
    let type : Int?
    let subHelpTopicId : Int?
    let subHelpTopicName : String?
    let customerView : Bool?

    enum CodingKeys: String, CodingKey {

        case helpTopicId = "helpTopicId"
        case helpTopicName = "helpTopicName"
        case iS_ACTIVE = "iS_ACTIVE"
        case escalationInHours = "escalationInHours"
        case createDate = "createDate"
        case type = "type"
        case subHelpTopicId = "subHelpTopicId"
        case subHelpTopicName = "subHelpTopicName"
        case customerView = "customerView"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        helpTopicId = try values.decodeIfPresent(Int.self, forKey: .helpTopicId)
        helpTopicName = try values.decodeIfPresent(String.self, forKey: .helpTopicName)
        iS_ACTIVE = try values.decodeIfPresent(Bool.self, forKey: .iS_ACTIVE)
        escalationInHours = try values.decodeIfPresent(Int.self, forKey: .escalationInHours)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        subHelpTopicId = try values.decodeIfPresent(Int.self, forKey: .subHelpTopicId)
        subHelpTopicName = try values.decodeIfPresent(String.self, forKey: .subHelpTopicName)
        customerView = try values.decodeIfPresent(Bool.self, forKey: .customerView)
    }

}
