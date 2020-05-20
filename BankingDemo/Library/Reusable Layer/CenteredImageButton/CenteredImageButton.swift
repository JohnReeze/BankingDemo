//
//  CenteredImageButton.swift
//  BankingDemo
//

import UIKit

struct CenteredImageButtonViewModel {

    // MARK: - Public Properties

    let title: String
    let icon: UIImage
    let font: UIFont
    let buttonSize: CGSize
    let imageSize: CGSize
    let imageBottomPadding: CGFloat
    let imageTopPadding: CGFloat

    // MARK: - Initialization

    init(title: String,
         icon: UIImage,
         font: UIFont,
         buttonSize: CGSize,
         imageSize: CGSize,
         imageBottomPadding: CGFloat = 0,
         imageTopPadding: CGFloat = 10) {
        self.title = title
        self.icon = icon
        self.font = font
        self.buttonSize = buttonSize
        self.imageSize = imageSize
        self.imageBottomPadding = imageBottomPadding
        self.imageTopPadding = imageTopPadding
    }

}

final class CenteredImageButton: UIButton {

    // MARK: - Private Properties

    private var viewModel: CenteredImageButtonViewModel?
    private var textHeight: CGFloat {
        guard let viewModel = viewModel else {
            return 0.0
        }
        return viewModel.title.height(withConstrainedWidth: viewModel.buttonSize.width,
                                      font: viewModel.font)
    }

    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = UIColor.black.withAlphaComponent(self.isHighlighted ? 0.1 : 0.0)
        }
    }

    // MARK: - Initialization

    init(viewModel: CenteredImageButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods

    func configure(with viewModel: CenteredImageButtonViewModel) {
        self.viewModel = viewModel
        configure()
    }

    // MARK: - UIButton

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        let padding = viewModel?.imageBottomPadding ?? 0.0
        return CGRect(x: 0,
                      y: contentRect.height - (contentRect.height - padding - imageRect.size.height - titleRect.size.height) / 2 - titleRect.size.height,
                      width: contentRect.width,
                      height: textHeight)
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = super.imageRect(forContentRect: contentRect)

        return CGRect(x: contentRect.width / 2.0 - imageRect.width / 2.0,
                      y: viewModel?.imageTopPadding ?? 0,
                      width: imageRect.width,
                      height: imageRect.height)
    }

}

// MARK: - Configuration

private extension CenteredImageButton {

    func configure() {
        let buttonSize = viewModel?.buttonSize ?? .zero
        setTitle(viewModel?.title, for: .normal)
        setImage(viewModel?.icon, for: .normal)
        frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height)
        contentVerticalAlignment = .center
        contentHorizontalAlignment = .center
        titleLabel?.font = viewModel?.font
        titleLabel?.numberOfLines = 2
        titleLabel?.textAlignment = .center
        imageView?.frame.size = viewModel?.imageSize ?? .zero
    }

}
