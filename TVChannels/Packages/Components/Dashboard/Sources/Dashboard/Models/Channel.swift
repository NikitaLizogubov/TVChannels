import Foundation

struct Channel: Decodable {
    let id: Int
    let orderNumber: Int
    let accessNumber: Int
    let callSign: String

    private enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "orderNum"
        case accessNumber = "accessNum"
        case callSign = "CallSign"
    }
}
