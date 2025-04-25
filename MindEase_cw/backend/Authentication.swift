//
//  Authentication.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-24.

//import FirebaseAuth
//import FirebaseFirestore
//
//func signUpUser(email: String, password: String, firstName: String, lastName: String) {
//    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//        if let error = error {
//            print("Error signing up: \(error.localizedDescription)")
//            return
//        }
//        
//        guard let user = authResult?.user else { return }
//        
//        // Save user data to Firestore
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(user.uid)
//        userRef.setData([
//            "firstName": firstName,
//            "lastName": lastName,
//            "email": email,
//            "uid": user.uid
//        ]) { error in
//            if let error = error {
//                print("Error saving user data: \(error.localizedDescription)")
//            } else {
//                print("User registered successfully!")
//            }
//        }
//    }
//}

