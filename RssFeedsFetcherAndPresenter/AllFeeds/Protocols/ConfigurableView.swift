//
//  ConfigurableView.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import Foundation

protocol ConfigurableView: class {
    associatedtype ViewModelType

    func configure(with viewModel: ViewModelType)
}
