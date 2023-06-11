import UIKit

public extension UICollectionView {

    func register(cellTypes: UICollectionViewCell.Type..., bundle: Bundle) {
        cellTypes.forEach {
            register($0.loadFromNib(bundle: bundle), forCellWithReuseIdentifier: $0.identifier)
        }
    }
}
