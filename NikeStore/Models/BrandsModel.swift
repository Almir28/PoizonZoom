//
//  BrandsModel.swift
//  NikeStore
//
//  Created by Almir Khialov on 19.06.2024.
//

import SwiftUI
struct BrandsModel: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}
var sampleBrands: [BrandsModel] = [
    .init(title: "All", icon: ""),
    .init(title: "Nike", icon: "nike"),
    .init(title: "Adidas", icon: "adidas"),
    .init(title: "Puma", icon: "puma")
    
]
