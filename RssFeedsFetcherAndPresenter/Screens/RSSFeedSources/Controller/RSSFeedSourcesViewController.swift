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
                let alertController = AlertControllerFactory.createTextFieldAlertWithCancel(title: "Введите название ресурса с RSS",
                                                                                            textFieldConfiguration: {
                                                                                                $0.text = "https://grantland.com/features/feed/"
                })

                alertController.addAction(.init(title: "ОК", style: .default, handler: { [weak self] _ in
                    if let text = alertController.textFields?.first?.text {
                        self?.viewModel.addRssSource(text)
                    }
                }))

                self?.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func bindViews() {
        viewModel.rssSourcesDriver
            .drive(tableView.rx.items(cellIdentifier: .rssSourceCellReuseIdentifier, cellType: UITableViewCell.self)) { index, viewModel, cell in
                cell.textLabel?.text = viewModel
            }
            .disposed(by: disposeBag)

        tableView.rx.modelDeleted(String.self).subscribe(onNext: { [weak self] in
            do {
                try self?.viewModel.removeRssSource(with: $0)
            } catch {
                print(error)
            }
            print($0)
        })
        .disposed(by: disposeBag)

        tableView.rx.itemSelected.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] indexPath in
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
