//
//  Product.swift
//  NikeStore
//
//  Created by Almir Khialov on 19.06.2024.
//
import SwiftUI

struct ProductView: View {
    var data: ProductsModel
    @State private var selectedSize: Int?
    @State private var topPadding: CGFloat = 0
    @State private var showingPaymentAlert = false
    @State private var showingSizeAlert = false
    @State private var isAddingToCart = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartManager: CartManager
    
    @State private var addToCartScale: CGFloat = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                    .padding(.leading)
                    Spacer()
                    Image(systemName: "heart")
                        .padding()
                        .background(Color.gray.opacity(0.1)) // Changed to red
                        .clipShape(Circle())
                    }
                .padding(.top, topPadding)
                .padding(.horizontal)
                
                if !data.images.isEmpty {
                    ImageSlider(images: data.images)
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .padding()
                        .scaledToFit()
                } else {
                    Text("Изображения отсутствуют")
                }
                
                Image(data.brand.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(data.title)
                        .font(.largeTitle.bold())
                    Text("\(data.price) ₽")
                        .font(.title.bold())
                    
                    Text("Размер")
                        .font(.title.bold())
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(data.sizes, id: \.self) { size in
                                Text("\(size)")
                                    .frame(width: 70, height: 70)
                                    .background(selectedSize == size ? Color.black : Color.gray.opacity(0.1))
                                    .foregroundColor(selectedSize == size ? Color.white : Color.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .onTapGesture {
                                        selectedSize = size
                                    }
                            }
                        }
                    }
                    
                    Text("Описание")
                        .font(.title.bold())
                    Text(data.description)
                        .font(.body)
                        .padding(.bottom)
                }
                .padding()
                
                VStack(spacing: 15) {
                    Button(action: {
                        if let size = selectedSize {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                isAddingToCart = true
                                addToCartScale = 1.2
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                cartManager.addToCart(product: data, size: size)
                                
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                    isAddingToCart = false
                                    addToCartScale = 1.0
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        } else {
                            showingSizeAlert = true
                        }
                    }) {
                        Text(isAddingToCart ? "Добавлено!" : "Добавить в корзину")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isAddingToCart ? Color.green : Color.black)
                            .cornerRadius(10)
                    }
                    .scaleEffect(addToCartScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: addToCartScale)
                    
                    Button(action: {
                        showingPaymentAlert = true
                    }) {
                        Text("Купить сейчас")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.top)
            .alert(isPresented: $showingSizeAlert) {
                Alert(
                    title: Text("Выберите размер"),
                    message: Text("Пожалуйста, выберите размер перед добавлением в корзину."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                self.topPadding = window.safeAreaInsets.top
            }
            print("ProductView появился для продукта: \(data.title), Изображения: \(data.images)")
        }
    }

    struct SizeButton: View {
        let size: Int
        let isSelected: Bool
        let action: () -> Void
        
        @State private var animationAmount: CGFloat = 1
        
        var body: some View {
            Text("\(size)")
                .frame(width: 70, height: 70)
                .background(isSelected ? Color.black : Color.gray.opacity(0.1))
                .foregroundColor(isSelected ? Color.white : Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(
                    Circle()
                        .stroke(Color.black)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            .easeOut(duration: 1)
                                .repeatForever(autoreverses: false),
                            value: animationAmount
                        )
                )
                .onAppear {
                    if isSelected {
                        animationAmount = 2
                    }
                }
                .onTapGesture(perform: action)
        }
    }
}
