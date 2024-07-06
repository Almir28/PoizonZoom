//
//  CartManager.swift
//  NikeStore
//
//  Created by Almir Khialov on 26.06.2024.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published var items: [CartItem] = [] {
        didSet {
            saveCartItems()
        }
    }
    
    init() {
        loadCartItems()
    }
    
    func addToCart(product: ProductsModel, size: Int) {
        if let index = items.firstIndex(where: { $0.product.id == product.id && $0.size == size }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1, size: size))
        }
    }
    
    func removeFromCart(product: ProductsModel, size: Int) {
        items.removeAll { $0.product.id == product.id && $0.size == size }
    }
    
    func updateQuantity(product: ProductsModel, size: Int, quantity: Int) {
        if let index = items.firstIndex(where: { $0.product.id == product.id && $0.size == size }) {
            items[index].quantity = quantity
        }
    }
    
    var total: Int {
        items.reduce(0) { $0 + $1.product.price * $1.quantity }
    }
    
    private func saveCartItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "cartItems")
        }
    }
    
    private func loadCartItems() {
        if let savedItems = UserDefaults.standard.data(forKey: "cartItems"),
           let decodedItems = try? JSONDecoder().decode([CartItem].self, from: savedItems) {
            items = decodedItems
        }
    }
}
