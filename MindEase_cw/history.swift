//
//  history.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import SwiftUI

struct JournalEntry: Identifiable {
    let id = UUID()
    let date: String
    let content: String
}

extension Color {
    static let customPurple = Color(hex: "#A7A0FF")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct HistoryJournalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedPeriod = "Week"
    let periods = ["Day", "Week", "Month", "Year"]
    
    let entries = [
        JournalEntry(date: "24 March 2025", content: "Today was such a good day! I went for a long walk in the park, and the weather was perfect. The sun was....."),
        JournalEntry(date: "22 March 2025", content: "I felt really down today. Work was overwhelming, and I just couldn't focus. I kept thinking about all the thing....."),
        JournalEntry(date: "20 March 2025", content: "Not much happened today. It was just one of those average days. I worked, ate, and watched some TV....."),
        JournalEntry(date: "19 March 2025", content: "I woke up with a heavy feeling in my chest. My mind is racing with thoughts, and I feel restless. I know this ......."),
        JournalEntry(date: "17 March 2025", content: "I woke up with a heavy feeling in my chest. My mind is racing with thoughts, and I feel restless. I know this ..........."),
    ]
    
    private let bottomIcons: [String] = ["house.fill", "list.bullet", "plus.circle.fill", "star", "chart.bar"]
    @State private var selectedTab: String = "list.bullet"

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                // Header Section
                VStack(spacing: 0) {
                    // Remove default back button (blue back button) and handle it manually
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .medium))
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.top, 20) // Increased space at the top for better alignment

                    // Header Title
                    Text("Journal Entries")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10) // Adjusted padding to move it down
                        .offset(y:-40)
                    // Period Selector
                    HStack(spacing: 12) {
                        ForEach(periods, id: \.self) { period in
                            Button(action: {
                                selectedPeriod = period
                            }) {
                                Text(period)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedPeriod == period ? .white : .black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(selectedPeriod == period ? Color.customPurple : Color.white)
                                            .shadow(
                                                color: selectedPeriod == period ?
                                                    Color.customPurple.opacity(0.2) :
                                                    Color.gray.opacity(0.15),
                                                radius: 4,
                                                x: 0,
                                                y: 2
                                            )
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 15)
                    .offset(y:-15)
                    // New Journal Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("New Journal")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .offset(y:5)
                        Text("Start writing your new journal entry here...")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    .offset(y:-15)
                }
                
                // ScrollView for Journal Entries
                ScrollView {
                    VStack(spacing: 20) {
                        // Journal Entries
                        ForEach(entries) { entry in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(entry.date)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                
                                Text(entry.content)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(white: 0.4))
                                    .lineLimit(3)
                                    .lineSpacing(4)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                
                // Bottom Navigation Bar with NavigationLinks
                HStack {
                    ForEach(bottomIcons, id: \.self) { icon in
                        Spacer()
                        VStack(spacing: 4) {
                            if icon == "house.fill" {
                                NavigationLink(destination: HomeView()) {
                                    Image(systemName: icon)
                                        .font(.system(size: 22))
                                        .foregroundColor(icon == selectedTab ? .black : .gray)
                                }
                            } else if icon == "list.bullet" {
                                NavigationLink(destination: HistoryJournalView()) {
                                    Image(systemName: icon)
                                        .font(.system(size: 22))
                                        .foregroundColor(icon == selectedTab ? .black : .gray)
                                }
                            } else if icon == "plus.circle.fill" {
                                NavigationLink(destination: JournalEntryView()) {
                                    Image(systemName: icon)
                                        .font(.system(size: 55))
                                        .foregroundColor(Color.customPurple) // Keep this color fixed for the Add button
                                }
                            } else if icon == "star" {
                                NavigationLink(destination: MotivationalView()) {
                                    Image(systemName: icon)
                                        .font(.system(size: 22))
                                        .foregroundColor(icon == selectedTab ? Color.customPurple : .gray)
                                }
                            } else if icon == "chart.bar" {
                                NavigationLink(destination: InsightView()) {
                                    Image(systemName: icon)
                                        .font(.system(size: 22))
                                        .foregroundColor(icon == selectedTab ? Color.customPurple : .gray)
                                }
                            }

                            if icon != "plus.circle.fill" {
                                Circle()
                                    .fill(icon == selectedTab ? .black : .clear)
                                    .frame(width: 6, height: 6)
                                    .offset(y: -4)
                            }
                        }
                        .onTapGesture {
                            selectedTab = icon
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
            .background(Color.white.ignoresSafeArea())
            .navigationBarBackButtonHidden(true) // Hide the default back button here
        }
    }
}

struct HistoryJournalView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryJournalView()
    }
}
