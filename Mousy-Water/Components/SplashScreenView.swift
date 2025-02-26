//
//  SplashScreenView.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 30/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject var viewModel = AuthViewModel()
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(viewModel)
        } else {
            VStack {
                VStack {
                    Image("mousy-logo")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text("Mousy-Water")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}


