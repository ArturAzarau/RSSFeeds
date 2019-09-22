//
//  AllFeedTableView.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

final class AllFeedTableView: UITableView, InitializableView {

    // MARK: - Init

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        register(FeedCell.self, forCellReuseIdentifier: FeedCell.reuseIdentifier)
        initializeView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureAppearance() {
        separatorStyle = .none
    }

    func configureLayout() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
    }
}
