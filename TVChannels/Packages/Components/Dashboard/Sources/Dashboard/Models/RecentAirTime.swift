import Foundation

struct RecentAirTime: Decodable {
    let id: Int
    let channelId: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case channelId = "channelID"
    }
}
