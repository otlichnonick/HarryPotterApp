//
//  ImageCacheKey.swift
//  HarryPotterApp
//
//  Created by Anton on 26.07.2021.
//

import Foundation
import SwiftUI
import Combine

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
