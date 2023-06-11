import Foundation

public struct RecentAirTime: Decodable {
    public let id: Int
    public let channelId: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case channelId = "channelID"
    }
}
