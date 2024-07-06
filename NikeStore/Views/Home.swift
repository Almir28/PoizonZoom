//
//  Home.swift
//  NikeStore
//
//  Created by Almir Khialov on 19.06.2024.
import SwiftUI
import Firebase

struct Home: View {
    @StateObject var db = Database()
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var currentCategory = "All"
    @State private var selectedProduct: ProductsModel? = nil
    @State private var showProduct = false
    @State private var currentFeaturedIndex = 0
    
    let categories = ["Tops", "Bottoms", "Shoes", "Accessories"]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    headerView
                    featuredProductView
                    categoriesView
                    selectedCategoryView
                    productsGridView
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .onAppear {
                // No need to call loadProducts() manually, as productsList is updated by db automatically
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(item: $selectedProduct) { product in
            ProductView(data: product)
        }
    }
    
    var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Добро пожаловать в")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("Poizon Zoom")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Spacer()
            HStack(spacing: 15) {
                cartButton
                favoritesButton
            }
        }
    }
    
    var cartButton: some View {
        ZStack {
            NavigationLink(destination: CartView()) {
                Image(systemName: "cart")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
            
            if !cartManager.items.isEmpty {
                Text("\(cartManager.items.count)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
    
    var favoritesButton: some View {
        ZStack {
            NavigationLink(destination: FavoritesView()) {
                Image(systemName: "heart")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
            
            if !favoritesManager.items.isEmpty {
                Text("\(favoritesManager.items.count)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
    
    var featuredProductView: some View {
        ZStack(alignment: .bottomLeading) {
            if !db.productList.isEmpty {
                TabView(selection: $currentFeaturedIndex) {
                    ForEach(db.productList.prefix(5).indices, id: \.self) { index in
                        featuredProductCard(product: db.productList[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 250)
                .animation(.easeInOut, value: currentFeaturedIndex)
                .onAppear {
                    startFeaturedProductTimer()
                }
            }
        }
    }
    
    func featuredProductCard(product: ProductsModel) -> some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: product.images[0])) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Color.gray
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Рекомендуемые")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Capsule())
                
                Text(product.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("₽\(product.price)")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
            .shadow(radius: 10)
        }
        .onTapGesture {
            selectedProduct = product
        }
    }
    
    func startFeaturedProductTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            withAnimation {
                currentFeaturedIndex = (currentFeaturedIndex + 1) % min(db.productList.count, 5)
            }
        }
    }
    
    var categoriesView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Категории одежды")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(categories, id: \.self) { category in
                        VStack {
                            Image(systemName: categoryIcon(for: category))
                                .font(.system(size: 30))
                                .foregroundColor(currentCategory == category ? .white : .primary)
                                .frame(width: 60, height: 60)
                                .background(currentCategory == category ? Color.blue : Color(.systemGray5))
                                .clipShape(Circle())
                            
                            Text(category)
                                .font(.caption)
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                currentCategory = category
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    func categoryIcon(for category: String) -> String {
        switch category {
        case "Tops":
            return "tshirt"
        case "Bottoms":
            return "figure.walk"
        case "Shoes":
            return "shoe"
        case "Accessories":
            return "eyeglasses"
        default:
            return "questionmark"
        }
    }
    
    @ViewBuilder
    var selectedCategoryView: some View {
        switch currentCategory {
        case "Tops":
            TopsView(products: db.productList.filter { $0.category == "Tops" })
        case "Bottoms":
            BottomsView(products: db.productList.filter { $0.category == "Bottoms" })
        case "Shoes":
            ShoesView(products: db.productList.filter { $0.category == "Shoes" })
        case "Accessories":
            AccessoriesView(products: db.productList.filter { $0.category == "Accessories" })
        default:
            productsGridView
        }
    }
    
    var productsGridView: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach(db.productList) { product in
                ProductCardView(product: product,
                                onTap: {
                                    selectedProduct = product
                                    showProduct = true
                                },
                                isFavorite: { favoritesManager.items.contains(where: { $0.id == product.id }) },
                                onFavoriteToggle: {
                                    if favoritesManager.items.contains(where: { $0.id == product.id }) {
                                        favoritesManager.removeFromFavorites(product)
                                    } else {
                                        favoritesManager.addToFavorites(product)
                                    }
                                })
            }
        }
        .padding()
    }
    
    struct ProductCardView: View {
        let product: ProductsModel
        let onTap: () -> Void
        let isFavorite: () -> Bool
        let onFavoriteToggle: () -> Void
        
        var body: some View {
            VStack {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: product.images.first ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 150) // Adjusted width of image
                                .clipped()
                        case .failure:
                            Color.gray
                                .frame(width: 200, height: 150) // Adjusted width of image
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 150) // Adjusted width of image
                        @unknown default:
                            EmptyView()
                                .frame(width: 200, height: 150) // Adjusted width of image
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button(action: onFavoriteToggle) {
                        Image(systemName: isFavorite() ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite() ? .red : .gray)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding(8)
                }
                
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
            .frame(width: 150, height: 300)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .onTapGesture {
                onTap()
            }
        }
    }
}
