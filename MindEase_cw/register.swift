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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section
                Spacer(minLength: 60)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Register")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: -25)
                    
                    
                    Text("Let's start your emotional wellness journey")
                        .foregroundColor(.black)
                        .offset(x: 20, y: -20)
                        .font(.custom("Reem Kufi", size: 17))

                }
                .padding(.top, 40)
                .padding(.horizontal)
                
                
                ZStack{
                    VStack{
                        // Form Fields
                        VStack(spacing: 18) {
                            CustomTextField(placeholder: "Enter First Name", text: $firstName)
                            CustomTextField(placeholder: "Enter Last Name", text: $lastName)
                            CustomTextField(placeholder: "Enter Email Address", text: $email)
                                .keyboardType(.emailAddress)
                            CustomTextField(placeholder: "Enter Date of Birth", text: $dateOfBirth)
                            CustomSecureField(placeholder: "Enter Password", text: $password)
                            CustomSecureField(placeholder: "Enter Confirm Password", text: $confirmPassword)
                        }
                        .font(.custom("Reem Kufi", size: 20))
                        .padding(.horizontal)
                        .padding(.top, 25)
                        
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
        .background{
            (Color(red: 167/255, green: 160/255, blue: 255/255))
        }
        .ignoresSafeArea()
    }
    
     
    private func handleSignUp() {
        // Handle registration logic here
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

