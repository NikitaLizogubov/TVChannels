import Foundation

struct Program: Decodable {
    let name: String
    let length: Int
    let startTime: Date
    let recentAirTime: RecentAirTime
}
