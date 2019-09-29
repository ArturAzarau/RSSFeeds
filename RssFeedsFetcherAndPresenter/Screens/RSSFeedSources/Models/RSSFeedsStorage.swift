//
//  RSSFeedsStorage.swift
//  RssFeedsFetcherAndPresenter
//
//  Created by Артур Азаров on 29/09/2019.
//  Copyright © 2019 Артур Азаров. All rights reserved.
//

import Foundation

private enum SavingKeys {
    static let rssFeedsSources = "rssFeedsSources"
}


final class RSSFeedsStorage {

    // MARK: - Inner Types

    enum SavingError: Error {
        case rssSourceAlreadyExists, noSuchRssSource, noSourcesAreStored
    }

    // MARK: - Properties

    private let defaults: UserDefaults

    // MARK: - Init

    init(storage: UserDefaults = .standard) {
        self.defaults = storage
    }

    // MARK: Internal

    func saveRssSource(rssSource: String) throws -> [String] {
        let sourcesToSave: [String]

        if var savedRssSources = defaults.object(forKey: SavingKeys.rssFeedsSources) as? [String] {
            guard !savedRssSources.contains(rssSource) else {
                throw SavingError.rssSourceAlreadyExists
            }
            savedRssSources.append(rssSource)
            sourcesToSave = savedRssSources
            defaults.set(savedRssSources, forKey: SavingKeys.rssFeedsSources)
        } else {
            sourcesToSave = [rssSource]
        }

        defaults.set(sourcesToSave, forKey: SavingKeys.rssFeedsSources)
        return sourcesToSave
    }

    func getRssSources() -> [String] {
        guard let rssSources = defaults.object(forKey: SavingKeys.rssFeedsSources) as? [String] else {
            return []
        }

        return rssSources
    }

    @discardableResult
    func deleteRssSorce(with urlString: String) throws -> [String] {
        guard var rssSources = defaults.object(forKey: SavingKeys.rssFeedsSources) as? [String] else {
            throw SavingError.noSourcesAreStored
        }

        guard let indexToDeleteAt = rssSources.firstIndex(of: urlString) else {
            throw SavingError.noSuchRssSource
        }

        rssSources.remove(at: indexToDeleteAt)
        defaults.set(rssSources, forKey: SavingKeys.rssFeedsSources)

        return rssSources
    }

    func editRssSource(index: Int, newValue: String) throws -> [String] {
        guard var rssSources = defaults.object(forKey: SavingKeys.rssFeedsSources) as? [String] else {
            throw SavingError.noSourcesAreStored
        }

        rssSources[index] = newValue
        defaults.set(rssSources, forKey: SavingKeys.rssFeedsSources)

        return rssSources
    }
}
