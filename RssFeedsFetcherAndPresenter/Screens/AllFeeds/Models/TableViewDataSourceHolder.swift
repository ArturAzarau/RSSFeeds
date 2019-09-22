//
//  TableViewDataSourceHolder.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import RxDataSources

struct TableViewDataSourceHolder {

    let tableViewDataSource: RxTableViewSectionedReloadDataSource = { () -> RxTableViewSectionedReloadDataSource<SectionOfCustomData> in
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { (dataSource, tableView, indexPath, viewModel) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseIdentifier) as? FeedCell else {
                fatalError("Wrong cell type")
            }

            cell.configure(with: viewModel)
            return cell
        })

        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }

        return dataSource
    }()
}
