//
//  ImageLoader.swift
//  HarryPotterApp
//
//  Created by Anton on 26.07.2021.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: String
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    private(set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    init(url: String, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }
        guard let url = URL(string: url) else { return }
        if let image = cache?[url] {
            self.image = image
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    private func cache(_ image: UIImage?) {
        guard let url = URL(string: url) else { return }
        image.map { cache?[url] = $0 }
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
