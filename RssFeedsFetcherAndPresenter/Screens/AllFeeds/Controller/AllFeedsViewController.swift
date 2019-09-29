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

final class AllFeedsViewController: BaseTableViewController<AllFeedsViewModel, AllFeedTableView> {

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
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else {
                    return
                }

                let rssItem = self.viewModel.rssItems.first { $0.title == item.title }

                let controller: UIViewController

                if let content = rssItem?.content?.contentEncoded, let data = content.data(using: .utf8, allowLossyConversion: true) {
                    let title = rssItem?.title
                    do {
                        let attributtedString = try NSAttributedString(data: data,
                                                                       options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html],
                                                                       documentAttributes: nil)

                        controller = RSSArticleViewController(viewModel: .init(title: title, text: attributtedString))
                        self.navigationController?.pushViewController(controller, animated: true)
                    } catch {
                        print(error)
                    }
                } else {
                    guard let link = rssItem?.link, let url = URL(string: link) else {
                        return
                    }
                    controller = SFSafariViewController(url: url)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    private func bindErrors() {
        viewModel.errorsSignal
            .emit(onNext: { [weak self] error in
                let controller = AlertControllerFactory.createAlertWithError(error: error)
                self?.present(controller, animated: true)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Helpers

    private func configureBarButtonItems() {
        navigationItem.rightBarButtonItem = .init(title: "RSS Sources Settings", style: .plain, target: self, action: nil)
    }
}
