import FirebaseFirestore
import FirebaseAuth

struct UserJournalEntry {
    let mood: String
    let text: String
    let timestamp: Timestamp
}

class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()

    // Save User Profile Data
    func saveUserProfile(uid: String, firstName: String, lastName: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "createdAt": Timestamp(date: Date())
        ]
        
        // Save the user profile data in the 'users' collection, using the user's UID as the document ID
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Save Journal Entry Data
    func saveJournalEntry(userId: String, text: String, mood: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let entryData: [String: Any] = [
            "userId": userId,
            "text": text,
            "mood": mood,
            "timestamp": Timestamp()
        ]

        // Save the journal entry data in the 'journals' collection
        db.collection("journals").addDocument(data: entryData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchJournalEntries(from startDate: Date, to endDate: Date, completion: @escaping (Result<[UserJournalEntry], Error>) -> Void) {
            let startTimestamp = Timestamp(date: startDate)
            let endTimestamp = Timestamp(date: endDate)

            db.collection("journalEntries")
                .whereField("timestamp", isGreaterThanOrEqualTo: startTimestamp)
                .whereField("timestamp", isLessThanOrEqualTo: endTimestamp)
                .order(by: "timestamp", descending: true)
                .getDocuments { snapshot, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let documents = snapshot?.documents else {
                        completion(.success([]))
                        return
                    }

                    let journalEntries = documents.compactMap { doc -> UserJournalEntry? in
                        let data = doc.data()
                        guard
                            let text = data["text"] as? String,
                            let mood = data["mood"] as? String,
                            let timestamp = data["timestamp"] as? Timestamp
                        else {
                            return nil
                        }
                        return UserJournalEntry(mood: mood, text: text, timestamp: timestamp)
                    }

                    completion(.success(journalEntries))
                }
        }
}
