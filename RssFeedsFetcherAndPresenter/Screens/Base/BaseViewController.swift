//
//  BaseViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 29/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<ViewModelType, ViewType: UIView>: UIViewController {

    // MARK: - Properties

    let disposeBag = DisposeBag()
    let viewModel: ViewModelType
    let customView = ViewType()

    // MARK: - Init

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = customView
    }
}
