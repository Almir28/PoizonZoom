//
//  Sing-up.swift
//  NikeStore
//
//  Created by Almir Khialov on 07.06.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

struct Sing_up: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isLoading = false
    @State private var isSinged = false
    
    @Environment(\.presentationMode) var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                // Анимированный фон
                GeometryReader { geometry in
                    ZStack {
                        ColorfulShape(color: .blue)
                            .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.3)
                        ColorfulShape(color: .green)
                            .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.6)
                        ColorfulShape(color: .red)
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.8)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                
                VStack(alignment: .leading, spacing: 40, content: {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss.wrappedValue.dismiss()
                        }
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        Text("Зарегистрироваться")
                            .font(.title)
                        
                        Text("Введите свой адрес электронной почты и продолжайте покупки..")
                            .font(.callout)
                    })
                    
                    VStack(spacing: 15, content: {
                        TextField("Имя пользователя", text: $username)
                            .padding(.horizontal)
                            .frame(height: 60)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay {
                                Capsule()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                            }
                        
                        TextField("Адрес электронной почты", text: $email)
                            .padding(.horizontal)
                            .frame(height: 60)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay {
                                Capsule()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                            }
                        
                        SecureField("Пароль", text: $password)
                            .padding(.horizontal)
                            .frame(height: 60)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                            .overlay {
                                Capsule()
                                    .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                            }
                    })
                    
                    Spacer()
                    VStack(spacing: 15, content: {
                        Button {
                            isLoading.toggle()
                            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                                
                                if error != nil {
                                    print(error?.localizedDescription ?? "")
                                    withAnimation {
                                        isLoading.toggle()
                                    }
                                } else {
                                    
                                    let db = Firestore.firestore()
                                    let data: [String: Any] = [
                                        "User_Name": username,
                                        "Email": email,
                                    ]
                                    
                                    UserDefaults.standard.setValue(result?.user.uid, forKey: "UID")
                                    UserDefaults.standard.setValue(username, forKey: "Name")
                                    UserDefaults.standard.setValue(email, forKey: "Email")
                                    
                                    db.collection("User").addDocument(data: data)
                                    isLoading.toggle()
                                    
                                    isSinged = true
                                }
                            }
                        } label: {
                            if isLoading {
                                ProgressView()
                            } else {
                                Text("Продолжить")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .foregroundStyle(.white)
                        .navigationDestination(isPresented: $isSinged) {
                            ContentView()
                        }
                        
                        NavigationLink {
                            Sing_in()
                        } label: {
                            Text("Уже есть аккаунт? **Войдите**")
                                .frame(maxWidth: .infinity)
                        }
                        .foregroundStyle(.black) // Измените цвет текста на черный для светлого фона
                    })
                })
                .padding()
                .preferredColorScheme(.light) // Измените цветовую схему на светлую
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    Sing_up()
}
