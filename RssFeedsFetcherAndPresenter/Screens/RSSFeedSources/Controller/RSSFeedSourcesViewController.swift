//
//  File.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private extension String {
    static let rssSourceCellReuseIdentifier = "RSSSourceCell"
}

final class RSSFeedSourcesViewController: BaseTableViewController<RSSFeedSourcesViewModel, UITableView> {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .rssSourceCellReuseIdentifier)

        bindViews()
    }

    // MARK: - Helpers

    private func bindViews() {
        viewModel.rssSourcesDriver
            .drive(tableView.rx.items(cellIdentifier: .rssSourceCellReuseIdentifier, cellType: UITableViewCell.self)) { index, viewModel, cell in
                cell.textLabel?.text = viewModel
            }
            .disposed(by: disposeBag)
    }
}
