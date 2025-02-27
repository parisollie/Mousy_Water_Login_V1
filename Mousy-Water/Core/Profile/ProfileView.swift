//
//  ProfileView.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 28/12/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser{
            List{
                Section{
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72,height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                
                }
                Section("General"){
                    HStack{
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                Section("Account"){
                    Button{
                        viewModel.signOut()
                    }label:{
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Salir",
                                        tintColor: .red)
                    }
                    
                    /*Button{
                        print("Borrar cuenta")
                    }label:{
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Eliminar cuenta",
                                        tintColor: .red)
                    }*/
                    
                }
                
            }
        }
    }
}


