//
//  AuthViewModel.swift
//  Mousy-Water
//
//  Created by Paul Jaime Felix Flores on 28/12/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

protocol AuthenticationFormProtocol{
    var formIsValid: Bool {
        get
    }
}

@MainActor
class AuthViewModel:ObservableObject{
    @Published var currentUser: User?
    @Published var userSession: FirebaseAuth.User?
   
   
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
            
        }
    }
    
    func signIn(withEmail email: String, password: String)async throws{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            
        }catch{
            print("DEBUG:Failed to log in \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email:String,password: String,fullname:String)async throws{
        print("Crear usuario")
        
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id:result.user.uid,fullname:fullname,email:email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch{
            print("DEBUG:Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()//sign out user backend
            self.userSession = nil //wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        }catch{
            print("DEBUG:Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(){
        
    }
    
    func fetchUser()async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try?await Firestore.firestore().collection("users").document(uid).getDocument()else{return}
        self.currentUser = try? snapshot.data(as:User.self)
        print ("DEBUG: Current user is \(self.currentUser)")
    }
    
}
