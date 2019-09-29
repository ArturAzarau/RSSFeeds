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
import SnapKit

final class FeedCell: BaseViewModelTableViewCell<FeedCellViewModel> {
    
    // MARK: - Properties

    let feedImageView = UIImageView()
    let feedTitleLabel = UILabel()
    let feedDescriptionLabel = UILabel()

    // MARK: - InitializableView

    override func addViews() {
        super.addViews()

        contentView.addSubview(feedImageView)
        contentView.addSubview(feedTitleLabel)
        contentView.addSubview(feedDescriptionLabel)
    }

    override func configureLayout() {
        super.configureLayout()

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

    override func configureAppearance() {
        super.configureAppearance()

        feedTitleLabel.font = .systemFont(ofSize: 21, weight: .semibold)
        feedDescriptionLabel.textColor = .darkGray
        selectionStyle = .none
        [feedTitleLabel, feedDescriptionLabel].forEach { $0.numberOfLines = 0 }
        feedImageView.contentMode = .scaleAspectFit
    }

    override func configure(with viewModel: FeedCellViewModel) {
        super.configure(with: viewModel)

        feedTitleLabel.text = viewModel.title
        feedDescriptionLabel.text = viewModel.description

        viewModel.imageDriver.drive(imageBinder).disposed(by: disposeBag)
    }

    private var imageBinder: Binder<UIImage?> {
        return Binder(self) { base, image in
            if let image = image {
                base.feedImageView.isHidden = false
                base.feedImageView.image = image
                base.feedImageView.snp.updateConstraints({ make in
                    make.size.equalTo(100)
                })
            } else {
                base.feedImageView.snp.updateConstraints({ make in
                    make.width.equalTo(0)
                })
                base.feedImageView.isHidden = true
            }
        }
    }
}
