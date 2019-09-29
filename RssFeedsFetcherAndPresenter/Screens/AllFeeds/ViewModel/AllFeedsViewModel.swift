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
import RxDataSources
import FeedKit

final class AllFeedsViewModel {

    // MARK: - Inner Types

    let storage = RSSFeedsStorage()
    private let disposeBag = DisposeBag()
    private let dataFetcher = DataFetcher()
    private let viewModelsRelay = BehaviorRelay(value: [SectionOfCustomData]())
    private let dataSourceHolder = TableViewDataSourceHolder()
    private(set) var rssItems = [RSSFeedItem]()

    var viewModelsDriver: Driver<[SectionOfCustomData]> {
        return viewModelsRelay.asDriver()
    }

    var tableViewDataSource: RxTableViewSectionedReloadDataSource<SectionOfCustomData> {
        return dataSourceHolder.tableViewDataSource
    }

    func startFetchingRSSFeeds(for stringURL: String = "https://www.espn.com/espn/rss/news") {
        guard let url = URL(string: stringURL) else {
            fatalError("Cannot construct proper url from string")
        }

        let rssParser = RSSParser()
        rssParser.parseFeed(from: url)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] items in
                self?.rssItems = items
            })
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
                let values = self?.viewModelsRelay.value ?? []
                self?.viewModelsRelay.accept(values + [SectionOfCustomData(header: stringURL, items: viewModels)])
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
