//
//  FavoritesManager.swift
//  NikeStore
//
//  Created by Almir Khialov on 28.06.2024.
//

import SwiftUI

class FavoritesManager: ObservableObject {

    @Published var items: [ProductsModel] = [] {

        didSet {

            saveFavoriteItems()

        }

    }

    

    init() {

        loadFavoriteItems()

    }

    

    func addToFavorites(_ product: ProductsModel) {

        if !items.contains(where: { $0.id == product.id }) {

            items.append(product)

        }

    }

    

    func removeFromFavorites(_ product: ProductsModel) {

        items.removeAll { $0.id == product.id }

    }

    

    private func saveFavoriteItems() {

        if let encoded = try? JSONEncoder().encode(items) {

            UserDefaults.standard.set(encoded, forKey: "favoriteItems")

        }

    }

    

    private func loadFavoriteItems() {

        if let savedItems = UserDefaults.standard.data(forKey: "favoriteItems"),

           let decodedItems = try? JSONDecoder().decode([ProductsModel].self, from: savedItems) {

            items = decodedItems

        }

    }

}
