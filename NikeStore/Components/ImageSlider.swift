//
//  ImageSlider.swift
//  NikeStore
//
//  Created by Almir Khialov on 19.06.2024.
//

import SwiftUI

struct ImageSlider: View {
    var images: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(images, id: \.self) { imageUrl in
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: 400)
                                .clipped()
                        case .failure(let error):
                            Text("Failed to load image: \(error.localizedDescription)")
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .onAppear {
            print("ImageSlider appeared with \(images.count) images: \(images)")
        }
    }
}
