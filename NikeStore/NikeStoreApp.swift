//
//  NikeStoreApp.swift
//  NikeStore
//
//  Created by Almir Khialov on 07.06.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
// AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
// Main App Structure
@main
struct NikeStore: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            Splash()
                .environmentObject(Database())
        }
    }
}
