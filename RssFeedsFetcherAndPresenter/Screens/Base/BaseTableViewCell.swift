//
//  BaseTableViewCell.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseTableViewCell<ViewModelType>: UITableViewCell, InitializableView {

    // MARK: - Properties

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private(set) var disposeBag = DisposeBag()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Initialization through storyboard is not supported")
    }

    // MARK: - InitializableView

    func addViews() {
        /// override in subclass
    }

    func bindViews() {
        /// override in subclass
    }

    func configureLayout() {
        /// override in subclass
    }

    func configureAppearance() {
        /// override in subclass
    }

    func localize() {
        /// override in subclass
    }

    // MARK: - Internal

    func configure(with viewModel: ViewModelType) {
        disposeBag = DisposeBag()


    }
}
