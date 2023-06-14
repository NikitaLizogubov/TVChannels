import Foundation
import DashboardTypes

struct ChannelInfo {
    let channel: Channel
    let programs: [Program]

    static func map(_ channels: [Channel], _ programs: [Program]) -> [ChannelInfo] {
        channels.map { channel in
            let programs = programs.filter { $0.recentAirTime.channelId == channel.id }

            return ChannelInfo(
                channel: channel,
                programs: programs
            )
        }
    }
}
