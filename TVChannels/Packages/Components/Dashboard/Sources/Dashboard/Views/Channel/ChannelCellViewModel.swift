import UIKit
import DashboardTypes

protocol ChannelCellViewModelInput {
    var number: String { get }
    var name: String { get }

    var numberColor: UIColor { get }
    var nameColor: UIColor { get }
}

typealias ChannelCellViewModelProtocol = ChannelCellViewModelInput

struct ChannelCellViewModel: ChannelCellViewModelInput {

    // MARK: - Public properties

    let number: String
    let name: String

    let numberColor: UIColor = .black
    let nameColor: UIColor = .black

    // MARK: - Init

    init(channel: Channel) {
        self.number = String(channel.orderNumber)
        self.name = channel.callSign
    }
}
