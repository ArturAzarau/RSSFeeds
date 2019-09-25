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
import RxDataSources

final class AllFeedsViewController: BaseTableViewController<AllFeedsViewModel, AllFeedTableView> {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.startFetchingRSSFeeds()
        configureBarButtonItems()
        bindViews()
    }

    // MARK: - Helpers

    private func bindViews() {
        bindCellsViewModels()
        bindRightBarButtonItem()
    }

    private func bindCellsViewModels() {
        viewModel.viewModelsDriver
            .drive(tableView.rx.items(dataSource: viewModel.tableViewDataSource))
            .disposed(by: disposeBag)
    }

    private func bindRightBarButtonItem() {
        navigationItem.rightBarButtonItem?.rx.tap.bind(to: rightBarButtonTappedBinder).disposed(by: disposeBag)
    }

    private var rightBarButtonTappedBinder: Binder<Void> {
        return Binder(self) { base, value in
//            let alertController = AlertControllerFactory.createTextFieldAlertWithTwoActions(title: "Введите название ресурса с RSS",
//                                                                                            textFieldConfiguration: {
//                                                                                                $0.text = "https://grantland.com/features/feed/"
//            })
//
//            alertController.addAction(.init(title: "ОК", style: .default, handler: { _ in
//                if let text = alertController.textFields?.first?.text {
//                    base.viewModel.startFetchingRSSFeeds(for: text)
//                }
//            }))
            //
            //            base.present(alertController, animated: true)

            base.viewModel.viewModelsDriver
                .drive(onNext: { sections in
                    let rssSources = sections.map { $0.header }
                    let controller = RSSFeedSourcesViewController(viewModel: .init(rssSources: rssSources))
                    base.navigationController?.pushViewController(controller, animated: true)
                })
                .disposed(by: base.disposeBag)
        }
    }

    private func configureBarButtonItems() {
        navigationItem.rightBarButtonItem = .init(title: "RSS Sources Settings", style: .plain, target: self, action: nil)
    }
}
