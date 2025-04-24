//
//  motivational.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import SwiftUI


struct MotivationalView: View {
    private let bottomIcons: [String] = ["house.fill", "list.bullet", "plus.circle.fill", "star", "chart.bar"]
    @State private var selectedTab: String = "star" // Current screen

    @State private var navigateToHome = false
    @State private var navigateToJournal = false
    @State private var navigateToNewJournal = false
    @State private var navigateToInsight = false

    // Array of quotes and corresponding background colors
    private let quotes = [
        ("Your mind is a powerful thing. When you fill it with positive thoughts, your life will start to change.", "- Unknown", Color(red: 216/255, green: 191/255, blue: 216/255)), // Thistle
        ("Believe you can and you're halfway there.", "- Theodore Roosevelt", Color(red: 230/255, green: 230/255, blue: 250/255)), // Lavender
        ("The only way to do great work is to love what you do.", "- Steve Jobs", Color(red: 230/255, green: 230/255, blue: 250/255)), // Lavender
        ("Success is not the key to happiness. Happiness is the key to success.", "- Albert Schweitzer", Color(red: 221/255, green: 160/255, blue: 221/255)), // Plum
        ("The future belongs to those who believe in the beauty of their dreams.", "- Eleanor Roosevelt", Color(red: 216/255, green: 191/255, blue: 216/255))  // Thistle
    ]
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 15) {
                // Custom Navigation Bar
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium))
                    }

                    Spacer()

                    Text("Motivation")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()
                }
                .padding()
                .background(Color.white)

                Spacer()

                // Quote Card with swipe functionality
                TabView {
                    ForEach(quotes, id: \.0) { quote in
                        VStack(spacing: 20) {
                            Text(quote.0)
                                .font(.title2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .lineSpacing(8)
                                .padding(.horizontal, 30)
                                .padding(.vertical)

                            Text(quote.1)
                                .font(.subheadline)
                                .italic()
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(quote.2)
                                .padding(20)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                        )
                        .padding()
                    }
                }
                .frame(height: 480)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

                Spacer()

                // Cancel Button
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .font(.custom("Reem Kufi", size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 120)
                        .background(Color(hex: "#A7A0FF"))
                        .cornerRadius(12)
                }
                .padding(.bottom, 120)
            }

            // Bottom Navigation Bar
            HStack {
                ForEach(bottomIcons, id: \.self) { icon in
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: icon)
                            .font(.system(size: icon == "plus.circle.fill" ? 55 : 22))
                            .foregroundColor(icon == "plus.circle.fill" ? Color(red: 167/255, green: 160/255, blue: 255/255) : (icon == selectedTab ? .black : .gray))

                        if icon != "plus.circle.fill" {
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
                            navigateToHome = true
                        case "list.bullet":
                            navigateToJournal = true
                        case "plus.circle.fill":
                            navigateToNewJournal = true
                        case "chart.bar":
                            navigateToInsight = true
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

            // Navigation Links
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $navigateToHome) { EmptyView() }.hidden()
            NavigationLink(destination: HistoryJournalView().navigationBarBackButtonHidden(true), isActive: $navigateToJournal) { EmptyView() }.hidden()
            NavigationLink(destination: JournalEntryView().navigationBarBackButtonHidden(true), isActive: $navigateToNewJournal) { EmptyView() }.hidden()
            NavigationLink(destination: InsightView().navigationBarBackButtonHidden(true), isActive: $navigateToInsight) { EmptyView() }.hidden()
        }
        .navigationBarBackButtonHidden(true)
    }
}



struct MotivationalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MotivationalView()
        }
    }
}
