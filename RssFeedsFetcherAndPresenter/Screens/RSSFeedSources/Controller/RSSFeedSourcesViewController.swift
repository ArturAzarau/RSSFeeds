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
        customView.register(UITableViewCell.self, forCellReuseIdentifier: .rssSourceCellReuseIdentifier)

        configureBarButtonItems()
        bindViews()
    }

    // MARK: - Helpers

    private func configureBarButtonItems() {
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: nil)
    }

    private func bindRightBarButtonItem() {
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] in
                let alertController = AlertControllerFactory.createTextFieldAlertWithCancel(title: "Введите название ресурса с RSS")
                { [weak self] in
                    self?.viewModel.addRssSource($0)
                }

                self?.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func bindViews() {
        viewModel.rssSourcesDriver
            .drive(customView.rx.items(cellIdentifier: .rssSourceCellReuseIdentifier, cellType: UITableViewCell.self)) { index, viewModel, cell in
                cell.textLabel?.text = viewModel
            }
            .disposed(by: disposeBag)

        customView.rx.modelDeleted(String.self).subscribe(onNext: { [weak self] in
            self?.viewModel.removeRssSource(with: $0)
        })
        .disposed(by: disposeBag)

        customView.rx.itemSelected.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] indexPath in
            guard let self = self else {
                return
            }
            let currentValue = self.viewModel.sources[indexPath.row]
            let controller = AlertControllerFactory.createOkAlertWithTextField(title: "Редактировать RSS Source",
                                                                               textFieldText: currentValue) { [weak self] text in
                                                                                self?.viewModel.editRssSource(text, at: indexPath)
            }

            self.present(controller, animated: true)
        })
            .disposed(by: disposeBag)

        bindRightBarButtonItem()
    }
}
