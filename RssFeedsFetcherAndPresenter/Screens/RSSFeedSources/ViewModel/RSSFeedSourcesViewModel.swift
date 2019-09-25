//
//  RSSFeedSourcesViewModel.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import RxSwift
import RxCocoa

final class RSSFeedSourcesViewModel {

    // MARK: - Properties

    private let rssSourcesRelay = BehaviorRelay(value: [String]())

    var rssSourcesDriver: Driver<[String]> {
        return rssSourcesRelay.asDriver(onErrorDriveWith: .empty())
    }

    // MARK: - Init

    init(rssSources: [String]) {
        rssSourcesRelay.accept(rssSources)
    }
}
