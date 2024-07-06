//
//  Database.swift
//  NikeStore
//
//  Created by Almir Khialov on 19.06.2024.
//
import SwiftUI
import FirebaseFirestore
import FirebaseCore
class Database: ObservableObject {
    @Published var productList = [ProductsModel]()
    private var listener: ListenerRegistration?
    
    init() {
        getProducts()
    }
    
    func getProducts() {
        let db = Firestore.firestore()
           
        listener = db.collection("Products").addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
               
            if let error = error {
                print("Error fetching products: \(error)")
                return
            }
               
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                return
            }
               
            DispatchQueue.main.async {
                self.productList = snapshot.documents.compactMap { document in
                    let data = document.data()
                       
                    let title = data["title"] as? String ?? "Unknown Title"
                    let brand = data["brand"] as? String ?? "Unknown Brand"
                    let description = data["description"] as? String ?? "No Description"
                    let imageNames = data["images"] as? [String] ?? []
                    let sizes = data["sizes"] as? [Int] ?? []
                    let price = data["price"] as? Int ?? 0
                    let category = data["category"] as? String ?? "Unknown Category"
                       
                    let product = ProductsModel(
                        id: document.documentID,
                        title: title,
                        brand: brand,
                        description: description,
                        images: imageNames,
                        sizes: sizes,
                        reviews: [sampleReview], // Вы можете загрузить реальные отзывы здесь
                        price: price,
                        category: category
                    )
                       
                    print("Loaded product: \(product.title), Images: \(product.images)")
                       
                    return product
                }
                   
                print("Total products loaded: \(self.productList.count)")
            }
        }
    }
    deinit {
        listener?.remove()
    }
}
