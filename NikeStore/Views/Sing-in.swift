//
//  Sing-in.swift
//  NikeStore
//
//  Created by Almir Khialov on 07.06.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct Sing_in: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isLoading = false
    
    @State private var isSigned = false
    @State private var showOnboarding = false // Добавлено состояние для онбординга

    @Environment(\.presentationMode) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Анимированный фон
                GeometryReader { geometry in
                    ZStack {
                        ColorfulShape(color: .red)
                            .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.3)
                        ColorfulShape(color: .blue)
                            .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.6)
                        ColorfulShape(color: .green)
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.8)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                
                VStack(alignment: .leading, spacing: 40, content: {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture{
                            showOnboarding = true // Устанавливаем состояние для отображения онбординга
                        }
                    VStack(alignment: .leading,spacing: 15, content: {
                        Text("Войти")
                            .font(.title)
                        
                        Text("Введите ваш адрес электронной почты и продолжайте покупки.")
                            .font(.callout)
                    })
                    
                    VStack(spacing: 15, content: {
                        TextField("Email адрес", text: $email)
                            .padding(.horizontal)
                            .frame(height:60)
                            .background(.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay{
                                Capsule()
                                    .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                            }
                        SecureField("Пароль", text: $password)
                            .padding(.horizontal)
                            .frame(height:60)
                            .background(.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay{
                                Capsule()
                                    .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                            }
                    })
                    
                    Spacer()
                    
                    VStack(spacing: 15, content: {
                        Button{
                            
                            isLoading = true
                            Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
                                
                                if error != nil {
                                    print(error?.localizedDescription ?? "")
                                    withAnimation{
                                        isLoading.toggle()
                                    }
                                }else{
                                    
                                    isSigned = true
                                    
                                    Firestore.firestore()
                                        .collection("User")
                                        .document((result?.user.uid)!)
                                        .getDocument{ (document, error) in
                                  
                                        if let document = document, document.exists {
                                            let name =  document.get("User_Name") as? String ?? ""
                                            let email =  document.get("Email") as? String ?? ""
                                            
                                            UserDefaults.standard.set(name, forKey: "Name")
                                            UserDefaults.standard.set(email, forKey: "Email")
                                            
                                            isLoading.toggle()
                                            
                                        }
                                        
                                        else {
                                            isLoading.toggle()
                                            print("Документ не существует")
                                            
                                        }
                                    }
                                }
                            }
                        }label: {
                            if isLoading {
                                ProgressView()
                            }else{
                                Text("Продолжить")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.purple)
                        .clipShape(Capsule())
                        .foregroundStyle(.white)
                        .navigationDestination(isPresented: $isSigned) {
                            ContentView()
                        }
                        
                        NavigationLink{
                            Sing_up()
                        }label:{
                            Text("Нет аккаунта?**Зарегистрируйтесь**")
                                .frame(maxWidth: .infinity)
                        }
                        .foregroundStyle(.white)
                    })
                })
                .padding()
            }
            .fullScreenCover(isPresented: $showOnboarding) { // Используем fullScreenCover для отображения онбординга
                Onboarding() // Ваш экран онбординга
            }
        }
        .navigationBarHidden(true)
    }
}

