//
//  LoginView.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 28/12/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel : AuthViewModel
    
    
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Image("mousy-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:100,height: 120)
                    .padding(.vertical,32)
                
                
                //form fields
                VStack(spacing: 24){
                    InputView(text: $email,
                              title: "Correo electronico",
                              placeholder: "nombre@ejemplo.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Contraseña",
                              placeholder:"Ingresa tu contraseña",
                              isSecureField: true)
                    
                    
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                //sign in button
                
                Button{
                    Task{
                        try await viewModel.signIn(withEmail: email ,password: password)
                    }
                }label: {
                    HStack{
                        Text("Iniciar sesión")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32 , height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                Spacer()
                //sign up bottom
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                }label:{
                    HStack(spacing: 3){
                        Text("No tienes una cuenta?")
                        Text("Registrate")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

//MARK: - AuthenticationFormProtocol
    
    extension LoginView: AuthenticationFormProtocol{
        var formIsValid:Bool{
            return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
        }
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }

