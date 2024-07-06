//
//  Cart.swift
//  NikeStore
//
//  Created by Almir Khialov on 26.06.2024.
//
import SwiftUI
struct CartItem: Identifiable, Codable {
    var id: UUID
    let product: ProductsModel
    var quantity: Int
    let size: Int
    
    init(id: UUID = UUID(), product: ProductsModel, quantity: Int, size: Int) {
        self.id = id
        self.product = product
        self.quantity = quantity
        self.size = size
    }
}
