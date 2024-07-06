//
//  ProductCard.swift
//  NikeStore
//
//  Created by Almir Khialov on 28.06.2024.
//
import SwiftUI

struct ProductCardView: View {
    let product: ProductsModel
    let onTap: () -> Void
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        VStack {
            HStack {
                Text(product.brand)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                Button(action: {
                    if favoritesManager.items.contains(where: { $0.id == product.id }) {
                        favoritesManager.removeFromFavorites(product)
                    } else {
                        favoritesManager.addToFavorites(product)
                    }
                }) {
                    Image(systemName: favoritesManager.items.contains(where: { $0.id == product.id }) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesManager.items.contains(where: { $0.id == product.id }) ? .red : .gray)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .padding(.trailing)
                .padding(.top)
            }
            
            AsyncImage(url: URL(string: product.images.first ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 150)
                        .clipped()
                case .failure:
                    Color.gray
                        .frame(width: 200, height: 150)
                case .empty:
                    ProgressView()
                        .frame(width: 200, height: 150)
                @unknown default:
                    EmptyView()
                        .frame(width: 200, height: 150)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(product.title)
                .font(.headline)
                .padding(.top, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .lineLimit(nil)
            
            Text("₽ \(product.price)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        .frame(width: 145, height: 280)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            onTap()
        }
    }
}
