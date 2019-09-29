//
//  RSSArticleViewModel.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 29/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

struct RSSArticleViewModel {

    // MARK: - Properties

    let title: String?
    let text: String?

    // MARK: Init

    init(title: String?, text: String?) {
        self.title = title
        self.text = text
    }
}
