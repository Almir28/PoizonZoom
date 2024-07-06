//
//  Onboarding.swift
//  NikeStore
//
//  Created by Almir Khialov on 07.06.2024.
//

import SwiftUI

struct Onboarding: View {
    @State private var isActive = false
    @State private var isExpanded = false
    @State private var textOpacity: Double = 0
    @State private var arrowOffset: CGFloat = 0

    var body: some View {
        if isActive {
            Sing_in()
        } else {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    // Фоновое изображение
                    Image("onboardingLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                    
                    // Анимированные цветные фигуры
                    ColorfulShape(color: .red)
                        .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.3)
                    ColorfulShape(color: .blue)
                        .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.6)
                    ColorfulShape(color: .green)
                        .position(x: geometry.size.width * 0.37, y: geometry.size.height * 0.8)
                
                    ColorfulShape(color: .orange)
                        .position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.2)
                    ColorfulShape(color: .yellow)
                        .position(x: geometry.size.width * 0.7, y: geometry.size.height * 0.4)
                    ColorfulShape(color: .pink)
                        .position(x: geometry.size.width * 0.4, y: geometry.size.height * 0.7)
                    ColorfulShape(color: .cyan)
                        .position(x: geometry.size.width * 0.6, y: geometry.size.height * 0.5)
                    ColorfulShape(color: .brown)
                        .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.8)
                    ColorfulShape(color: .mint)
                        .position(x: geometry.size.width * 0.9, y: geometry.size.height * 0.3)

                    // Контент
                    VStack {
                        Spacer().frame(height: geometry.safeAreaInsets.top + 95)
                        Text("**Poizon Zoom**\n\nМагазин, где твои модные мечты сбываются!")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                            //.background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                        Spacer()
                        VStack {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .offset(y: arrowOffset)
                                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: arrowOffset)
                        }
                            
                            Text("Свайп вверх, чтобы начать")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                                .padding()
                                //.background(Color.gray.opacity(0.4))
                                .cornerRadius(10)
                                .padding(.bottom, 10)
                                .opacity(textOpacity)
                                .animation(.easeIn(duration: 1.5), value: textOpacity)
                            
                                .padding(.bottom, 10)

                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture()
                .onEnded({ value in
                    if value.translation.height < -50 {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            isExpanded = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isActive.toggle()
                            }
                        }
                    }
                }))
            .onAppear {
                withAnimation(.easeIn(duration: 1.5)) {
                    textOpacity = 1
                }
                arrowOffset = -10
            }
        }
    }
}

struct ColorfulShape: View {
    let color: Color
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.7
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 100, height: 100)
            .scaleEffect(scale)
            .opacity(opacity)
            .blur(radius: 20)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    scale = 1.5
                    opacity = 0.3
                }
            }
    }
}

#Preview {
    Onboarding()
}
