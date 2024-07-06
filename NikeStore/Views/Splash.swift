//
//  Splash.swift
//  NikeStore
//
//  Created by Almir Khialov on 07.06.2024.
//
import SwiftUI
import FirebaseCore
import FirebaseAuth

struct Splash: View {
    @State private var isActive = false
    @State private var logoOffset = CGSize(width: 0, height: -200)
    @State private var burstScale: CGFloat = 1.0
    
    let burstColors = [Color.red, Color.blue, Color.green, Color.yellow, Color.purple]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.8, blue: 0.8), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if isActive {
                    if Auth.auth().currentUser != nil {
                        ContentView()
                    } else {
                        Onboarding()
                    }
                } else {
                    Text("Poizon Zoom")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .offset(logoOffset)
                    
                    ZStack {
                        ForEach(0..<10) { _ in
                            Circle()
                                .fill(burstColors.randomElement()!)
                                .frame(width: 10, height: 10)
                                .scaleEffect(burstScale)
                                .offset(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: -50...50))
                                .blendMode(.screen)
                        }
                    }
                    .frame(height: 100)
                }
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2)) {
                logoOffset = .zero
            }
            
            withAnimation(Animation.easeInOut(duration: 0.8).repeatForever()) {
                burstScale = 2.5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
