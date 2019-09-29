//
//  UIViewController+Extensions.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 30/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import UIKit

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        child.view.frame = view.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
