//
//  BaseViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 29/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<ViewType: UIView>: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()
    let customView = ViewType()


    // MARK: - Life Cycle

    override func loadView() {
        view = customView
    }
}
