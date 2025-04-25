//
//  FirstScreen.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import SwiftUI
import FirebaseAuth
import LocalAuthentication

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var navigateToRegistration = false
    @State private var navigateToHome = false
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 167/255, green: 160/255, blue: 255/255)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    
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

                            
                            if showError {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                                    .padding(.top, 10)
                            }

                            Spacer().frame(height: 55)

                          
                            Button(action: signIn) {
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

                           
                            NavigationLink(
                                destination: RegistrationView(),
                                isActive: $navigateToRegistration
                            ) {
                                EmptyView()
                            }

                          
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
        // Validate the username and password
        guard !username.isEmpty, !password.isEmpty else {
            showError = true
            errorMessage = "Please enter both username and password"
            return
        }

      
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                showError = true
                errorMessage = "Login failed: \(error.localizedDescription)"
            } else {
                
                navigateToHome = true
            }
        }
    }

    private func useFaceID() {
       
        let context = LAContext()
        var error: NSError?

        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate with Face ID") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                      
                        self.signInWithFaceID()
                    } else {
                     
                        self.showError = true
                        self.errorMessage = "Face ID authentication failed: \(authenticationError?.localizedDescription ?? "Unknown error")"
                    }
                }
            }
        } else {
         
            self.showError = true
            self.errorMessage = "Face ID/Touch ID is not available on this device."
        }
    }

    private func signInWithFaceID() {
        
        navigateToHome = true 
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
