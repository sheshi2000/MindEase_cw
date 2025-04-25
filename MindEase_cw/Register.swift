//
//  register.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var dateOfBirth = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var navigateToHomeView = false
    @State private var showErrorMessage = false
    @State private var errorMessage = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header Section
                    Spacer(minLength: 60)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Register")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .offset(y: -50)

                        Text("Let's start your emotional wellness journey")
                            .foregroundColor(.black)
                            .offset(x: 20, y: -45)
                            .font(.custom("Reem Kufi", size: 18))
                            .padding(.top, 5)
                    }
                    .padding(.top, 40)
                    .padding(.horizontal)

                    ZStack {
                        VStack {
                           
                            VStack(spacing: 18) {
                                CustomTextField(placeholder: "Enter Full Name", text: $firstName)
                                CustomTextField(placeholder: "Enter User Name", text: $lastName)
                                CustomTextField(placeholder: "Enter Email Address", text: $email)
                                    .keyboardType(.emailAddress)
                                CustomTextField(placeholder: "Enter Date of Birth", text: $dateOfBirth)
                                CustomSecureField(placeholder: "Enter Password", text: $password)
                                CustomSecureField(placeholder: "Enter Confirm Password", text: $confirmPassword)
                            }
                            .font(.custom("Reem Kufi", size: 20))
                            .padding(.horizontal)
                            .padding(.top, 25)

                           
                            if showErrorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                                    .padding(.horizontal)
                            }

                           
                            Button(action: handleSignUp) {
                                Text("SIGN UP")
                                    .font(.custom("Reem Kufi", size: 18))
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 167/255, green: 160/255, blue: 255/255))
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            .padding(.top, 35)

                            Spacer(minLength: 200)
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
                }

            }
            .background {
                (Color(red: 167/255, green: 160/255, blue: 255/255))
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .offset(y: 15)
            })
            .background(
                NavigationLink("", destination: HomeView(), isActive: $navigateToHomeView)
                    .hidden()
            )
        }
    }

    private func handleSignUp() {
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showErrorMessage = true
            return
        }

        print(email);
        print(password);
        
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    errorMessage = error.localizedDescription
                    showErrorMessage = true
                    return
                }

            guard let uid = result?.user.uid else {
                errorMessage = "Failed to retrieve user ID"
                showErrorMessage = true
                return
            }

            // Store additional user info in Firestore
            let db = Firestore.firestore()
            db.collection("users").document(uid).setData([
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "dateOfBirth": dateOfBirth,
                "createdAt": Timestamp(date: Date())
            ]) { error in
                if let error = error {
                    errorMessage = "Failed to save user data: \(error.localizedDescription)"
                    showErrorMessage = true
                } else {
                   
                    navigateToHomeView = true
                }
            }
        }
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}


struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
