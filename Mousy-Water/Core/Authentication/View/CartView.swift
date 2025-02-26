//
//  CartView.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 30/12/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ScrollView {
            if cartManager.paymentSuccess {
                Text("Gracias por tu compra, hemos recibido tu pedido, dentro de poco obtendrás tu pedido en tu casa.")
                    .padding()
            } else {
                if cartManager.products.count > 0 {
                    ForEach(cartManager.products, id: \.id) { product in
                        ProductRow(product: product)
                    }
                    
                    HStack {
                        Text("El total de tu carrito es:")
                        Spacer()
                        Text("$\(cartManager.total).00 mx")
                            .bold()
                    }
                    .padding()
                    
                    PaymentButton(action: cartManager.pay)
                        .padding()
                    
                } else {
                    Text("Tu carrito esta vacio.")
                }
            }
        }
        .navigationTitle(Text("Mi carrito"))
        .padding(.top)
        .onDisappear {
            if cartManager.paymentSuccess {
                cartManager.paymentSuccess = false
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
