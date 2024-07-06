//
//  FovariteView.swift
//  NikeStore
//
//  Created by Almir Khialov on 28.06.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var selectedProduct: ProductsModel? = nil
    
    var body: some View {
        VStack {
            if favoritesManager.items.isEmpty {
                Text("Пока нет избранных")
                    .font(.headline)
                    .foregroundColor(.secondary)
            } else {
                List(favoritesManager.items) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.images[0])) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipped()
                            case .failure:
                                Color.gray
                                    .frame(width: 50, height: 50)
                            case .empty:
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Text(item.title)
                            .font(.headline)
                    }
                    .onTapGesture {
                        selectedProduct = item
                    }
                }
            }
        }
        .navigationTitle("Избранное")
        .sheet(item: $selectedProduct) { product in
            ProductView(data: product)
        }
    }
}
