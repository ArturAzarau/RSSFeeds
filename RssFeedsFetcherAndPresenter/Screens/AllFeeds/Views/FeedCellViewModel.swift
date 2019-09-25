//
//  FeedCellViewModel.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxCocoa

struct FeedCellViewModel {

    let title: String?
    let description: String?
    let imageDriver: Driver<UIImage?>
}
