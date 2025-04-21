//
//  FirstScreen.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        
            VStack(spacing: 20) {
                Spacer()
                // Header with Logo
                Image("logo") // Add this image to your Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 50)
                
                Text("MindEase")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.top, 10)
                    .offset(x: 5, y: -15)
                
                Spacer()
                
                ZStack{
                    VStack{
                        // Text Fields
                        Spacer()
                               .frame(height: 30)
                        VStack(spacing: 15) {
                            TextField("Enter Username", text: $username)
                                .font(.custom("Reem Kufi", size: 25))
                                .textFieldStyle(.roundedBorder)
                                .frame(maxWidth: .infinity) //
                                .frame(height: 50)
                                .autocapitalization(.none)
                                .padding(.horizontal, 25)
                                
                            
                            SecureField("Enter Password", text: $password)
                                .font(.custom("Reem Kufi", size: 25))
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal, 25)
                                
                        }
                        .padding(.top, 30)
                        
                        // Sign In Button
                        Spacer()
                               .frame(height: 55)
                        Button(action: signIn) {
                            Text("SIGN IN")
                                .font(.custom("Reem Kufi", size: 18))
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 167/255, green: 160/255, blue: 255/255))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                       
                        // Face ID
                        Button(action: useFaceID) {
                            HStack {
                                Text("FACE ID")
                                    .font(.custom("Reem Kufi", size: 18))
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 25)
                            .padding(.top, 10)
                            .font(.subheadline)
                            
                        }
                        .padding(.top, 15)
                        
                        
                        Spacer()
                        
                        // Footer
                        VStack(spacing: 4) {
                            Text("New around here?")
                                .font(.headline)
                                .foregroundColor(.black)
                                .font(.custom("Reem Kufi", size: 10))
                            
                            Text("Create an account")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .font(.custom("Reem Kufi", size: 10))
                        }
                        .padding(.bottom, 35)
                    }
                }
                .background(Color.white)
                .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
            
                
        }
            .background{
                (Color(red: 167/255, green: 160/255, blue: 255/255))
            }
            .ignoresSafeArea()
            
    }
    
    private func signIn() {
        // Handle sign in logic
    }
    
    private func useFaceID() {
        // Handle Face ID authentication
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 10.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
