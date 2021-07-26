//
//  RemoteImage.swift
//  HarryPotterApp
//
//  Created by Anton on 26.07.2021.
//

import SwiftUI
import GXUtilz

struct RemoteImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private var placeholder: Placeholder
    private var image: (UIImage) -> Image
    
    init(
        url: String,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
            }
        }
    }
}

