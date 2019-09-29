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
import SafariServices

final class AllFeedsViewController: BaseAlertedViewController<AllFeedsViewModel, AllFeedTableView> {

    // MARK: - Properties

    private let loaderVC = LoaderViewController()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.startFetchingRSSFeeds()
        configureBarButtonItems()
        bindViews()
    }

    // MARK: - Bindings

    private func bindViews() {
        bindCellsViewModels()
        bindRightBarButtonItem()
        bindItemsSelection()
    }

    private func bindCellsViewModels() {
        viewModel.viewModelsDriver
            .drive(customView.rx.items(dataSource: viewModel.tableViewDataSource))
            .disposed(by: disposeBag)
    }

    private func bindRightBarButtonItem() {
        navigationItem.rightBarButtonItem?.rx.tap.bind(to: rightBarButtonTappedBinder).disposed(by: disposeBag)
    }

    private var rightBarButtonTappedBinder: Binder<Void> {
        return Binder(self) { base, value in
            let controller = RSSFeedSourcesViewController(viewModel: .init(storage: base.viewModel.storage,
                                                                           delegate: base.viewModel))
            base.navigationController?.pushViewController(controller, animated: true)
        }
    }

    private func bindItemsSelection() {
        customView.rx.modelSelected(FeedCellViewModel.self)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] item in
                defer {
                    self?.loaderVC.remove()
                    self?.customView.isScrollEnabled = true
                }
                guard let self = self else {
                    return
                }

                let controller: UIViewController

                self.add(self.loaderVC)
                self.customView.isScrollEnabled = false
                if let htmlText = self.viewModel.createHTMLPage(for: item.title) {
                    controller = RSSArticleViewController(viewModel: .init(title: item.title, text: htmlText))
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    guard let link = self.viewModel.getLinkForSource(source: item.title), let url = URL(string: link) else {
                        return
                    }

                    controller = SFSafariViewController(url: url)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Helpers

    private func configureBarButtonItems() {
        navigationItem.rightBarButtonItem = .init(title: "RSS Sources Settings", style: .plain, target: self, action: nil)
    }
}
