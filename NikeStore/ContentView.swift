//
//  ContentView.swift
//  NikeStore
//
//  Created by Almir Khialov on 07.06.2024.
//
import SwiftUI

struct ContentView: View {

    @StateObject var db = Database()
    @StateObject var cartManager = CartManager()
    @StateObject var favoritesManager = FavoritesManager()

    var body: some View {
        TabView {
            Home()
                .environmentObject(cartManager)
                .environmentObject(favoritesManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }

            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Поиск")
                }

            CartView()
                .environmentObject(cartManager)
                .tabItem {
                    Image(systemName: "bag")
                    Text("Корзина")
                }

            // New Tab for "Новости"
            NewsView()  // This is where you will display news
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Новости")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Профиль")
                }
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
