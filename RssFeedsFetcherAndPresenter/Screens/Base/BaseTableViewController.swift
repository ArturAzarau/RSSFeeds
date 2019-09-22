//
//  BaseTableViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

protocol Initializable {
    init()
}

class BaseTableViewController<ViewModelType: Initializable>: UIViewController {

    // MARK: - Properties

    let viewModel: ViewModelType
    let tableView = AllFeedTableView()

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
        view = tableView
    }
}

