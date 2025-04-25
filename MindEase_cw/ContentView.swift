//
//  ContentView.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var showLogin = false
    init() {
            FirebaseApp.configure() 
        }
    
    var body: some View {
        Group {
            if showLogin {
                LoginView()
            } else {
                ZStack {
                    // Background color
                    Color(red: 167/255, green: 160/255, blue: 255/255)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Spacer().frame(height: 60)
                        
                        Image("Image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.bottom, 10)
                            .offset(y: -80)

                        Text("MindEase")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.black)
                            .offset(y: -80)

                        Text("Gain insights into your emotional patterns")
                            .font(.custom("Reem Kufi", size: 20))
                            .foregroundColor(.black)
                            .offset(y: -80)
                    }
                    .padding()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showLogin = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
