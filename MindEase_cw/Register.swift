//
//  register.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var dateOfBirth = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var navigateToLoginView = false // State to control navigation
    @State private var showErrorMessage = false // State for showing error message

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
                            // Form Fields
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

                            // Show error message if passwords don't match
                            if showErrorMessage {
                                Text("Passwords do not match")
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                                    .padding(.horizontal)
                            }

                            // Sign Up Button
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
            .navigationBarTitleDisplayMode(.inline) // Makes the title inline
            .navigationBarItems(leading: Button(action: {
                navigateToLoginView = true // Trigger navigation to LoginView
            }) {
                Image(systemName: "chevron.backward") // Custom icon for back
                    .foregroundColor(.black) // Black back icon
                    .font(.system(size: 20)) // Adjust the size of the icon
                    .offset(y: 15)
            })
            .background(
                NavigationLink("", destination: LoginView(), isActive: $navigateToLoginView) // Programmatically navigate to LoginView
                    .hidden()
            )
        }
    }

    private func handleSignUp() {
        // Check if passwords match
        if password != confirmPassword {
            showErrorMessage = true
        } else {
            showErrorMessage = false
            // Handle registration logic here (e.g., API call to create user)
        }
    }
}

// Custom Text Field Component
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

// Custom Secure Field Component
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
