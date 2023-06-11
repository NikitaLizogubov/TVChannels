import UIKit

struct Grid {
    let numberOfItemsVertical: CGFloat
    let numberOfItemsHorizontal: CGFloat
    let lineSpacing: CGFloat
    let interitemSpacing: CGFloat
    let timeLineHeight: CGFloat
}

struct ProgramLayout {

    // MARK: - Public properties

    let grid = Grid(
        numberOfItemsVertical: 5,
        numberOfItemsHorizontal: 4,
        lineSpacing: 8,
        interitemSpacing: 8,
        timeLineHeight: 40
    )
}

// MARK: - Public

extension ProgramLayout {

    func size(bounds: CGRect, viewModel: ProgramGuideViewModel) -> CGSize {
        switch viewModel {
        case is TimeLineCellViewModel:
            return CGSize(
                width: bounds.width / grid.numberOfItemsVertical,
                height: grid.timeLineHeight
            )
        case is ProgramCellViewModel:
            return CGSize(
                width: bounds.width / grid.numberOfItemsVertical,
                height: (bounds.height / grid.numberOfItemsHorizontal) - grid.lineSpacing - grid.timeLineHeight * 0.25
            )
        default:
            return .zero
        }
    }
}
