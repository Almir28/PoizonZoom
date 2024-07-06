import SwiftUI

struct AnimatedSectionHeader: View {
    let title: String
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Helvetica Neue", size: 40))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                )
                .overlay(
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 3)
                        .offset(x: isAnimating ? 0 : -UIScreen.main.bounds.width, y: 0)
                        .animation(.easeInOut(duration: 0.7).delay(0.2), value: isAnimating)
                    , alignment: .bottom
                )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct TopsView: View {
    let products: [ProductsModel]
    @State private var selectedProduct: ProductsModel? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            AnimatedSectionHeader(title: "Верх")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(products.filter { $0.category == "Tops" }) { product in
                        ProductCardView(product: product, onTap: {
                            selectedProduct = product
                        })
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .sheet(item: $selectedProduct) { product in
            ProductView(data: product)
        }
    }
}

struct BottomsView: View {
    let products: [ProductsModel]
    @State private var selectedProduct: ProductsModel? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            AnimatedSectionHeader(title: "Низ")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(products.filter { $0.category == "Bottoms" }) { product in
                        ProductCardView(product: product, onTap: {
                            selectedProduct = product
                        })
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .sheet(item: $selectedProduct) { product in
            ProductView(data: product)
        }
    }
}

struct ShoesView: View {
    let products: [ProductsModel]
    @State private var selectedProduct: ProductsModel? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            AnimatedSectionHeader(title: "Обувь")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(products.filter { $0.category == "Shoes" }) { product in
                        ProductCardView(product: product, onTap: {
                            selectedProduct = product
                        })
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .sheet(item: $selectedProduct) { product in
            ProductView(data: product)
        }
    }
}

struct AccessoriesView: View {
    let products: [ProductsModel]
    @State private var selectedProduct: ProductsModel? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            AnimatedSectionHeader(title: "Аксессуары")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(products.filter { $0.category == "Accessories" }) { product in
                        ProductCardView(product: product, onTap: {
                            selectedProduct = product
                        })
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .sheet(item: $selectedProduct) { product in
            ProductView(data: product)
        }
    }
}

struct HomeView: View {
    let products: [ProductsModel]
    @State private var selectedProduct: ProductsModel? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            AnimatedSectionHeader(title: "Главная")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(products) { product in
                        ProductCardView(product: product, onTap: {
                            selectedProduct = product
                        })
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .sheet(item: $selectedProduct) { product in
            ProductView(data: product)
        }
    }
}
