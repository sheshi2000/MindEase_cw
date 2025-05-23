//
//  insight.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//

import SwiftUI
import FirebaseFirestore

struct InsightView: View {
    
    
    
    

    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTab: String = "chart.bar"
    
    @State private var navigateToJournal = false
    @State private var navigateToNewJournal = false
    @State private var navigateToMotivational = false
    @State private var navigateToHome = false

    var body: some View {
        VStack(spacing: 20) {
          
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .medium))
                }
                .padding(.leading)
                .offset(x: -10)
                Spacer()
                
                Text("Mood Calender")
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(Color.black)

                Spacer()
                
                Color.clear
                    .frame(width: 40, height: 40)
            }
            .padding(.horizontal)
            .padding(.top, 80)
            .offset(y: 5)
            
            CalendarView()

            // Mood Chart
            VStack(alignment: .leading) {
                Text("Mood Chart")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 10)
                    .offset(x: 100)

                HStack(alignment: .bottom, spacing: 20) {
                    ForEach(chartData) { item in
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(item.color)
                                .frame(width: 32, height: CGFloat(item.value) * 24)
                                .cornerRadius(4)
                            Text(item.label)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.top, 8)
                        }
                    }
                }
                .frame(height: 220)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)).shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2))
            .padding(.horizontal)

            Spacer()

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
                        if icon == "house.fill" {
                            navigateToHome = true
                        } else if icon == "list.bullet" {
                            navigateToJournal = true
                        } else if icon == "star" {
                            navigateToMotivational = true
                        } else if icon == "plus.circle.fill" {
                            navigateToNewJournal = true
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

         
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $navigateToHome) { EmptyView() }.hidden()
            NavigationLink(destination: HistoryJournalView().navigationBarBackButtonHidden(true), isActive: $navigateToJournal) { EmptyView() }.hidden()
            NavigationLink(destination: JournalEntryView().navigationBarBackButtonHidden(true), isActive: $navigateToNewJournal) { EmptyView() }.hidden()
            NavigationLink(destination: MotivationalView().navigationBarBackButtonHidden(true), isActive: $navigateToMotivational) { EmptyView() }.hidden()
        }
        .background(Color.white.ignoresSafeArea())
    }


    struct ChartItem: Identifiable {
        let id = UUID()
        let label: String
        let value: Double
        let color: Color
    }

    var chartData: [ChartItem] {
        [
            ChartItem(label: "Mon", value: 3, color: Color(red: 216/255, green: 191/255, blue: 216/255)), // Thistle
            ChartItem(label: "Tue", value: 5, color: Color(red: 221/255, green: 160/255, blue: 221/255)), // Plum
            ChartItem(label: "Wed", value: 2, color: Color(red: 230/255, green: 230/255, blue: 250/255)), // Lavender
            ChartItem(label: "Thu", value: 4, color: Color(red: 218/255, green: 112/255, blue: 214/255)), // Orchid
            ChartItem(label: "Fri", value: 6, color: Color(red: 216/255, green: 191/255, blue: 216/255)), // Thistle
            ChartItem(label: "Sat", value: 7, color: Color(red: 221/255, green: 160/255, blue: 221/255)), // Plum
            ChartItem(label: "Sun", value: 4, color: Color(red: 230/255, green: 230/255, blue: 250/255))  // Lavender
        ]
    }

    var bottomIcons: [String] {
        ["house.fill", "list.bullet", "plus.circle.fill", "star", "chart.bar"]
    }
}

struct CalendarView: View {
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let moodEmojis = [
        "happy": "😄",
        "neutral": "😐",
        "sad": "😭",
        "angry": "😠",
        "excited": "😄",
        "stressed": "😩",
        "tired": "😪",
        "unknown": "hi"
    ]


    @State private var moodForDays: [Int: String] = [:]
    @State private var isLoading = true
    var body: some View {
        VStack(alignment: .leading) {
            if isLoading {
                Text("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 16) {
                   
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .bold()
                            .frame(maxWidth: .infinity)
                    }

                    
                    ForEach(1...30, id: \.self) { day in
                        VStack {
                            Text("\(day)")
                                .font(.caption2)
                            Text(moodForDays[day] ?? "❓")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                
                }
                
                .padding(.horizontal)
            }
        }
        .onAppear {
            fetchMoodEntries()
        }
    }
    
    
    private func fetchMoodEntries() {
        let db = FirestoreService.shared
        let startDate = getStartOfMonth()
        let endDate = getEndOfMonth()

        db.fetchJournalEntries(from: startDate, to: endDate) { result in
            switch result {
            case .success(let journalEntries):
                var moodData: [Int: String] = [:]
                for entry in journalEntries {
                    let day = getDayFromTimestamp(entry.timestamp)
                    
                    
                    print("Mood for day \(day): \(entry.mood)")
                    
                 
                    let normalizedMood = entry.mood.lowercased()
                    let moodEmoji = moodEmojis[normalizedMood] ?? "❓"
                    moodData[day] = moodEmoji
                }

                DispatchQueue.main.async {
                    self.moodForDays = moodData
                    self.isLoading = false
                }
            case .failure(let error):
                print("Error fetching mood entries: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }



    
    
    private func getStartOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        return calendar.date(from: components) ?? Date()
    }
    
  
    private func getEndOfMonth() -> Date {
        let calendar = Calendar.current
        if let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())),
           let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) {
            return endOfMonth
        }
        return Date()
    }
    
  
    private func getDayFromTimestamp(_ timestamp: Timestamp) -> Int {
        let date = timestamp.dateValue()
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
}

struct InsightView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InsightView()
        }
    }
}
