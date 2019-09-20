//
//  ImageDownloader.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 20/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DataFetcher {

    // MARK: - Inner Types

    enum FetchError: Error {
        case wrongURL
    }

    // MARK: - Properties

    private let requestBuilder = RequestBuilder()

    // MARK: - Internal

    func fetchImage(for stringURL: String) throws -> Observable<Data> {
        
        do {
            let request = try requestBuilder.buildRequest(from: stringURL)
            return URLSession.shared.rx.data(request: request)
        } catch {
            throw error
        }
    }
}
