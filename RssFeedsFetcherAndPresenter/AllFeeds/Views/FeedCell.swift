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

    static let reuseIdentifier = "FeedCell"

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
        contentView.addSubview(feedImageView)
        contentView.addSubview(feedTitleLabel)
        contentView.addSubview(feedDescriptionLabel)
    }

    func configureLayout() {
        feedImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.leading.top.equalToSuperview().inset(20)
        }

        feedTitleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(feedImageView.snp.trailing).offset(20)
        }

        feedDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(feedTitleLabel)
            make.top.equalTo(feedTitleLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
        }

        feedDescriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        feedTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    func configureAppearance() {
        selectionStyle = .none
        [feedTitleLabel, feedDescriptionLabel].forEach { $0.numberOfLines = 0 }
    }
}

extension FeedCell: ConfigurableView {
    func configure(with viewModel: FeedCellViewModel) {
        disposeBag = DisposeBag()

        feedTitleLabel.text = viewModel.title
        feedDescriptionLabel.text = viewModel.description

        viewModel.imageDriver.drive(imageBinder).disposed(by: disposeBag)
    }

    private var imageBinder: Binder<UIImage?> {
        return Binder(self) { base, image in
            if let image = image {
                base.imageView?.isHidden = false
                base.feedImageView.image = image
            } else {
                base.imageView?.isHidden = true
            }
        }
    }
}
