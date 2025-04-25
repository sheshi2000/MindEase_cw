//
//  HomeView.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import SwiftUI

struct HomeView: View {
    @State private var selectedTab: String = "house.fill"
    @State private var navigateToJournal = false
    @State private var navigateToNewJournal = false
    @State private var navigateToMotivational = false
    @State private var navigateToInsight = false
    @State private var navigateToProfile = false
    @State private var chartPeriod: String = "Weekly"
    @State private var selectedMoodEmoji: String? = nil

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack(spacing: 4) {
                                Text("Hello, Harry")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                                Text("👋")
                            }
                            Text("Your well-being journey starts here.")
                                .font(.subheadline)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        Spacer()
                        Button(action: {
                            navigateToProfile = true
                        }) {
                            Image("profile 1")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        .offset(x: -10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 110)
                    .offset(y: -12)
                    .offset(x: 6)
                }

                // Motivational Quote
                HStack {
                    Image("flower")
                    Text("Every storm runs out of rain. Hold on, brighter days are coming!")
                        .font(.system(size: 18, weight: .medium))
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(Color(red: 248/255, green: 226/255, blue: 255/255))
                .cornerRadius(12)
                .padding(.horizontal)

           
                HStack(spacing: 16) {
                    ForEach(["Happy", "Sad", "Bored", "Tired", "Angry", "Stressed"], id: \.self) { mood in
                        VStack {
                            Spacer().frame(height: 10)
                            Text(emoji(for: mood))
                                .font(.system(size: 35))
                                .onTapGesture {
                                    selectedMoodEmoji = emoji(for: mood)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        withAnimation {
                                            selectedMoodEmoji = nil
                                        }
                                    }
                                }
                            Text(mood)
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer().frame(height: 20)

                // Mood Chart
                VStack(alignment: .leading) {
                    HStack {
                        Text("Mood Chart")
                            .font(.system(size: 20, weight: .medium))

                        Spacer()

                        Menu {
                            Button(action: { chartPeriod = "Weekly" }) {
                                Text("Weekly").foregroundColor(.black)
                            }
                            Button(action: { chartPeriod = "Monthly" }) {
                                Text("Monthly").foregroundColor(.black)
                            }
                        } label: {
                            HStack {
                                Text(chartPeriod).foregroundColor(.black)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 15)

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
                                    .padding(.top, 10)
                            }
                        }
                    }
                    .frame(height: 220)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
                )
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer()

                // Bottom Navigation
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
                            case "list.bullet": navigateToJournal = true
                            case "star": navigateToMotivational = true
                            case "chart.bar": navigateToInsight = true
                            case "plus.circle.fill": navigateToNewJournal = true
                            default: break
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

                
                NavigationLink(destination: HistoryJournalView().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $navigateToJournal) { EmptyView() }.hidden()
                NavigationLink(destination: JournalEntryView().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $navigateToNewJournal) { EmptyView() }.hidden()
                NavigationLink(destination: MotivationalView().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $navigateToMotivational) { EmptyView() }.hidden()
                NavigationLink(destination: InsightView().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $navigateToInsight) { EmptyView() }.hidden()
                NavigationLink(destination: EditProfileView().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $navigateToProfile) { EmptyView() }.hidden()
            }
            .background(Color.white.ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)

          
            if let emoji = selectedMoodEmoji {
                ZStack {
                    Color.black.opacity(0.2).ignoresSafeArea()
                    Text(emoji)
                        .font(.system(size: 170))
                        .transition(.opacity)
                        .opacity(selectedMoodEmoji == nil ? 0 : 1)
                }
                .animation(.easeInOut(duration: 0.5), value: selectedMoodEmoji)
            }
        }
    }

    struct ChartItem: Identifiable {
        let id = UUID()
        let label: String
        let value: Double
        let color: Color
    }

    var weeklyChartData: [ChartItem] {
        [
            ChartItem(label: "Mon", value: 3, color: .purple.opacity(0.5)),
            ChartItem(label: "Tue", value: 5, color: .purple.opacity(0.6)),
            ChartItem(label: "Wed", value: 2, color: .purple.opacity(0.4)),
            ChartItem(label: "Thu", value: 4, color: .purple.opacity(0.7)),
            ChartItem(label: "Fri", value: 6, color: .purple.opacity(0.5)),
            ChartItem(label: "Sat", value: 7, color: .purple.opacity(0.6)),
            ChartItem(label: "Sun", value: 4, color: .purple.opacity(0.4))
        ]
    }

    var monthlyChartData: [ChartItem] {
        [
            ChartItem(label: "Jan", value: 4, color: .purple.opacity(0.5)),
            ChartItem(label: "Feb", value: 6, color: .purple.opacity(0.6)),
            ChartItem(label: "Mar", value: 3, color: .purple.opacity(0.4)),
            ChartItem(label: "Apr", value: 5, color: .purple.opacity(0.7)),
            ChartItem(label: "May", value: 7, color: .purple.opacity(0.5)),
            ChartItem(label: "Jun", value: 8, color: .purple.opacity(0.6)),
            ChartItem(label: "Jul", value: 6, color: .purple.opacity(0.4))
        ]
    }

    var chartData: [ChartItem] {
        chartPeriod == "Weekly" ? weeklyChartData : monthlyChartData
    }

    func emoji(for mood: String) -> String {
        switch mood {
        case "Happy": return "😄"
        case "Sad": return "😭"
        case "Bored": return "😐"
        case "Tired": return "😪"
        case "Angry": return "😠"
        case "Stressed": return "😩"
        default: return "❓"
        }
    }

    var bottomIcons: [String] {
        ["house.fill", "list.bullet", "plus.circle.fill", "star", "chart.bar"]
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
