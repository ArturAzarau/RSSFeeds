//
//  FeedCell.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class FeedCell: UITableViewCell, InitializableView {

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    let feedImageView = UIImageView()
    let feedTitleLabel = UILabel()
    let feedDescriptionLabel = UILabel()
    let labelsStackView = UIStackView()
    let mainStackView = UIStackView()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Initialization through storyboard is not supported")
    }

    // MARK: - InitializableView

    func addViews() {
        labelsStackView.addArrangedSubviews(feedTitleLabel, feedDescriptionLabel)
        mainStackView.addArrangedSubviews(feedImageView, labelsStackView)
        contentView.addSubview(mainStackView)
    }

    func configureLayout() {
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 3

        mainStackView.spacing = 3
    }
}

extension FeedCell: ConfigurableView {
    func configure(with viewModel: FeedCellViewModel) {
        disposeBag = DisposeBag()

        feedTitleLabel.text = viewModel.title
        feedDescriptionLabel.text = viewModel.title
        viewModel.imageDriver.drive(imageBinder).disposed(by: disposeBag)
    }

    private var imageBinder: Binder<UIImage?> {
        return Binder(self) { base, image in
            if let image = image {
                base.imageView?.isHidden = false
                base.imageView?.image = image
            } else {
                base.imageView?.isHidden = true
            }
        }
    }
}
