//
//  CartView.swift
//  NikeStore
//
//  Created by Almir Khialov on 26.06.2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showingPaymentAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                if cartManager.items.isEmpty {
                    emptyCartView
                } else {
                    List {
                        ForEach(cartManager.items) { item in
                            CartItemRow(item: item, cartManager: cartManager)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    
                    cartSummaryView
                }
            }
            .navigationTitle("Ваша корзина")
            .toolbar {
                EditButton()
            }
        }
    }
    
    var emptyCartView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("Ваша корзина пуста")
                .font(.title2)
            Text("Начните делать покупки,\n чтобы добавить товары в корзину")
                .foregroundColor(.secondary)
        }
    }
    
    var cartSummaryView: some View {
        VStack {
            HStack {
                Text("Общая сумма:")
                    .font(.headline)
                Spacer()
                Text("₽ \(cartManager.total)")
                    .font(.title2).bold()
            }
            .padding()
            
            Button(action: {
                showingPaymentAlert = true
            }) {
                Text("Проверить")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding()
        .alert(isPresented: $showingPaymentAlert) {
            Alert(
                title: Text("Оплата"),
                message: Text("Здесь будет реализован платежный функционал"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        cartManager.items.remove(atOffsets: offsets)
    }
}

struct CartItemRow: View {
    let item: CartItem
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: item.product.images.first ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 60, height: 60)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.product.title)
                    .font(.headline)
                Text("Размер: \(item.size)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("₽ \(item.product.price)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Stepper(value: Binding(
                get: { item.quantity },
                set: { cartManager.updateQuantity(product: item.product, size: item.size, quantity: $0) }
            ), in: 1...10) {
                Text("\(item.quantity)")
            }
        }
        .padding(.vertical, 8)
    }
}
