//
//  Mousy_WaterApp.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 28/12/23.
//  Actualizando

import SwiftUI
import Firebase

@main
struct Mousy_WaterApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
           // ContentView()
                .environmentObject(viewModel)
        }
    }
}
