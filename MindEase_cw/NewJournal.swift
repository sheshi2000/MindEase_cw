//
//  newJournal.swift
//  MindEase_cw
//
//  Created by Sheshami 029 on 2025-04-21.
//
import SwiftUI
import FirebaseFirestore

struct JournalEntryView: View {
    @State private var journalText = ""
    @State private var detectedMood = "Unknown" // Default mood is "Unknown"
    @State private var selectedTab: String = "plus.circle.fill"
    @State private var isEditing: Bool = false
    @State private var hasTextChanged: Bool = false
    @State private var showSavedAlert = false

    private let bottomIcons: [String] = ["house.fill", "list.bullet", "plus.circle.fill", "star", "chart.bar"]

    @State private var navigateToHome = false
    @State private var navigateToJournal = false
    @State private var navigateToMotivation = false
    @State private var navigateToInsight = false

    @State private var currentDate: String = "" // State variable for the current date
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Top Bar
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .medium))
                            }
                            .padding(.leading)

                            Spacer()

                            Text("Journal Entry")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)

                            Spacer()
                        }
                        .padding(.top, 20)

                        // Date & Done Button
                        HStack {
                            Text(currentDate) // Use the dynamic current date
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.18))

                            Spacer()

                            if hasTextChanged {
                                Text("Done")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 167/255, green: 160/255, blue: 255/255))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        saveJournalText()
                                        isEditing = false
                                        hasTextChanged = false
                                    }
                            }
                        }
                        .padding(.horizontal)

                        // Journal Content
                        VStack(alignment: .leading, spacing: 16) {
                            TextEditor(text: $journalText)
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .lineSpacing(8)
                                .padding(12)
                                .frame(minHeight: 450, alignment: .topLeading)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 2)
                                .padding(.bottom, 40)
                                .onChange(of: journalText) { newValue in
                                    hasTextChanged = !newValue.isEmpty
                                }

                            if !detectedMood.isEmpty {
                                Text("Your Mood is: \(detectedMood)")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.horizontal)

                        Spacer().frame(height: 160)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Floating Edit Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .font(.system(size: 28))
                                .foregroundColor(.black)
                                .padding(18)
                                .background(Color(red: 167/255, green: 160/255, blue: 255/255))
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                        .padding(.trailing, 15)
                        .padding(.bottom, 110)
                    }
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
                                case "house.fill": navigateToHome = true
                                case "list.bullet": navigateToJournal = true
                                case "star": navigateToMotivation = true
                                case "chart.bar": navigateToInsight = true
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

                // Navigation Links
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $navigateToHome) { EmptyView() }.hidden()
                NavigationLink(destination: HistoryJournalView().navigationBarBackButtonHidden(true), isActive: $navigateToJournal) { EmptyView() }.hidden()
                NavigationLink(destination: MotivationalView().navigationBarBackButtonHidden(true), isActive: $navigateToMotivation) { EmptyView() }.hidden()
                NavigationLink(destination: InsightView().navigationBarBackButtonHidden(true), isActive: $navigateToInsight) { EmptyView() }.hidden()
            }
            .background(Color(red: 0.97, green: 0.97, blue: 0.97).ignoresSafeArea())
            .navigationBarHidden(true)
            .alert("Journal Saved!\nDetected Mood: \(detectedMood)", isPresented: $showSavedAlert) {
                Button("OK", role: .cancel) { }
            }
            .onAppear {
                // Set current date when the view appears
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEE, MMM d, yyyy"
                currentDate = dateFormatter.string(from: Date())
            }
        }
    }

    // Save to Firebase (without NLP mood detection)
    func saveJournalText() {
        // Using "Unknown" for mood since NLP is not available
        detectedMood = "Unknown"

        let db = Firestore.firestore()
        
        // Prepare the journal data
        let journalData: [String: Any] = [
            "text": journalText,
            "mood": detectedMood,
            "timestamp": Timestamp(date: Date())
        ]

        // Save the journal entry to Firestore
        db.collection("journalEntries").addDocument(data: journalData) { error in
            if let error = error {
                print("Error saving journal: \(error.localizedDescription)")
            } else {
                print("Journal saved to Firestore!")
                showSavedAlert = true
                journalText = ""
                hasTextChanged = false
            }
        }
    }
}

struct JournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        JournalEntryView()
    }
}
