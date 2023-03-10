
import Foundation
struct RedemptionCategoryModels : Codable {
    let objCatalogueCategoryListJson : [ObjCatalogueCategoryListJson]?
    let responseCode : String?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case objCatalogueCategoryListJson = "objCatalogueCategoryListJson"
        case responseCode = "responseCode"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        objCatalogueCategoryListJson = try values.decodeIfPresent([ObjCatalogueCategoryListJson].self, forKey: .objCatalogueCategoryListJson)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}
