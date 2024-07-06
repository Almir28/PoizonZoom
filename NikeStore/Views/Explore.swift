//
//  Explore.swift
//  NikeStore
//
//  Created by Almir Khialov on 26.06.2024.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @EnvironmentObject var db: Database
    
    var filteredProducts: [ProductsModel] {
        if searchText.isEmpty {
            return db.productList
        } else {
            return db.productList.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(filteredProducts) { product in
                        NavigationLink(destination: ProductView(data: product)) {
                            ProductCard(product: product)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Поиск")
            .searchable(text: $searchText, prompt: "Поиск продуктов")
        }
    }
}

struct ProductCard: View {
    let product: ProductsModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Название бренда наверху карточки
            Text(product.brand)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.top, 5)
            
            AsyncImage(url: URL(string: product.images.first ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 150) // Увеличиваем ширину изображения
                        .clipped()
                case .failure:
                    Color.gray
                        .frame(width: 200, height: 150) // Увеличиваем ширину изображения
                case .empty:
                    ProgressView()
                        .frame(width: 200, height: 150) // Увеличиваем ширину изображения
                @unknown default:
                    EmptyView()
                        .frame(width: 200, height: 150) // Увеличиваем ширину изображения
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 5) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(1)
                Text("₽ \(product.price)")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
        }
        .frame(width: 190, height: 300) // Задаем фиксированный размер карточки
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

