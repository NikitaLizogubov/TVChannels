import Foundation

public struct Program: Decodable {
    public let name: String
    public let length: Int
    public let startTime: Date
    public let recentAirTime: RecentAirTime
}
