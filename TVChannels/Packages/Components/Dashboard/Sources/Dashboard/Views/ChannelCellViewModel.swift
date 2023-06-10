import UIKit

protocol ChannelCellViewModelInput {
    var number: String { get }
    var name: String { get }

    var numberColor: UIColor { get }
    var nameColor: UIColor { get }
}

protocol ChannelCellViewModelOutput {

}

typealias ChannelCellViewModelProtocol = ChannelCellViewModelInput & ChannelCellViewModelOutput

struct ChannelCellViewModel: ChannelCellViewModelInput {

    // MARK: - Public properties

    let number: String
    let name: String

    let numberColor: UIColor = .black
    let nameColor: UIColor = .black

    // MARK: - Init

    init(info: ChannelInfo) {
        self.number = String(info.channel.orderNumber)
        self.name = info.channel.callSign
    }
}

// MARK: - ChannelCellViewModelOutput

extension ChannelCellViewModel: ChannelCellViewModelOutput {

}
