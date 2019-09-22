//
//  RSSParser.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import FeedKit
import RxSwift


final class RSSParser {
    
    func parseFeed(from url: URL) -> Single<[RSSFeedItem]> {
        return .deferred {
            return .create(subscribe: { single -> Disposable in
                let feedParser = FeedParser(URL: url)
                let result = feedParser.parse()

                if let error = result.error {
                    single(.error(error))
                    return Disposables.create()
                }

                let items = result.rssFeed?.items ?? []

                single(.success(items))
                return Disposables.create()
            })
        }
    }
}
