//
//  AllFeedsViewModel.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class AllFeedsViewModel {

    // MARK: - Inner Types

    private let dataFetcher = DataFetcher()
    private let viewModelsRelay = PublishRelay<[FeedCellViewModel]>()

    var viewModelsObservable: Observable<[FeedCellViewModel]> {
        return viewModelsRelay.asObservable()
    }

    func startFetchingRSSFeeds() {
        
    }
}
