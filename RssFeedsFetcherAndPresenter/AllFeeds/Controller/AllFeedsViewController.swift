//
//  ViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class AllFeedsViewController: UIViewController {

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private let viewModel = AllFeedsViewModel()
    private let tableView = AllFeedTableView()


    // MARK: - Life Cycle

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.startFetchingRSSFeeds()

        viewModel.viewModelsDriver
            .drive(tableView.rx.items(cellIdentifier: FeedCell.reuseIdentifier,
                                      cellType: FeedCell.self))
            {(row, element, cell) in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
    }
}
