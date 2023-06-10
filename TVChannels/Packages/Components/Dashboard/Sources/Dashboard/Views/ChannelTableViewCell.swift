//
//  ChannelTableViewCell.swift
//  
//
//  Created by iuada110 on 10.06.2023.
//

import UIKit

final class ChannelTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    // MARK: - Public properties

    var viewModel: ChannelCellViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }

    // MARK: - Private methods

    private func bindViewModel() {
        guard let viewModel else { return }

        numberLabel.text = viewModel.number
        nameLabel.text = viewModel.name

        numberLabel.textColor = viewModel.numberColor
        nameLabel.textColor = viewModel.nameColor
    }

}
