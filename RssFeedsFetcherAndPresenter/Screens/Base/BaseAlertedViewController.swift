//
//  BaseAlertedViewController.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 29/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

class BaseAlertedViewController<ViewModelType: BaseAlertedViewModel, ViewType: UIView>: BaseViewModelViewController<ViewModelType, ViewType> {

    override init(viewModel: ViewModelType) {
        super.init(viewModel: viewModel)

        bindErrors()
    }

    private func bindErrors() {
        viewModel.errorsSignal
            .emit(onNext: {
                let controller = AlertControllerFactory.createAlertWithError(error: $0)
                let rootVC = UIApplication.shared.keyWindow?.rootViewController
                if  let navVC = rootVC as? UINavigationController,
                    let visibleVC = navVC.visibleViewController {
                    visibleVC.present(controller, animated: true)
                } else {
                    rootVC?.present(controller, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
