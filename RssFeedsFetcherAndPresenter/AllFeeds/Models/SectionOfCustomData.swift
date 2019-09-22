//
//  SectionOfCustomData.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import RxDataSources

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = FeedCellViewModel

    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
