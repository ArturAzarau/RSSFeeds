//
//  AlertControllerFactory.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

enum AlertControllerFactory {

    static func createTextFieldAlertWithTwoActions(title: String? = nil,
                                                   message: String? = nil,
                                                   textFieldConfiguration: ((UITextField) -> ())? = nil) -> UIAlertController {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: textFieldConfiguration)
        alertController.addAction(.init(title: "Отмена", style: .cancel, handler: { _ in
            alertController.dismiss(animated: true)
        }))

        return alertController
    }
}
