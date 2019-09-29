//
//  LoaderView.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 30/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import SnapKit

final class LoaderView: UIView, InitializableView {

    // MARK: - Properties

    let spinner = UIActivityIndicatorView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init with storyboard is not supported")
    }

    func addViews() {
        addSubview(spinner)
    }

    func configureAppearance() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        spinner.startAnimating()
    }

    func configureLayout() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
