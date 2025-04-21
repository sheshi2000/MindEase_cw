//
//  ContentView.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background color
            Color(red: 167/255, green: 160/255, blue: 255/255)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Centered image
                Spacer().frame(height: 60)
                Image("Image") // Replace with your own image name
                
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                     .padding(.bottom, 10)
                
                     .frame(maxWidth: .infinity)
                        .padding()
                                 // This moves the whole group up from vertical center
                        .offset(y: -80)
                // First line of text - larger font
                
                
                Text("MindEase")
                    .font(.system(size: 34, weight: .bold))
                 .foregroundColor(.black)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .offset(y: -80)
                // Second line of text - smaller font
                Text("Gain insights into your emotional patterns")
                   .font(.custom("Reem Kufi", size: 20))
                  .foregroundColor(.black)
                    .foregroundColor(.black)
                    .offset(y: -80)
            }
            
            
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

