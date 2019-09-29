//
//  RSSFeedSourcesViewModel.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

protocol RSSFeedSourcesDelegate: class {
    func sourceDidAdd(source: String)
    func sourceDidRemove(source: String)
}

final class RSSFeedSourcesViewModel: BaseAlertedViewModel {

    // MARK: - Properties

    private let rssStorage: RSSFeedsStorage
    private let rssSourcesRelay = BehaviorRelay(value: [String]())
    private weak var delegate: RSSFeedSourcesDelegate?

    var rssSourcesDriver: Driver<[String]> {
        return rssSourcesRelay.asDriver(onErrorDriveWith: .empty())
    }

    var sources: [String] {
        return rssSourcesRelay.value
    }

    // MARK: - Init

    init(storage: RSSFeedsStorage, delegate: RSSFeedSourcesDelegate? = nil) {
        self.delegate = delegate
        rssStorage = storage
        rssSourcesRelay.accept(rssStorage.getRssSources())
    }

    // MARK: - Internal

    func addRssSource(_ rssSource: String) {
        do {
            let newSources = try rssStorage.saveRssSource(rssSource: rssSource)
            delegate?.sourceDidAdd(source: rssSource)
            rssSourcesRelay.accept(newSources)
        } catch {
            errorsRelay.accept(error)
        }
    }

    func removeRssSource(with urlString: String) {
        do {
            let newSources = try rssStorage.deleteRssSorce(with: urlString)
            delegate?.sourceDidRemove(source: urlString)
            rssSourcesRelay.accept(newSources)
        } catch {
            errorsRelay.accept(error)
        }
    }

    func editRssSource(_ newValue: String, at indexPath: IndexPath) {
        do {
            let newSources = try rssStorage.editRssSource(index: indexPath.row, newValue: newValue)
            rssSourcesRelay.accept(newSources)
        } catch {
            errorsRelay.accept(error)
        }
    }
}
