//
//  profile.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-22.
//
import SwiftUI

struct EditProfileView: View {
    private let bottomIcons: [String] = ["house.fill", "list.bullet", "plus.circle.fill", "star", "chart.bar"]
    @State private var selectedTab: String? = "list.bullet"
    @State private var path = NavigationPath()

    @State private var firstName = "Harry"
    @State private var lastName = "Styles"
    @State private var userName = "Harry"
    @State private var email = "Harrystyles02@gmail.com"
    @State private var mobile = "+9752389063"
    @State private var gender = "Male"

    @State private var scrolledDown = false

    // New state for showing alert after saving changes
    @State private var showSaveAlert = false

    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                currentEditProfileContent

                // Bottom Navigation Bar
                HStack {
                    ForEach(bottomIcons, id: \.self) { icon in
                        Spacer()
                        VStack(spacing: 4) {
                            Image(systemName: icon)
                                .font(.system(size: icon == "plus.circle.fill" ? 55 : 22))
                                .foregroundColor(
                                    icon == "plus.circle.fill" ? Color(hex: "#A7A0FF") :
                                    (icon == selectedTab ? .black : .gray)
                                )

                            if icon != "plus.circle.fill" && icon != "list.bullet" {
                                Circle()
                                    .fill(icon == selectedTab ? .black : .clear)
                                    .frame(width: 6, height: 6)
                                    .offset(y: -4)
                            }
                        }
                        .onTapGesture {
                            selectedTab = icon
                            switch icon {
                            case "house.fill":
                                path.append("Home")
                            case "plus.circle.fill":
                                path.append("Journal")
                            case "star":
                                path.append("Motivational")
                            case "chart.bar":
                                path.append("Insight")
                            default:
                                break
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(radius: 4)
                .padding(.horizontal)
            }
            .background(Color(red: 0.97, green: 0.97, blue: 0.97).ignoresSafeArea())
            .navigationBarHidden(true)
            .navigationDestination(for: String.self) { route in
                switch route {
                case "Home":
                    HomeView().navigationBarBackButtonHidden(true)
                case "Journal":
                    JournalEntryView().navigationBarBackButtonHidden(true)
                case "Motivational":
                    MotivationalView().navigationBarBackButtonHidden(true)
                case "Insight":
                    InsightView().navigationBarBackButtonHidden(true)
                default:
                    EditProfileView().navigationBarBackButtonHidden(true)
                }
            }
            .alert(isPresented: $showSaveAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Your changes have been saved."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // Reusable field view
    private func field(title: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
            TextField("Enter \(title)", text: text)
                .keyboardType(keyboard)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .frame(height: 45)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
        .padding(.bottom, 10)
    }

    private var currentEditProfileContent: some View {
        ScrollView {
            GeometryReader { geo in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
            }
            .frame(height: 0)

            VStack(alignment: .leading, spacing: 20) {
                ZStack(alignment: .topTrailing) {
                    VStack {
                        Text(scrolledDown ? "Edit Profile" : "My Profile")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Image("profile 1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }

                    Button(action: {
                        print("Edit tapped")
                    }) {
                        Image(systemName: "pencil")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color(hex: "#A7A0FF"))
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .offset(y: 160)
                    .offset(x: -100)
                }
                .padding(.horizontal)
                .padding(.top, 5)

                VStack(spacing: 15) {
                    Group {
                        field(title: "First Name", text: $firstName)
                        field(title: "Last Name", text: $lastName)
                        field(title: "User Name", text: $userName)
                        field(title: "Email Address", text: $email, keyboard: .emailAddress)
                        field(title: "Mobile Number", text: $mobile, keyboard: .phonePad)
                        field(title: "Gender", text: $gender)
                    }

                    HStack {
                        Spacer()
                        Button(action: {
                            // When the button is tapped, show the success alert
                            showSaveAlert = true
                        }) {
                            Text("Save Changes")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .frame(height: 45)
                                .background(Color(hex: "#A7A0FF"))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                        }
                    }
                }
                .padding()
                
                Spacer().frame(height: 100)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// Scroll position preference key
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
