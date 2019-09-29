//
//  BaseViewModel.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 29/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseAlertedViewModel {

    // MARK: - Properties

    let errorsRelay = PublishRelay<Error>()
    var errorsSignal: Signal<Error> {
        return errorsRelay.asSignal()
    }
}
