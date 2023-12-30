//
//  ProductsView.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 30/12/23.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Mousy-Water"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.products.count)
                }
                
                
                NavigationLink {
                    ProfileView()
                        
                } label: {
                    SettingsButton()
                }
            }
   
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
