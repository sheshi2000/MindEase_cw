//
//  Authentication.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-24.


import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var user: User?
    
    init() {
        self.user = Auth.auth().currentUser
        Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        self.user = nil
    }
}
