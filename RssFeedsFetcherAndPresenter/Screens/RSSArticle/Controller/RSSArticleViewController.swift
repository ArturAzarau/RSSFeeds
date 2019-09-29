//
//  RSSArticleViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 29/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

final class RSSArticleViewController: BaseViewController<RSSArticleViewModel, UITextView> {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureText()
    }

    // MARK: - Helpers

    private func configureText() {
        title = viewModel.title
        customView.attributedText = viewModel.text
    }
}
