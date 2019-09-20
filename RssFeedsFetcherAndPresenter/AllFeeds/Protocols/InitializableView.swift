//
//  InitializableView.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

protocol InitializableView: UIView {
    func addViews()
    func bindViews()
    func configureAppearance()
    func localize()
    func configureLayout()
    func initializeView()
}

extension InitializableView {
    func initializeView() {
        addViews()
        bindViews()
        configureAppearance()
        localize()
        bindViews()
    }

    func addViews() {}
    func bindViews() {}
    func configureAppearance() {}
    func localize() {}
    func configureLayout() {}
}
