import UIKit

protocol ProgramGuideViewModel {
    func didSelect()
}

extension ProgramGuideViewModel {
    func didSelect() { }
}

struct ProgramCellFactory { }

// MARK: - Public

extension ProgramCellFactory {

    func makeCell(collectionView: UICollectionView, viewModel: ProgramGuideViewModel, indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel {
        case let viewModel as TimeLineCellViewModel:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TimeLineCollectionViewCell.identifier,
                for: indexPath
            ) as! TimeLineCollectionViewCell
            cell.viewModel = viewModel
            return cell
        case let viewModel as ProgramCellViewModel:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgramCollectionViewCell.identifier,
                for: indexPath
            ) as! ProgramCollectionViewCell
            cell.viewModel = viewModel
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
