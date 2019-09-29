//
//  BaseViewModelViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 30/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

class BaseViewModelViewController<ViewModelType, ViewType: UIView>: BaseViewController<ViewType> {

    // MARK: - Properties

    let viewModel: ViewModelType

    // MARK: - Init

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
