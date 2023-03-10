
import Foundation
struct AddToCartModels : Codable {
    let totalCartCatalogue : Int?
    let availabelCoupons : Int?
    let catalogueSaveCartDetailListResponse : String?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case totalCartCatalogue = "totalCartCatalogue"
        case availabelCoupons = "availabelCoupons"
        case catalogueSaveCartDetailListResponse = "catalogueSaveCartDetailListResponse"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCartCatalogue = try values.decodeIfPresent(Int.self, forKey: .totalCartCatalogue)
        availabelCoupons = try values.decodeIfPresent(Int.self, forKey: .availabelCoupons)
        catalogueSaveCartDetailListResponse = try values.decodeIfPresent(String.self, forKey: .catalogueSaveCartDetailListResponse)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}
