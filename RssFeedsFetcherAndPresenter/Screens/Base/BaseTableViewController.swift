//
//  BaseTableViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit
import RxSwift

class BaseTableViewController<ViewModelType, TableViewType: UITableView>: BaseViewModelViewController<ViewModelType, TableViewType> {}

