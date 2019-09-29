//
//  AlertControllerFactory.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 22/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

enum AlertControllerFactory {
    
    static func createTextFieldAlertWithCancel(title: String? = nil,
                                               message: String? = nil,
                                               textFieldConfiguration: ((UITextField) -> ())? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: textFieldConfiguration)
        alertController.addAction(.init(title: "Отмена", style: .cancel))
        
        return alertController
    }

    static func createOkAlertWithTextField(title: String? = nil,
                                           message: String? = nil,
                                           textFieldText: String? = nil,
                                           okAction: @escaping (String) -> ()) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.text = textFieldText
        }
        alertController.addAction(.init(title: "OK", style: .cancel, handler: { _ in
            guard let text = alertController.textFields?[0].text else {
                return
            }
            okAction(text)
        }))

        return alertController
    }
}
