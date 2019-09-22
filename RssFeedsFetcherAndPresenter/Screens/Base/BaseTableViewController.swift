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

    let viewModel = ViewModelType()
    let tableView = AllFeedTableView()

    override func loadView() {
        view = tableView
    }
}

