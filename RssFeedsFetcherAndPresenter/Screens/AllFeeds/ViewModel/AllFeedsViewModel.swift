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

final class AllFeedsViewModel: BaseAlertedViewModel {

    // MARK: - Inner Types

    let storage = RSSFeedsStorage()
    private let disposeBag = DisposeBag()
    private let parser = RSSParser()
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

    var sections: [SectionOfCustomData] {
        return viewModelsRelay.value
    }

    func startFetchingRSSFeeds() {
        let sources = storage.getRssSources()

        let singles = sources.compactMap { URL(string: $0) }
            .map { parser.parseFeed(from: $0) }
        Single.zip(singles)
            .do(onSuccess: { [weak self] itemsArray in
                self?.rssItems = itemsArray.flatMap { $0 }
            })
            .map { [weak self] in $0.enumerated().compactMap { self?.createViewModels(from: $1, and: sources[$0]) } }
            .subscribe(onSuccess: { [weak self] viewModels in
                self?.viewModelsRelay.accept(viewModels)
            }) { [weak self] error in
                self?.errorsRelay.accept(error)
            }
            .disposed(by: disposeBag)

    }

    private func createViewModels(from feedItems: [RSSFeedItem], and urlString: String) -> SectionOfCustomData {
        let items = feedItems
            .map { [weak self] item -> FeedCellViewModel in
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

        return SectionOfCustomData(header: urlString, items: items)
    }
}

extension AllFeedsViewModel: RSSFeedSourcesDelegate {
    func sourceDidAdd(source: String) {
        guard let url = URL(string: source) else {
            return
        }

        parser.parseFeed(from: url)
            .do(onSuccess: { [weak self] in
                guard let self = self else {
                    return
                }
                self.rssItems = self.rssItems + $0
            })
            .map { [weak self] in
                return self?.createViewModels(from: $0, and: source) ?? nil
            }
            .flatMap { Observable.from(optional: $0).asSingle() }
            .subscribe(onSuccess: { [weak self] viewModel in
                guard let self = self else {
                    return
                }
                var viewModels = self.viewModelsRelay.value
                viewModels.append(viewModel)
                self.viewModelsRelay.accept(viewModels)
            }) { [weak self] error in
                self?.errorsRelay.accept(error)
            }
            .disposed(by: disposeBag)
    }

    func sourceDidRemove(source: String) {
        var sources = viewModelsRelay.value
        guard let sourceIndex = sources.firstIndex(where: { $0.header == source }) else {
            return
        }

        sources.remove(at: sourceIndex)
        viewModelsRelay.accept(sources)
    }
}
