//
//  ContentView.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 28/12/23.
// SIRVE

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                //ProductsView()
                ProfileView()
            }else{
                LoginView()
            }
        }
    }
}


