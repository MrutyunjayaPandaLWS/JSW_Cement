

import Foundation
struct MyDreamGiftModels : Codable {
    let lstDreamGift : [LstDreamGift]?

    enum CodingKeys: String, CodingKey {

        case lstDreamGift = "lstDreamGift"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lstDreamGift = try values.decodeIfPresent([LstDreamGift].self, forKey: .lstDreamGift)
    }

}
