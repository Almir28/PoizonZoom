//
//  ProfileView.swift
//  NikeStore
//
//  Created by Almir Khialov on 26.06.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct ProfileView: View {
    @State private var userImage: UIImage?
    @State private var showingImagePicker = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var purchaseHistory: [String] = []
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    profileImageView
                    userInfoView
                    favoritesView
                    purchaseHistoryView
                    signOutButton
                }
                .padding()
            }
            .navigationTitle("Profile")
            .navigationBarItems(trailing: editButton)
        }
        .onAppear(perform: loadUserData)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $userImage, sourceType: .photoLibrary)
        }
    }
    
    var profileImageView: some View {
        ZStack {
            if let userImage = userImage {
                Image(uiImage: userImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
            
            Button(action: {
                showingImagePicker = true
            }) {
                Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            }
            .offset(x: 50, y: 50)
        }
        .padding(.top, 20)
        .animation(.spring(), value: userImage)
    }
    
    var userInfoView: some View {
        VStack(spacing: 15) {
            if isEditing {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text("\(firstName) \(lastName)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            Text(email)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .animation(.easeInOut, value: isEditing)
    }
    
    var favoritesView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Favorites")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<5) { _ in
                        VStack {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                                .frame(width: 80, height: 80)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Text("Favorite Item")
                                .font(.caption)
                                .lineLimit(1)
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
    
    var purchaseHistoryView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Purchase History")
                .font(.headline)
                .padding(.horizontal)
            
            if purchaseHistory.isEmpty {
                Text("No purchases yet")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                ForEach(purchaseHistory, id: \.self) { purchase in
                    HStack {
                        Image(systemName: "bag.fill")
                            .foregroundColor(.green)
                        Text(purchase)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    var signOutButton: some View {
        Button("Sign Out") {
            signOut()
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.red)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    var editButton: some View {
        Button(action: {
            withAnimation {
                if isEditing {
                    saveUserData()
                }
                isEditing.toggle()
            }
        }) {
            Text(isEditing ? "Save" : "Edit")
        }
    }
    
    func loadUserData() {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        db.collection("User").document(user.uid).getDocument { document, error in
            if let document = document, document.exists {
                self.firstName = document.data()?["FirstName"] as? String ?? ""
                self.lastName = document.data()?["LastName"] as? String ?? ""
                self.email = document.data()?["Email"] as? String ?? ""
                self.purchaseHistory = document.data()?["PurchaseHistory"] as? [String] ?? []
            }
        }
        
        let storageRef = Storage.storage().reference().child("user_images/\(user.uid).jpg")
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
            } else if let data = data, let image = UIImage(data: data) {
                self.userImage = image
            }
        }
    }
    
    func saveUserData() {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        db.collection("User").document(user.uid).updateData([
            "FirstName": firstName,
            "LastName": lastName
        ]) { error in
            if let error = error {
                print("Error updating user data: \(error)")
            } else {
                print("User data updated successfully")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            // Navigate to login screen or update app state
        } catch {
            print("Error signing out: \(error)")
        }
    }
}
