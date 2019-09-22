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

    private let disposeBag = DisposeBag()
    private let dataFetcher = DataFetcher()
    private let viewModelsRelay = BehaviorRelay(value: [FeedCellViewModel]())

    var viewModelsDriver: Driver<[FeedCellViewModel]> {
        return viewModelsRelay.asDriver()
    }

    func startFetchingRSSFeeds() {
        guard let url = URL(string: "https://www.espn.com/espn/rss/news") else {
            fatalError("Cannot construct proper url from string")
        }

        let rssParser = RSSParser()
        rssParser.parseFeed(from: url)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] feedItems in
                let viewModels = feedItems.map { [weak self] item -> FeedCellViewModel in
                    let driver: Driver<UIImage?>
                    if let self = self, let image = item.image {
                        driver = self.dataFetcher
                            .fetchImage(for: image)
                            .map { UIImage(data: $0) }
                            .asDriver(onErrorJustReturn: nil)
                    } else {
                        driver = Single.just(nil).asDriver(onErrorJustReturn: nil)
                    }

                    return FeedCellViewModel(title: item.title, description: item.description, imageDriver: driver)
                }

                self?.viewModelsRelay.accept(viewModels)
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)


    }
}
