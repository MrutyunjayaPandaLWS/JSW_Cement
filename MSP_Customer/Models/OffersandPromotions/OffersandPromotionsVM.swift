
import Foundation
struct OffersandPromotionsVM : Codable {
    let lstPromotionList : String?
    let lstPromotionUserActionDetails : String?
    let lstPromotionView : String?
    let lstPromotionJsonList : [LstPromotionJsonList]?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case lstPromotionList = "lstPromotionList"
        case lstPromotionUserActionDetails = "lstPromotionUserActionDetails"
        case lstPromotionView = "lstPromotionView"
        case lstPromotionJsonList = "lstPromotionJsonList"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lstPromotionList = try values.decodeIfPresent(String.self, forKey: .lstPromotionList)
        lstPromotionUserActionDetails = try values.decodeIfPresent(String.self, forKey: .lstPromotionUserActionDetails)
        lstPromotionView = try values.decodeIfPresent(String.self, forKey: .lstPromotionView)
        lstPromotionJsonList = try values.decodeIfPresent([LstPromotionJsonList].self, forKey: .lstPromotionJsonList)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}
