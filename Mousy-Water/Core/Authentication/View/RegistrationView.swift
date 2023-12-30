//
//  RegistrationView.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 28/12/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var confirmPassword = ""
    @Environment (\.dismiss)var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
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
                
                InputView(text: $fullname,
                          title: "Nombre completo",
                          placeholder: "Ingresa tu nombre")
                
                
                InputView(text: $password,
                          title: "Contraseña",
                          placeholder:"Ingresa tu contraseña",
                          isSecureField: true)
                
                ZStack(alignment: .trailing){
                    InputView(text: $confirmPassword,
                              title: "Contraseña",
                              placeholder:"Confirma tu contraseña",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        }else{
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top,12)
            
            
            
            //sign in button
            Button{
                Task{
                    try await viewModel.createUser(withEmail:email,
                                                    password:password,
                                                   fullname:fullname)
                }
            }label: {
                HStack{
                    Text("Registrarse")
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
            
            Button{
                dismiss()
            }label:{
                HStack(spacing: 3){
                    Text("Ya tienes una cuenta?")
                    Text("Ingresa")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
            
        }
    }
}

//MARK: - AuthenticationFormProtocol
    
    extension RegistrationView: AuthenticationFormProtocol{
        var formIsValid:Bool{
            return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
            && confirmPassword == password
            && !fullname.isEmpty
        }
    }



struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
