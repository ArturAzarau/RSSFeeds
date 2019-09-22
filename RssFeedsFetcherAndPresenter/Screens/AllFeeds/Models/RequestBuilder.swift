//
//  RequestBuilder.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import Foundation

final class RequestBuilder {

    enum RequestBuildError: Error {
        case wrongURL
    }

    func buildRequest(from stringURL: String) throws -> URLRequest {
        guard let url = URL(string: stringURL) else {
            throw RequestBuildError.wrongURL
        }

        return URLRequest(url: url)
    }
}
