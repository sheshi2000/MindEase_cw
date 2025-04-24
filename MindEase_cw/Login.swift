//
//  FirstScreen.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var navigateToRegistration = false
    @State private var navigateToHome = false // Add a state variable for navigation to HomeView

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 167/255, green: 160/255, blue: 255/255)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    // Header with Logo
                    Image("Image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(.top, 50)

                    Text("MindEase")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.top, 10)
                        .offset(x: 5, y: -15)

                    Spacer()

                    ZStack {
                        VStack {
                            Spacer().frame(height: 30)

                            // Text Fields
                            VStack(spacing: 15) {
                                TextField("Enter Username", text: $username)
                                    .font(.custom("Reem Kufi", size: 25))
                                    .textFieldStyle(.roundedBorder)
                                    .frame(height: 50)
                                    .autocapitalization(.none)
                                    .padding(.horizontal, 25)

                                SecureField("Enter Password", text: $password)
                                    .font(.custom("Reem Kufi", size: 25))
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.horizontal, 25)
                            }
                            .padding(.top, 30)

                            Spacer().frame(height: 55)

                            // Sign In Button
                            Button(action: {
                                navigateToHome = true // Set the navigation state to true on button click
                            }) {
                                Text("SIGN IN")
                                    .font(.custom("Reem Kufi", size: 18))
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
                                Text("FACE ID")
                                    .font(.custom("Reem Kufi", size: 18))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 25)
                            .padding(.top, 10)

                            Spacer()

                            // Footer with Navigation
                            VStack(spacing: 4) {
                                Text("New around here?")
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Button(action: {
                                    navigateToRegistration = true
                                }) {
                                    Text("Create an account")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.bottom, 35)

                            // 🔁 NavigationLink inside the view for Registration
                            NavigationLink(
                                destination: RegistrationView(),
                                isActive: $navigateToRegistration
                            ) {
                                EmptyView()
                            }

                            // 🔁 NavigationLink inside the view for Home (when sign-in is successful)
                            NavigationLink(
                                destination: HomeView(),
                                isActive: $navigateToHome
                            ) {
                                EmptyView()
                            }
                        }
                    }
                    .background(Color.white)
                    .frame(width: 400, height: 550)
                    .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
                }
            }
            .navigationBarHidden(true)
        }
    }

    private func signIn() {
        // Handle sign in logic (e.g., validate username and password)
        // On successful sign-in, navigate to the HomeView
        navigateToHome = true
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
