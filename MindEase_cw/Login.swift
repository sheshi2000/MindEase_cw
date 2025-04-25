//
//  FirstScreen.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import SwiftUI
import FirebaseAuth
import LocalAuthentication // Import LocalAuthentication for Face ID

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var navigateToRegistration = false
    @State private var navigateToHome = false // Add a state variable for navigation to HomeView
    @State private var showError = false
    @State private var errorMessage = ""

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

                            // Show error message if login fails
                            if showError {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                                    .padding(.top, 10)
                            }

                            Spacer().frame(height: 55)

                            // Sign In Button
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

    // Firebase Sign In function
    private func signIn() {
        // Validate the username and password
        guard !username.isEmpty, !password.isEmpty else {
            showError = true
            errorMessage = "Please enter both username and password"
            return
        }

        // Firebase login logic
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                showError = true
                errorMessage = "Login failed: \(error.localizedDescription)"
            } else {
                // Successful login, navigate to the home view
                navigateToHome = true
            }
        }
    }

    private func useFaceID() {
        // Initialize the authentication context
        let context = LAContext()
        var error: NSError?

        // Check if the device supports Face ID or Touch ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Attempt Face ID authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate with Face ID") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication was successful, sign in to Firebase
                        self.signInWithFaceID()
                    } else {
                        // If authentication fails, show error message
                        self.showError = true
                        self.errorMessage = "Face ID authentication failed: \(authenticationError?.localizedDescription ?? "Unknown error")"
                    }
                }
            }
        } else {
            // If Face ID or Touch ID is not available, show an error
            self.showError = true
            self.errorMessage = "Face ID/Touch ID is not available on this device."
        }
    }

    private func signInWithFaceID() {
        // Perform Firebase sign-in after successful Face ID authentication
        // You can directly sign in using FirebaseAuth if Face ID is successful,
        // assuming that Face ID is linked to the user's credentials.
        
        // This is a placeholder, as Firebase doesn't directly support Face ID sign-in by default.
        // You might need to implement a custom authentication mechanism for this,
        // or use Firebase's email/password sign-in as usual.

        navigateToHome = true // Navigate to home after successful Face ID authentication
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
