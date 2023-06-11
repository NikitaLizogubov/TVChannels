import Foundation

public struct Channel: Decodable {
    public let id: Int
    public let orderNumber: Int
    public let accessNumber: Int
    public let callSign: String

    private enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "orderNum"
        case accessNumber = "accessNum"
        case callSign = "CallSign"
    }
}
