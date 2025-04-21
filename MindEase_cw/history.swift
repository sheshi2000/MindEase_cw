//
//  history.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//

import Foundation

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
    @State private var selectedPeriod = "Week"
    let periods = ["Day", "Week", "Month", "Year"]
    
    let entries = [
        JournalEntry(date: "24 March 2025", content: "Today was such a good day! I went for a long walk in the park, and the weather was perfect. The sun was....."),
        JournalEntry(date: "22 March 2025", content: "I felt really down today. Work was overwhelming, and I just couldn't focus. I kept thinking about all the thing....."),
        JournalEntry(date: "20 March 2025", content: "Not much happened today. It was just one of those average days. I worked, ate, and watched some TV....."),
        JournalEntry(date: "19 March 2025", content: "I woke up with a heavy feeling in my chest. My mind is racing with thoughts, and I feel restless. I know this ....."),
        JournalEntry(date: "17 March 2025", content: "Feeling frustrated today. I had an argument with a friend, and I can't stop replaying it in my head. I hate ....."),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                Text("Journal Entries")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 25)
                
                // Period Selector
                HStack(spacing: 12) {
                    ForEach(periods, id: \.self) { period in
                        Button(action: { selectedPeriod = period }) {
                            Text(period)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(period == "Week" ? .white : .black)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(period == "Week" ? Color.customPurple : Color.white)
                                        .shadow(
                                            color: period == "Week" ?
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
                
                // New Journal Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("New Journal")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                    
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
                
                // Journal Entries
                VStack(spacing: 20) {
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
                                .fill(Color(red: 0.92, green: 0.92, blue: 0.93)) // Darker gray
                                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 30)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct HistoryJournalView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryJournalView()
    }
}

